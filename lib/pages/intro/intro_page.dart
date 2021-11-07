import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:samrt_health/navigation/intro/intr.dart';
import 'package:samrt_health/navigation/intro/intro_cubit.dart';
import 'package:samrt_health/pages/intro/intro_page_two.dart';
import 'package:samrt_health/view/buttons.dart';

import '../../main.dart';
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
    PageThree()
  ];
  final LiquidController _liquidController = LiquidController();

  @override
  Widget build(BuildContext context) {
    bool hint = prefs.getBool("hint") ?? false;
    return BlocProvider(
      create: (context)=> IntroCubit(hint? Intro.HIDE_HINT : Intro.SHOW_HINT),
      child: BlocBuilder<IntroCubit, Intro>(
        builder: (BuildContext context, state) {
          return Stack(
            children: [
              LiquidSwipe(
                liquidController: _liquidController,
                // slideIconWidget: _liquidController.currentPage != pages.length ? const Icon(FontAwesomeIcons.angleRight, color: Colors.black12,) : null,
                enableLoop: false,
                pages: pages,
                onPageChangeCallback: (i){
                  context.read<IntroCubit>().add(Intro.PAGE_CHANGED);
                  //todo use cubit here to hide icon if end of
                },
              ),
              state == Intro.SHOW_HINT?
              Scaffold(
                backgroundColor: Colors.transparent,
                body: Container(
                  color: const Color(0xcc000000),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                          child: SizedBox(
                              width: 150,
                              height: 150,
                              child: Image.asset("assets/img/swipe_hint.png", color: Colors.white,)
                          )
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 30),
                        child: Text("To change slide swipe ffrom RIGHT to LEFT", style: GoogleFonts.roboto(color: Colors.white),),
                      ),
                      Container(
                          margin: const EdgeInsets.only(bottom: 50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("press ", style: GoogleFonts.roboto(color: Colors.white),),
                              TextButton(
                                onPressed: (){
                                  prefs.setBool("hint", true);
                                  context.read<IntroCubit>().add(Intro.HIDE_HINT);
                                },
                                child: Text("okay", style: TextStyle(color: Color(0xff8167e6), fontWeight: FontWeight.bold, fontSize: 18),),
                              ),
                              Text("to continue", style: GoogleFonts.roboto(color: Colors.white),)
                            ],
                          ))
                    ],
                  ),
                ),
              ): Container()
            ],
          );
        }
      ),
    );
  }

}
