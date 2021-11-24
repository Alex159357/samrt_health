import 'dart:ui' as ui;

import 'dart:ui';

import 'package:flutter/material.dart';



class MenPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {

    Path path_0 = Path();
    path_0.moveTo(size.width*0.5013177,size.height*0.1658598);
    path_0.cubicTo(size.width*0.6192219,size.height*0.1658598,size.width*0.7148609,size.height*0.1287281,size.width*0.7148609,size.height*0.08292886);
    path_0.cubicTo(size.width*0.7148609,size.height*0.03713166,size.width*0.6192219,size.height*1.442990e-17,size.width*0.5013177,size.height*1.442990e-17);
    path_0.cubicTo(size.width*0.3833874,size.height*1.442990e-17,size.width*0.2877954,size.height*0.03713166,size.width*0.2877954,size.height*0.08292886);
    path_0.cubicTo(size.width*0.2877954,size.height*0.1287281,size.width*0.3833874,size.height*0.1658598,size.width*0.5013177,size.height*0.1658598);
    path_0.close();

    Paint paint_0_fill = Paint()..style=PaintingStyle.fill;
    paint_0_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_0,paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(size.width*0.5013177,size.height*0.08292886);

    Paint paint_1_fill = Paint()..style=PaintingStyle.fill;
    paint_1_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_1,paint_1_fill);

    Path path_2 = Path();
    path_2.moveTo(size.width*0.2728143,size.height*0.1841616);
    path_2.cubicTo(size.width*0.1216064,size.height*0.1841616,0,size.height*0.2320627,0,size.height*0.2917894);
    path_2.lineTo(0,size.height*0.5464146);
    path_2.cubicTo(0,size.height*0.5959059,size.width*0.1865352,size.height*0.5959059,size.width*0.1865352,size.height*0.5464146);
    path_2.lineTo(size.width*0.1865352,size.height*0.3136005);
    path_2.lineTo(size.width*0.2306944,size.height*0.3136005);
    path_2.lineTo(size.width*0.2306944,size.height*0.9510774);
    path_2.cubicTo(size.width*0.2306944,size.height*1.017262,size.width*0.4790891,size.height*1.015312,size.width*0.4790891,size.height*0.9510774);
    path_2.lineTo(size.width*0.4790891,size.height*0.5810199);
    path_2.lineTo(size.width*0.5218730,size.height*0.5810199);
    path_2.lineTo(size.width*0.5218730,size.height*0.9510774);
    path_2.cubicTo(size.width*0.5218730,size.height*1.015312,size.width*0.7716482,size.height*1.017262,size.width*0.7716482,size.height*0.9510774);
    path_2.lineTo(size.width*0.7716482,size.height*0.3136005);
    path_2.lineTo(size.width*0.8147354,size.height*0.3136005);
    path_2.lineTo(size.width*0.8147354,size.height*0.5464146);
    path_2.cubicTo(size.width*0.8147354,size.height*0.5962917,size.width*1.000314,size.height*0.5962917,size.width*1.000000,size.height*0.5464146);
    path_2.lineTo(size.width*1.000000,size.height*0.2933125);
    path_2.cubicTo(size.width*1.000000,size.height*0.2382364,size.width*0.8898243,size.height*0.1842753,size.width*0.7238026,size.height*0.1842753);
    path_2.lineTo(size.width*0.2728143,size.height*0.1841616);
    path_2.close();

    Paint paint_2_fill = Paint()..style=PaintingStyle.fill;
    paint_2_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_2,paint_2_fill);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}