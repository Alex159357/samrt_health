
import 'package:flutter/material.dart';
import 'package:samrt_health/view/auth_widgets.dart';
import 'package:samrt_health/view/base_state_less.dart';

import '../bloc.dart';

abstract class AuthStateLess extends BaseStateLess with AuthWidgets{

  AuthStateLess({Key? key}) : super(key: key);


  Widget get googleButton => authButtons.googleButton;

  Widget get facebookButton => authButtons.facebookButton;


}