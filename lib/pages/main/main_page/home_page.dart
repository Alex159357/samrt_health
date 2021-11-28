import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samrt_health/bloc.dart';
import 'package:samrt_health/bloc/fb/fb_bloc.dart';
import 'package:samrt_health/event/db/fb_event.dart';
import 'package:samrt_health/repository/firebase_repository.dart';
import 'package:samrt_health/state/fb/fb_state.dart';
import 'package:samrt_health/view/loading_view.dart';

import '../user_data_view.dart';

class HomePage extends StatelessWidget {
  final FirebaseRepository _firebaseRepository =
      FirebaseRepository().instance();

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var user = (context.read<AuthenticationBloc>().state as Authenticated).user;
    return Scaffold(
      body: BlocProvider(
        create: (context) => FbBloc(firebaseRepository: _firebaseRepository),
        child: BlocListener<FbBloc, FbState>(
          listener: (context, state) {
            if (state is InitialisedState) {
              print("asdsasasad");
              context.read<FbBloc>().add(IfUserExistsEvent(user.uid));
            }
          },
          child: _getBody,
        ),
      ),
    );
  }

  Widget get _getBody => BlocBuilder<FbBloc, FbState>(
        builder: (BuildContext context, state) {
          if (state is InitialisedState) {
            var user = (context.read<AuthenticationBloc>().state as Authenticated).user;
            context.read<FbBloc>().add(IfUserExistsEvent(user.uid));
            return Center(child: LoadingView().loadingWhiteBg(context));
          }
          if (state is UserExistsState) {
            return Column(
              children: [
                ListTile(
                  title: Text(state.userModel.name),
                  subtitle: Text("Name"),
                ),
                ListTile(
                  title: Text(state.userModel.role),
                  subtitle: Text("Role"),
                  //Todo  change Text in title to TextField to user can edit it
                )
              ],
            );
          }
          if (state is UserNotFoundState) {
            return UserData();
          } else {
            return Text("FATAL ERROR");
          }
        },
      );
}
