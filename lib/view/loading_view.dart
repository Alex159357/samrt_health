

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'logo_view.dart';

class LoadingView{

  Widget loadingWhiteBg(BuildContext context){
    return SizedBox(
        width: MediaQuery.of(context).size.width  - MediaQuery.of(context).size.width / 5,
        height: MediaQuery.of(context).size.height  - MediaQuery.of(context).size.height / 2,
        child: Lottie.asset('assets/animation/loading_white.json'));
  }

}