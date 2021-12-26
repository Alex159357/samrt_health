


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samrt_health/bloc/event/auth/registration_event.dart';
import 'package:samrt_health/repository/user_repository.dart';
import 'package:samrt_health/bloc/state/auth/registration_state.dart';
import 'package:samrt_health/bloc/state/form_submission_status.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState>{
  final UserRepository userRepo;

  RegistrationBloc({required UserRepository? userRepository})
      : assert(userRepository != null),
  userRepo = userRepository!,
  super(RegistrationState());

  @override
  Stream<RegistrationState> mapEventToState(RegistrationEvent event) async*{
    if(event is RegistrationEventOnChangedUsername){
      yield state.copyWith(username: event.username);
    }
    if( event is RegistrationEventOnChangedPassword){
      yield state.copyWith(password: event.password);
    }
    if (event is RegistrationEventOnChangedSecondPassword){
      yield state.copyWith(secondPassword: event.secondPassword);
    }
    if (event is RegistrationEventPasswordVisibility) {
      yield state.copyWith(passwordIsVisible: event.isVisible);
    }
    if(event is RegistrationEventCreateNewUser){
      yield state.copyWith(formStatus: FormSubmitting());
      try {
        await Future.delayed(const Duration(milliseconds: 3000));
        await userRepo.createNewUser(state.username, state.password);
        yield state.copyWith(formStatus: SubmissionSuccess());
      }catch(e){
        yield state.copyWith(formStatus: SubmissionFailed(e as Exception));
      }
    }
  }


}