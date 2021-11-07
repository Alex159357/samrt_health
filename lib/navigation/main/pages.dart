

import 'package:flutter/material.dart';
import 'package:samrt_health/pages/intro/intro_page.dart';

enum Pages{
  INTRO,
  AUTH,
  MAIN
}

extension Nav on Pages {
  Widget get page {
    switch (this) {
      case Pages.INTRO:
        return const IntroPage();
      case Pages.AUTH:
        return const IntroPage();
      default:
        return const IntroPage();
    }
  }
}