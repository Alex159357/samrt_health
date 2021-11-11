import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:samrt_health/main.dart';
import 'package:samrt_health/cubit/main/main_nav_cubit.dart';
import 'package:samrt_health/navigation/main/pages.dart';
import 'package:samrt_health/view/base_state_less.dart';
import 'package:samrt_health/view/buttons.dart';



class PageOne extends BaseStateLess {
  PageOne({Key? key}) : super(key: key);

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
                  child: getTranslatedText(text: "Slogan 1", style: GoogleFonts.roboto(textStyle: const TextStyle(fontSize: 26)))
                  // Text(
                  //   "Slogan 1",
                  //   style:
                  //       GoogleFonts.roboto(textStyle: TextStyle(fontSize: 26)),
                  // ).translate(),
                ),
                SizedBox(
                  width: 300,
                  height: 300,
                  child: SvgPicture.asset("assets/img/slide_1.svg",
                      semanticsLabel: 'Acme Logo'),
                ),
                Container(
                  child:  Center(
                      child: SizedBox(
                          width: 300,
                          child:
                          getTranslatedText(
                              text:"is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the ")
                      )
                  ),
                ),

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
                                  text: translation
                                      .getTranslate("skip"),
                                  background: Colors.white,
                                  textColor: Color(0xff8167e6),
                                  borderColor: Color(0xff8167e6)))))


          ],
        ),
      ),
    );
  }



}
