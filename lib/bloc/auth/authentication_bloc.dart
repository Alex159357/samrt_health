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
    if (event is CheckLogin) {
      final User? user = userRepo.getUser();
      if (user != null) {
        yield Authenticated.copyWith(user: user);
      } else {
        yield Unauthenticated();
      }
    }
    if (event is SignOut) {
      await userRepo.signOut();
      yield Unauthenticated();
    }
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is LoggedIn ||
        event is LoginByGoogle ||
        event is LoginByFacebook) {
      yield* _mapLoggedInToState(event);
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  // 49:6b:d8:22:a9:86:3e:b7:dd:fd:d1:ea:dc:3e:35:e2:3b:ef:20:84
  // e3:b0:c4:42:98:fc:1c:14:9a:fb:f4:c8:99:6f:b9:24:27:ae:41:e4:64:9b:93:4c:a4:95:99:1b:78:52:b8:55

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
        yield SocialLoginInProgress();
        await userRepo.signInWithGoogle();
      } catch (e) {
        rethrow;
      }
    } else if (event is LoginByFacebook) {
      yield SocialLoginInProgress();
      await userRepo.signInWithFacebook();
    }
    yield Authenticated(userRepo.getUser()!);
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    yield Unauthenticated();
  }
}
