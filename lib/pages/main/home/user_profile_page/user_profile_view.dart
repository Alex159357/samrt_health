

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:samrt_health/bloc/bloc/home/profile_ui_bloc.dart';
import 'package:samrt_health/bloc/state/home/profile/profile_ui_state.dart';
import 'package:samrt_health/models/app_user_model.dart';
import 'package:samrt_health/theme/theme_controller.dart';

class UserProfileView extends StatelessWidget {
  const UserProfileView({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return _getBody;
  }

Widget get _getBody=>BlocConsumer<ProfileUiBloc, ProfileUiState>(
    listenWhen: (previous, current) {
      return true;
    },
    listener: (context, state) {},
    buildWhen: (previous, current) {
      return true;
    },
  builder: (context, state) {
    return Container(
      color: Theme.of(context).colorScheme.primary,
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 6),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("PROFILE", style: Theme.of(context).textTheme.headline4,),
                    ],
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(1000.0),
                  child: Container(
                    color: Theme.of(context).cardColor,
                    child: state is UserDataLoadDone? state.userModel.avatar.isNotEmpty? Image.network(
                      context.read<ProfileUiBloc>().userModel!.avatar,
                      fit: BoxFit.fill,
                      height: 100.0,
                      width: 100.0,
                    ): Padding(
                      padding: const EdgeInsets.all(20),
                      child: Icon(FontAwesomeIcons.image, size: 60,),
                    ): Padding(
                      padding: const EdgeInsets.all(20),
                      child: Icon(FontAwesomeIcons.image, size: 60,),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(state is UserDataLoadDone? state.userModel.name: "", style: Theme.of(context).textTheme.headline5,),
                ),
                Text(state is UserDataLoadDone? state.userModel.email: "")
              ],
            ),
          ],
        ),
      ),
    );
  }
);


}


// return  ThemeSwitcher(
// clipper: const ThemeSwitcherCircleClipper(),
// builder: (context) {
// return IconButton(
// onPressed: () {
// Phoenix.rebirth(context);
// ThemeSwitcher.of(context).changeTheme(
// theme: ThemeController().toggleTheme(),
// isReversed: false // default: false
// );
// },
// icon: Theme.of(context).brightness == Brightness.light
// ? Icon(Icons.brightness_3, size: 25)
//     : Icon(Icons.brightness_4, size: 25),
// );
// });