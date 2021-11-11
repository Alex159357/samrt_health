
import 'dart:ui';

import 'package:flutter/material.dart';

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {

    Paint paint0Fill = Paint()..style=PaintingStyle.fill;
    paint0Fill.color = Color(0xFFf2f9fc).withOpacity(0.0);
    canvas.drawRect(Rect.fromLTWH(0,0,size.width,size.height),paint0Fill);

    Path path_2 = Path();
    path_2.moveTo(size.width*0.5407778,0);
    path_2.cubicTo(size.width*0.5207778,size.height*0.1056667,size.width*0.5006667,size.height*0.2113333,size.width*0.4630000,size.height*0.2876667);
    path_2.cubicTo(size.width*0.4252222,size.height*0.3640000,size.width*0.3698889,size.height*0.4110000,size.width*0.3284444,size.height*0.4926667);
    path_2.cubicTo(size.width*0.2870000,size.height*0.5743333,size.width*0.2593333,size.height*0.6906667,size.width*0.2070000,size.height*0.7495000);
    path_2.cubicTo(size.width*0.1545556,size.height*0.8083333,size.width*0.07722222,size.height*0.8098333,0,size.height*0.8111667);
    path_2.lineTo(0,0);
    path_2.close();

    Paint paint2Fill = Paint()..style=PaintingStyle.fill;
    paint2Fill.color = Color(0xff8167e6).withOpacity(1.0);
    canvas.drawPath(path_2,paint2Fill);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}