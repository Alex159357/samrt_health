

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'logo_view.dart';

class LoadingView{

  Widget loadingWhiteBg(){
    return SizedBox(
        width: 300,
        height: 300,
        child: Lottie.asset('assets/animation/loading_white.json'));
  }

}