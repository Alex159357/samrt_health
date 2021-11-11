

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LogoView extends StatelessWidget {
  const LogoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 150,
      child: SvgPicture.asset("assets/img/slide_1.svg",
          semanticsLabel: 'Acme Logo'),
    );
  }
}
