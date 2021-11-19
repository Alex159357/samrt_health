

import 'package:flutter/material.dart';
import 'package:samrt_health/view/view.dart';

abstract class BaseStateLess extends StatelessWidget with View{
  BaseStateLess({Key? key}) : super(key: key);
  
  Widget loadingWhite(BuildContext context) => loadingView.loadingWhiteBg(context);

  Widget get appLogo => logoView;

}