import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:samrt_health/bloc/bloc/auth/authentication_bloc.dart';
import 'package:samrt_health/bloc/bloc/home/home_ui_bloc.dart';
import 'package:samrt_health/bloc/bloc/home/profile_ui_bloc.dart';
import 'package:samrt_health/bloc/state/home/home/home_ui_state.dart';
import 'package:samrt_health/cubit/home/bottom_nav_cubit.dart';
import 'package:samrt_health/bloc/state/auth/authentication_state.dart';
import 'package:samrt_health/theme/theme_controller.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:samrt_health/view/widgets/bottom_nav.dart';
import 'add_action/add_action_view.dart';
import 'user_profile_page/user_profile_page.dart';

int lastOpened = 0;
SlidingUpPanelController panelController = SlidingUpPanelController();

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
        initTheme: ThemeController().getCurrentTheme(),
        builder: (_, myTheme) {
          return MaterialApp(
              title: 'Smart Health',
              theme: myTheme,
              debugShowCheckedModeBanner: false,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              localeResolutionCallback:
                  (locale, Iterable<Locale> supportedLocales) {
                return locale;
              },
              home: ThemeSwitchingArea(
                  child: MultiBlocProvider(providers: [
                    BlocProvider(create: (ctx) => BottomNavCubit(lastOpened)),
                    BlocProvider(create: (ctx) {
                      User user =
                          (ctx
                              .read<AuthenticationBloc>()
                              .state as Authenticated)
                              .user;
                      // ctx.read<FirebaseRepository>().getCurrentUser(user.uid);
                      return ProfileUiBloc(user: user);
                    }),
                    BlocProvider(create: (ctx) => HomeMainUiBloc()),
                  ], child: Phoenix(child: _getBody))));
        });
  }


  Widget get _getBody =>
      BlocListener<HomeMainUiBloc, HomeMainUiState>(
          listener: (context, state) {
            if (state.ifActionsOpened) {
              onFabClicked(context);
            } else if (!state.ifActionsOpened) {
              Navigator.of(context).pop();
            }
          },
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            floatingActionButtonLocation: FloatingActionButtonLocation
                .centerDocked,
            floatingActionButton: _getFab,
            bottomNavigationBar: BottomNav(),
            body: Stack(
              children: [
                BlocBuilder<BottomNavCubit, int>(
                  builder: (context, it) {
                    lastOpened = it;
                    if (it == 0) {
                      return Center(child: Text(" MAIN"));
                    } else if (it == 1) {
                      return Center(child: Text(" TARGET LIST"));
                    } else if (it == 2) {
                      return Center(child: Text("OYHERS"));
                    }
                    return UserProfileScreen();
                  },
                ),
              ],
            ),
          )
      );


  Widget get _getBottomNav =>
      BlocBuilder<BottomNavCubit, int>(builder: (context, it) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30.0),
            child: BottomAppBar(
              color: Colors.redAccent,
              shape: const CircularNotchedRectangle(),
              notchMargin: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(icon: Icon(Icons.search, color: Colors.white,),
                    onPressed: () => context.read<BottomNavCubit>().emit(0),),
                  IconButton(icon: Icon(Icons.print, color: Colors.white,),
                    onPressed: () => context.read<BottomNavCubit>().emit(1),),
                  IconButton(icon: Icon(Icons.people, color: Colors.white,),
                    onPressed: () => context.read<BottomNavCubit>().emit(2),),
                  IconButton(icon: Icon(Icons.people, color: Colors.white,),
                    onPressed: () => context.read<BottomNavCubit>().emit(3),),
                ],
              ),
            ),
          ),
        );
      });

  Widget get _getFab =>
      BlocBuilder<HomeMainUiBloc, HomeMainUiState>(
          builder: (context, state) {
            return BlocBuilder<BottomNavCubit, int>(
                builder: (context, it) {
                  if (it == 3) {
                    return Container();
                  }
                  return Padding(
                    padding: const EdgeInsets.only(left: 15, top: 15),
                    child: FloatingActionButton(
                      backgroundColor: Theme.of(context).primaryColor,
                      heroTag: "add_action",
                      onPressed: () => onFabClicked(context),
                      child: Icon(Icons.add),),

                  );
                });
          }
      );


  Widget get _getPane =>
      SlidingUpPanelWidget(
        child: Material(
          color: Colors.blue,
          child: PageView(

            /// [PageView.scrollDirection] defaults to [Axis.horizontal].
            /// Use [Axis.vertical] to scroll vertically.

            children: const <Widget>[
              Center(
                child: Text('First Page'),
              ),
              Center(
                child: Text('Second Page'),
              ),
              Center(
                child: Text('Third Page'),
              )
            ],
          ),
        ),
        controlHeight: 0.0,
        anchor: 0.4,
        panelController: panelController,
        enableOnTap: true,
        dragDown: (details) {
          print('dragDown');
        },
        dragStart: (details) {
          print('dragStart');
        },
        dragCancel: () {
          print('dragCancel');
        },
        dragUpdate: (details) {
          print('dragUpdate,${panelController.status ==
              SlidingUpPanelStatus.dragging ? 'dragging' : ''}');
        },
        dragEnd: (details) {
          print('dragEnd');
        },
      );


  void onFabClicked(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 500),
        pageBuilder: (BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return AddActionView(lastOpened: lastOpened,);
        },
        transitionsBuilder: (BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child) {
          return Align(
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        },
      ),
    );
  }


  void toggleBs() {
    if (panelController.status == SlidingUpPanelStatus.collapsed) {
      panelController.expand();
    } else {
      panelController.collapse();
    }
  }


}
