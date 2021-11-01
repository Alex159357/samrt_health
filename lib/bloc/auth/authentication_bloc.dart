import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samrt_health/event/auth/authentication_event.dart';
import 'package:samrt_health/repository/user_repository.dart';
import 'package:samrt_health/state/auth/authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;

  AuthenticationState get initialState => Uninitialized();

  AuthenticationBloc({required UserRepository? userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository!,
        super(Uninitialized());

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
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
      final isSignedIn = await _userRepository.isSignedIn();
      if (isSignedIn) {
        final User? user = await _userRepository.getUser();
        yield Authenticated(user: user);
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
        final User? user = await _userRepository.signInWithGoogle();
        if (user != null) {
          yield Authenticated(user: user);
        } else {
          yield Unauthenticated();
        }
      } catch (e) {
        rethrow;
      }
    }
    // yield Authenticated(await _userRepository.getUser());
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    yield Unauthenticated();
    _userRepository.signOut();
  }
}
