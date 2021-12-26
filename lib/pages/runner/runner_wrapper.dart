import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/src/provider.dart';
import 'package:samrt_health/bloc/bloc/auth/authentication_bloc.dart';
import 'package:samrt_health/bloc/bloc/home/profile_ui_bloc.dart';
import 'package:samrt_health/bloc/bloc/user_data/user_data_bloc.dart';
import 'package:samrt_health/bloc/bloc/user_db/user_db_bloc.dart';
import 'package:samrt_health/models/app_user_model.dart';
import 'package:samrt_health/pages/main/home/home_page.dart';
import 'package:samrt_health/pages/main/user_data_view.dart';
import 'package:samrt_health/bloc/state/auth/authentication_state.dart';
import 'package:samrt_health/pages/user_data/user_data_page.dart';

import 'package:samrt_health/theme/theme_controller.dart';

class RunnerWrapper extends StatelessWidget {
  final int page;
  final UserModel? userModel;
  const RunnerWrapper({Key? key, required this.page, this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User user = (context.read<AuthenticationBloc>().state as Authenticated).user;
    return BlocProvider(
        create: (BuildContext context) => UserDataBloc(user: user, userDb: context.read<UserDbBloc>().userDb, userModel: userModel),
    child: AnimatedSwitcher(
    duration: Duration(milliseconds: 500),
    child: UserDataPage()//page == 1? HomePage(): page == 2? UserData(): Text(""),
    )
    );

  }
}
