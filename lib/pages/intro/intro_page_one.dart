import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class PageOne extends StatelessWidget {
  const PageOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Color(0xffffffff),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Text("Slogan 1", style: GoogleFonts.roboto(textStyle: TextStyle(fontSize: 26)),),
            ),
            SizedBox(
              width: 300,
              height: 300,
              child: SvgPicture.asset(
              "assets/img/slide_1.svg",
              semanticsLabel: 'Acme Logo'
        ),
            ),
            Container(
              child: const Center(child: SizedBox(width: 300, child:
              Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the ")
              )),
            )
          ],
        ),
      ),
    );
  }
}


