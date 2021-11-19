import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samrt_health/bloc.dart';
import 'package:samrt_health/bloc/fb/fb_bloc.dart';
import 'package:samrt_health/event/db/fb_event.dart';
import 'package:samrt_health/repository/firebase_repository.dart';
import 'package:samrt_health/state/fb/fb_state.dart';

import '../user_data.dart';

class MainPage extends StatelessWidget {
  final FirebaseRepository _firebaseRepository =
      FirebaseRepository().instance();

  MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => FbBloc(firebaseRepository: _firebaseRepository),
        child: _getBody,
      ),
    );
  }

  Widget get _getBody => BlocBuilder<FbBloc, FbState>(
        builder: (BuildContext context, state) {
          return BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (BuildContext context, authState) {
              authState = authState as Authenticated;
              if (state is InitialState) {
                if (authState is Authenticated) {
                  context
                      .read<FbBloc>()
                      .add(IfUserExistsEvent(authState.user.uid));
                }
              }
              if(state is UserExistsState) {
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
              return UserData();
            },
          );
        },
      );
}
