

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class PageTwo extends StatelessWidget {
  const PageTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Material(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Color(0xff8167e6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Text("Slogan 2", style: GoogleFonts.roboto(textStyle: TextStyle(fontSize: 26, color: Colors.white)),),
            ),
            SizedBox(
              width: 300,
              height: 300,
              child: SvgPicture.asset(
                  "assets/img/slide_2.svg",
                  semanticsLabel: 'Acme Logo'
              ),
            ),
            Container(
              child: const Center(child: SizedBox(width: 300, child:
              Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the", style: TextStyle(color: Colors.white),)
              )),
            )
          ],
        ),
      ),
    );
  }
}
