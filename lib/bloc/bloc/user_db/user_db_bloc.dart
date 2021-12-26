import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samrt_health/data_base/user_db/user_db.dart';
import 'package:samrt_health/bloc/event/user_db/user_db_event.dart';
import 'package:samrt_health/models/app_user_model.dart';
import 'package:samrt_health/bloc/state/user_db/user_data_state.dart';

class UserDbBloc extends Bloc<UserDbEvent, UserDbState> {
  UserDb userDb;

  UserDbBloc({required UserDb? userDatsBase})
      : assert(userDatsBase != null),
        userDb = userDatsBase!,
        super(InitialUserDbState());

  @override
  Stream<UserDbState> mapEventToState(UserDbEvent event) async* {
    if (event is InsertUserEvent) {
      await userDb.insertUser(event.userModel);
      yield InsertInsertedState();
    }
    if (event is GetUserEvent) {
      try {
        UserModel? user = await userDb.readUser(event.uid);
        if (user != null) {
          yield GetUserState(userModel: user);
        } else {
          yield UserUnExistState();
        }
      } catch (e) {
        yield UserUnExistState();
      }
    }
    if (event is DeleteAllEvent) {
      await userDb.delete();
      yield DeletedAllState();
    }
  }
}
