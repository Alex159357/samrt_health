import 'dart:ui' as ui;

import 'package:flutter/material.dart';


class RPSCustomPainter2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {

    Paint paint_0_fill = Paint()..style=PaintingStyle.fill;
    paint_0_fill.color = Color(0xfff2f9fc).withOpacity(0.0);
    canvas.drawRect(Rect.fromLTWH(0,0,size.width,size.height),paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(size.width*0.2685556,size.height*-0.6576667);
    path_1.cubicTo(size.width*0.3511111,size.height*-0.6261667,size.width*0.4233333,size.height*-0.5276667,size.width*0.4877778,size.height*-0.4068333);
    path_1.cubicTo(size.width*0.5522222,size.height*-0.2861667,size.width*0.6088889,size.height*-0.1430000,size.width*0.6106667,size.height*0.001500000);
    path_1.cubicTo(size.width*0.6124444,size.height*0.1461667,size.width*0.5593333,size.height*0.2921667,size.width*0.4966667,size.height*0.4178333);
    path_1.cubicTo(size.width*0.4341111,size.height*0.5433333,size.width*0.3620000,size.height*0.6483333,size.width*0.2776667,size.height*0.6221667);
    path_1.cubicTo(size.width*0.1933333,size.height*0.5960000,size.width*0.09666667,size.height*0.4386667,size.width*-0.01422222,size.height*0.4755000);
    path_1.cubicTo(size.width*-0.1250000,size.height*0.5123333,size.width*-0.2500000,size.height*0.7433333,size.width*-0.2911111,size.height*0.7320000);
    path_1.cubicTo(size.width*-0.3321111,size.height*0.7206667,size.width*-0.2892222,size.height*0.4670000,size.width*-0.3451111,size.height*0.3046667);
    path_1.cubicTo(size.width*-0.4008889,size.height*0.1421667,size.width*-0.5554444,size.height*0.07116667,size.width*-0.5958889,size.height*-0.03500000);
    path_1.cubicTo(size.width*-0.6362222,size.height*-0.1411667,size.width*-0.5625556,size.height*-0.2821667,size.width*-0.5012222,size.height*-0.4303333);
    path_1.cubicTo(size.width*-0.4400000,size.height*-0.5786667,size.width*-0.3911111,size.height*-0.7338333,size.width*-0.3096667,size.height*-0.7663333);
    path_1.cubicTo(size.width*-0.2281111,size.height*-0.7988333,size.width*-0.1141111,size.height*-0.7086667,size.width*-0.01055556,size.height*-0.6811667);
    path_1.cubicTo(size.width*0.09300000,size.height*-0.6536667,size.width*0.1858889,size.height*-0.6891667,size.width*0.2685556,size.height*-0.6576667);

    Paint paint_1_fill = Paint()..style=PaintingStyle.fill;
    paint_1_fill.color = Color(0x3356c8d8).withOpacity(1.0);
    canvas.drawPath(path_1,paint_1_fill);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}