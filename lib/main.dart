import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samrt_health/pages/intro/intro_page.dart';
import 'package:samrt_health/pages/intro/intro_page_four.dart';
import 'package:samrt_health/state/auth/authentication_state.dart';
import 'bloc/auth/authentication_bloc.dart';
import 'event/auth/authentication_event.dart';
import 'repository/user_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en', 'US'), Locale('de', 'DE')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en', 'US'),
        child: const MyApp()),
  );
}

// class App extends StatefulWidget {
//   const App({Key? key}) : super(key: key);
//
//   @override
//   _AppState createState() => _AppState();
// }
//
// class _AppState extends State<App> {
//   final UserRepository _userRepository = UserRepository();
//
//   @override
//   void initState() {
//     super.initState();
//     context.read<AuthenticationBloc>().add(AppStarted());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//         return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.amber,
//       ),
//       home: BlocProvider(
//         create: (ctx)=> AuthenticationBloc(userRepository: UserRepository()),
//         child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
//             builder: (BuildContext context, state) {
//             return const Scaffold(
//               body: Center(child: Text("sadasd"),),
//             );
//           }
//         )
//       ),
//     );
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: BlocProvider(
          create: (ctx)=> AuthenticationBloc(userRepository: UserRepository()),
          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (BuildContext context, state) {
                Firebase.initializeApp().then((value) {
                  context.read<AuthenticationBloc>().add(AppStarted());
                });
                if (state is Uninitialized) {
                  return Container(child: Center(child: Text("SPLASH SCREEN"),),);
                }
                if(state is Unauthenticated){
                  //if intro was showen show auth only else show intro
                }

                return const IntroPage();

              }
          )
      ),
    );
  }
}
