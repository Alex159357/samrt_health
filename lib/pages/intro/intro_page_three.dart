

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/src/provider.dart';
import 'package:samrt_health/cubit/main/main_nav_cubit.dart';
import 'package:samrt_health/navigation/main/pages.dart';
import 'package:samrt_health/view/buttons.dart';

import '../../main.dart';

class PageThree extends StatelessWidget {
  const PageThree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Color(0xffffffff),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Text("Slogan 3", style: GoogleFonts.roboto(textStyle: TextStyle(fontSize: 26)),),
                ),
                SizedBox(
                  width: 300,
                  height: 300,
                  child: SvgPicture.asset(
                      "assets/img/slide_3.svg",
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
            Positioned.fill(
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                        margin: const EdgeInsets.only(bottom: 50),
                        child: Buttons.mainButton(
                            onPressed: () {
                              prefs.setBool("intro", true);
                              context.read<MainNavCubit>().goTeScreen(Pages.AUTH);
                            },
                            text: "Sign in",
                            background: Colors.white,
                            textColor: Color(0xff8167e6),
                            borderColor: Color(0xff8167e6)))
                ))
          ],
        ),
      ),
    );
  }
}
