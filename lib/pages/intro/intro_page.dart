import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:samrt_health/pages/intro/intro_page_two.dart';

import 'intro_page_four.dart';
import 'intro_page_one.dart';
import 'intro_page_three.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final pages = [
    PageOne(),
    PageTwo(),
    PageThree(),
    PageFour()
  ];
  LiquidController _liquidController = LiquidController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        child: LiquidSwipe(
          liquidController: _liquidController,
            slideIconWidget: const Icon(Icons.keyboard_arrow_right_rounded),
            enableLoop: false,
            pages: pages,
          onPageChangeCallback: (i){
            //todo use cubit here to hide icon if end of
          },
        ),
      ),
    );
  }


}
