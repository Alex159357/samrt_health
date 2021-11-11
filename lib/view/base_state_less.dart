

import 'package:flutter/material.dart';
import 'package:samrt_health/view/view.dart';

abstract class BaseStateLess extends StatelessWidget with View{
  BaseStateLess({Key? key}) : super(key: key);
  
  Widget get loadingWhite => loadingView.loadingWhiteBg();

  Widget get appLogo => logoView;

}