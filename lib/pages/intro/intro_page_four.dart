import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:samrt_health/bloc.dart';

class PageFour extends StatelessWidget {
  const PageFour({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (BuildContext context, state) {
          if (state is Authenticated) {
            if (state.user != null) {
              //Start login 2 page
              final snackBar = SnackBar(content: Text("${state.user.email}"));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          }
        },
        child: _getBody(context));
  }

  Widget _getBody(BuildContext context) => Material(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Color(0xFFf2f9fc),
          child: SizedBox(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "sign in",
                    style: GoogleFonts.roboto(
                        textStyle: const TextStyle(fontSize: 26)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _getForm(),
                  ),
                  _getGoogleButton(),
                ],
              ),
            ),
          ),
        ),
      );

  Widget _getForm() {
    return SizedBox(
      width: 300,
      child: Form(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: _getUsernameField(),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: _getUsernameField(),
            ),
            _getLoginButton()
          ],
        ),
      ),
    );
  }
//Todo fix colors
  Widget _getUsernameField() {
    return TextFormField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          borderSide: BorderSide.none,
        ),
        prefixIcon: Icon(FontAwesomeIcons.user, color: Colors.black12,),
        filled: true,
        fillColor: Colors.white,
        hintText: "Type in your text",
      ),
    );
  }

  Widget _getLoginButton() {
    return Row(
      children: [
        ElevatedButton(
          onPressed: () {},
          child: Text("sign in"),
        ),
        TextButton(
            onPressed: () {},
            child: Text(
              "sign up",
              style: TextStyle(color: Colors.black),
            ))
      ],
    );
  }

  Widget _getGoogleButton() {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: ((context, state) {
        return Container(
          width: 150,
          color: Colors.black,
          child: GestureDetector(
            onTap: () {
              context.read<AuthenticationBloc>().add(LoginByGoogle());
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "sign in with",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                      width: 16,
                      child: SvgPicture.asset("assets/img/gmail.svg")),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
