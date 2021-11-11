import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samrt_health/event/auth/restore_password_event.dart';
import 'package:samrt_health/repository/user_repository.dart';
import 'package:samrt_health/state/auth/restore_password_state.dart';
import 'package:samrt_health/state/form_submission_status.dart';

class RestorePasswordBloc
    extends Bloc<RestorePasswordEvent, RestorePasswordState> {
  final UserRepository userRepo;

  RestorePasswordBloc({required UserRepository? userRepository})
      : assert(userRepository != null),
        userRepo = userRepository!,
        super(RestorePasswordState());

  @override
  Stream<RestorePasswordState> mapEventToState(RestorePasswordEvent event) async*{
    if(event is RestorePasswordEventOnEmailChanged){
      yield state.copyWith(email: event.email);
    }
    if(event is RestorePasswordEventOnNewPasswordEnter){
      yield state.copyWith(newPassword: event.newPassword);
    }
    if(event is RestorePasswordEventOnCodeChanged){
      yield state.copyWith(code: event.code,);
    }
    if(event is RestorePasswordEventOnEmailSubmitted){
      yield state.copyWith(formStatus: FormSubmitting());
      await Future.delayed(const Duration(milliseconds: 300));
      try {
        await userRepo.resetEmail(state.email);
        yield state.copyWith(formStatus: SubmissionSuccess());
      }catch(e){
        print("RESTORE ERROR ");
        yield state.copyWith(formStatus: SubmissionFailed(e as Exception));
      }

    }
    if(event is RestorePasswordEventOnCodeSubmitted){
      await userRepo.confirmResetPassword(state.code, state.newPassword);
    }
  }
}
