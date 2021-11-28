import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samrt_health/event/auth/login_event.dart';
import 'package:samrt_health/repository/user_repository.dart';
import 'package:samrt_health/state/auth/login_state.dart';
import 'package:samrt_health/state/form_submission_status.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepo;

  LoginBloc({required UserRepository? userRepository})
      : assert(userRepository != null),
        userRepo = userRepository!,
        super(LoginState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginEventOnChangedUsername) {
      yield state.copyWith(email: event.username);
    }
    if (event is LoginEventOnChangedPassword) {
      yield state.copyWith(password: event.password);
    }
    if (event is LoginEventPasswordVisibility) {
      yield state.copyWith(passwordIsVisible: event.isVisible);
    }
    if (event is LoginEventOnSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());
      try {
        await userRepo.signInWithCredentials(state.email, state.password);
        await Future.delayed(const Duration(milliseconds: 3000));
        yield state.copyWith(formStatus: SubmissionSuccess());
      } catch (e) {
        yield state.copyWith(formStatus: SubmissionFailed(e as Exception));
      }
    }
  }
}
