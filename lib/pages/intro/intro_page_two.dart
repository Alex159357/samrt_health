import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/src/provider.dart';
import 'package:samrt_health/cubit/main/main_nav_cubit.dart';
import 'package:samrt_health/navigation/main/pages.dart';
import 'package:samrt_health/view/base_state_less.dart';
import 'package:samrt_health/view/buttons.dart';

import '../../main.dart';

class PageTwo extends BaseStateLess {
  PageTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Color(0xff8167e6),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: getTranslatedText(
                    text: "Slogan 2",
                    style: GoogleFonts.roboto(
                        textStyle:
                            TextStyle(fontSize: 26, color: Colors.white)),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width  - MediaQuery.of(context).size.width / 5,
                  height: MediaQuery.of(context).size.height  - MediaQuery.of(context).size.height / 2,
                  child: SvgPicture.asset("assets/img/slide_2.svg",
                      semanticsLabel: 'Acme Logo'),
                ),
                Container(
                  child: Center(
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width  - MediaQuery.of(context).size.width / 5,
                          child: getTranslatedText(
                            text:
                                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the",
                            style: TextStyle(color: Colors.white),
                          ))),
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
                              context
                                  .read<MainNavCubit>()
                                  .goToScreen(Pages.AUTH);
                            },
                            text: tr("skip"),
                            background: Color(0xff8167e6),
                            textColor: Colors.white,
                            borderColor: Colors.white))))
          ],
        ),
      ),
    );
  }
}
