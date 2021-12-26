import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:samrt_health/bloc/bloc/home/home_ui_bloc.dart';
import 'package:samrt_health/cubit/home/bottom_nav_cubit.dart';
import 'package:samrt_health/view/widgets/bottom_nav.dart';

class AddActionView extends StatelessWidget {
  final int lastOpened;

  const AddActionView({required this.lastOpened, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (ctx) => HomeMainUiBloc()),
        BlocProvider(create: (context) => BottomNavCubit(lastOpened))
      ],
      child: GestureDetector(
        onPanUpdate: (details) {
          // Swiping in right direction.
          if (details.delta.dy > 10) {
            Navigator.of(context).pop();
          }
          // Swiping in left direction.
          if (details.delta.dy < 0) {}
        },
        child: SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            body: Hero(
              tag: "add_action",
              child: Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                        top: 25, left: 5, right: 5, bottom: 25),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(30.0),
                        child: Container(
                          color: Theme.of(context).primaryColor,
                        )),
                  ),
                  Positioned(
                      child: Align(
                          alignment: Alignment.topCenter,
                          child: ElevatedButton(
                            child: const Icon(FontAwesomeIcons.arrowDown),
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              shape: const CircleBorder(),
                              padding: const EdgeInsets.all(20),
                              primary: Theme.of(context).primaryColor, // <-- Button color

                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          )))
                ],
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: BottomAppBar(
                  color:Colors.redAccent,
                  shape: const CircularNotchedRectangle(),
                  notchMargin: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(icon: Icon(Icons.search, color: Colors.white,), onPressed: () => Navigator.of(context).pop(0),),
                      IconButton(icon: Icon(Icons.print, color: Colors.white,), onPressed: () => Navigator.of(context).pop(1),),
                      IconButton(icon: Icon(Icons.people, color: Colors.white,), onPressed: () => Navigator.of(context).pop(2),),
                      IconButton(icon: Icon(Icons.people, color: Colors.white,), onPressed: () => Navigator.of(context).pop(3),),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
