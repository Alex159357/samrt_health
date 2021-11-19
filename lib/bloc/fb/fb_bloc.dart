import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samrt_health/event/db/fb_event.dart';
import 'package:samrt_health/repository/firebase_repository.dart';
import 'package:samrt_health/state/fb/fb_state.dart';

class FbBloc extends Bloc<FbEvent, FbState> {
  final FirebaseRepository _firebaseRepository;

  FbBloc({required FirebaseRepository? firebaseRepository})
      : assert(firebaseRepository != null),
        _firebaseRepository = firebaseRepository!,
        super(InitialState());

  @override
  Stream<FbState> mapEventToState(FbEvent event) async* {
    if(event is IfUserExistsEvent){
      yield InitialisedState();
      var user = await _firebaseRepository.isUserExists(event.uid);
      if(user != null) {
        yield UserExistsState(user);
      } else {
        yield UserNotFoundState();
      }
      // if(user == null){
      //   user = await _firebaseRepository.createUser(event.uid);
      //   yield UserExistsState(user);
      // }
      // yield UserExistsState();
    }
  }
}
