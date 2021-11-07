import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:samrt_health/bloc.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (BuildContext context, state) {
      if (state is Authenticated) {
        //Todo check if user uid exists in fierebase -> show main screen else -> show enter data

        return Scaffold(
          appBar: AppBar(title: Text(state.user.email!),
              actions: [
                IconButton(onPressed: (){
                  context.read<AuthenticationBloc>().add(SignOut());
                }, icon: Icon(FontAwesomeIcons.signOutAlt))
            ],
          ),
        );
      } else return Text("ERROR");
    });
  }
}
