import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samrt_health/event/auth/authentication_event.dart';
import 'package:samrt_health/repository/user_repository.dart';
import 'package:samrt_health/state/auth/authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepo;

  AuthenticationBloc({required UserRepository? userRepository})
      : assert(userRepository != null),
        userRepo = userRepository!,
        super(userRepository.getUser() != null
            ? Authenticated.copyWith(user: userRepository.getUser()!)
            : Unauthenticated());

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if(event is CheckLogin){
      final User? user = userRepo.getUser();
      if (user != null) {
        yield Authenticated.copyWith(user: user);
      } else {
        yield Unauthenticated();
      }
    }
    if(event is SignOut){
      await userRepo.signOut();
      yield  Unauthenticated();
    }
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is LoggedIn || event is LoginByGoogle) {
      yield* _mapLoggedInToState(event);
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    try {
      final isSignedIn = await userRepo.isSignedIn();
      if (isSignedIn) {
        final User? user = userRepo.getUser();
        if (user != null) {
          yield Authenticated.copyWith(user: user);
        } else {
          yield Unauthenticated();
        }
      } else {
        yield Unauthenticated();
      }
    } catch (_) {
      yield Unauthenticated();
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState(
      AuthenticationEvent event) async* {
    if (event is LoginByGoogle) {
      try {
        final User? user = await userRepo.signInWithGoogle();
        if (user != null) {
          yield Authenticated.copyWith(user: user);
        } else {
          yield Unauthenticated();
        }
      } catch (e) {
        rethrow;
      }
    }
    yield Authenticated( userRepo.getUser()!);
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    yield Unauthenticated();

  }
}
