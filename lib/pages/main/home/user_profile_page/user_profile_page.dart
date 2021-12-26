import 'dart:ui';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:samrt_health/bloc/bloc/auth/authentication_bloc.dart';
import 'package:samrt_health/bloc/bloc/user_data/user_data_bloc.dart';
import 'package:samrt_health/bloc/event/auth/authentication_event.dart';
import 'package:samrt_health/bloc/bloc/home/profile_ui_bloc.dart';
import 'package:samrt_health/bloc/event/home/profile/profile_ui_event.dart';
import 'package:samrt_health/bloc/state/form_submission_status.dart';
import 'package:samrt_health/bloc/state/home/profile/profile_ui_state.dart';
import 'package:samrt_health/bloc/event/user_data/user_data_event.dart';
import 'package:samrt_health/bloc/state/user_data/user_data_state.dart';
import 'package:samrt_health/pages/main/home/user_profile_page/avatar_preview.dart';
import 'package:samrt_health/repository/firebase_repository.dart';
import 'package:samrt_health/theme/theme_controller.dart';
import 'package:samrt_health/utils/counts.dart';
import 'package:samrt_health/view/icon_title.dart';

import '../../user_data_view.dart';
import 'user_profile_view.dart';

double scrollPosition = 0.0;

class UserProfileScreen extends StatelessWidget {
  static const double minExtent = 0.25;
  static const double maxExtent = 0.1;
  bool isExpanded = false;
  double initialExtent = minExtent;
  BuildContext? draggableSheetContext;
  final ScrollController _scrollController = ScrollController(initialScrollOffset: scrollPosition);

  UserProfileScreen({Key? key}) : super(key: key);

  void _scrollListener() {
    scrollPosition = _scrollController.offset;
  }

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(_scrollListener);
    context.read<ProfileUiBloc>().add(LoadUserEvent());

    return _getBody;
    return MultiBlocProvider(providers: const [], child: _getBody);
  }

  Widget get _getBody => BlocListener<UserDataBloc, UserDataState>(
      listener: (context, state) {
        if (state.formStatus is SubmissionSuccess) {
          context.read<ProfileUiBloc>().add(LoadUserEvent());
        }
      },
      child: Stack(
        children: [
          _getTopFill,
          _getUserControl,
          _getUserAvatar
        ],
      ));


  Widget get _getTopFill => Positioned(
        top: 0,
        left: 0,
        right: 0,
        bottom: 100,
        child: BlocBuilder<ProfileUiBloc, ProfileUiState>(
            builder: (context, state) {
          print("StateIs -> $state");
          UserDataLoadDone? mState;
          String? img;
          if (state is UserDataLoadDone) {
            mState = state;
            img = mState.userModel.avatar.isNotEmpty
                ? mState.userModel.avatar
                : null;
          }
          return Container(
            decoration: BoxDecoration(
              image: img != null
                  ? DecorationImage(
                      image: NetworkImage(img),
                      fit: BoxFit.cover,
                    )
                  : const DecorationImage(
                      image: AssetImage("assets/img/day.jpg"),
                      fit: BoxFit.cover,
                    ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
              ),
            ),
          );
        }),
      );

  Widget get _getUserAvatar =>  Positioned(
      child: Align(
        alignment: Alignment.topCenter,
        child:BlocBuilder<ProfileUiBloc, ProfileUiState>(
      builder: (context, state) {

        // Avatar(
        //     sources: [
        //       NetworkSource(context.read<ProfileUiBloc>().userModel!.avatar)
        //     ],
        //     name: 'Alberto Fecchi', shape: AvatarShape.rectangle(100, 100, BorderRadius.all(new Radius.circular(20.0))))

        return Container(
          margin: const EdgeInsets.only(top: 50),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 5.0,
                  offset: Offset(3.0, 3.0),
                  spreadRadius: 1.0)
            ],
          ),
          child: Hero(
            tag: "avatar_preview",
            child: GestureDetector(
              onTap: ()=> _avatarPreview(context),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Container(
                  height: 100.0,
                  width: 100.0,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                  ),
                  child: state is UserDataLoadDone? state.userModel.avatar.isNotEmpty
        ? Image.network(context.read<ProfileUiBloc>().userModel!.avatar,fit: BoxFit.cover,
                  ): const Padding(
                    padding: EdgeInsets.all(20),
                    child: Icon(FontAwesomeIcons.image, size: 60,),
                  ): const Padding(
                    padding: EdgeInsets.all(20),
                    child: Icon(FontAwesomeIcons.image, size: 60,),
                  ),
                ),
              ),
            ),
          ),
        );
      })),
    );

  Widget get _getUserControl => Positioned.fill(
    top: 120,
    child: BlocConsumer<ProfileUiBloc, ProfileUiState>(
        listenWhen: (previous, current) {
          return previous != current;
        },
        listener: (context, state) {},
        buildWhen: (previous, current) {
          return previous != current;
        },
        builder: (context, state) {
          var mState = state is UserDataLoadDone? state : null;
            return Container(
            padding: const EdgeInsets.only(top: 35, left: 0, right: 0, bottom: 6),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16)),
            ),
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 37),
                        child: Text(mState != null? mState.userModel.name : "", style: Theme.of(context).textTheme.headline5,),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 21),
                        child: Hero(
                          tag: "edit_user",
                          child: GestureDetector(
                            onTap: ()=> onUserEdit(context),
                              child: Icon(FontAwesomeIcons.edit, size: 16,)),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(mState != null? mState.userModel.email : "", style: Theme.of(context).textTheme.caption,),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 3.0,
                            offset: Offset(0.0, 4.0),
                            spreadRadius: 1.0)
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconTitle(icon: FontAwesomeIcons.weight, title: mState!= null? mState.userModel.weight.toString(): "", subTitle: "",),
                            Container(color: Theme.of(context).dividerColor, width: 1, height: 50,),
                            IconTitle(icon: FontAwesomeIcons.rulerVertical, title:  mState!= null? mState.userModel.height.toString(): "", subTitle: "",),
                            Container(color: Theme.of(context).dividerColor, width: 1, height: 50,),
                            IconTitle(icon: FontAwesomeIcons.shoePrints, title:  mState!= null? mState.userModel.stepsPerDay.toString(): "", subTitle: "",),
                            Container(color: Theme.of(context).dividerColor, width: 1, height: 50,),
                            IconTitle(icon: FontAwesomeIcons.tableTennis, title:  mState!= null? mState.userModel.hourSportPerWeek.toString(): "", subTitle: "",),
                            Container(color: Theme.of(context).dividerColor, width: 1, height: 50,),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconTitle(icon: mState != null? (mState.userModel.gender == "female"
                                ? FontAwesomeIcons.female: mState.userModel.gender == "male"
                                ? FontAwesomeIcons.male : FontAwesomeIcons.venusMars): FontAwesomeIcons.venusMars, title
                                : "", subTitle: "",),
                            Container(color: Theme.of(context).dividerColor, width: 1, height: 50,),
                            IconTitle(icon: mState != null?(mState.userModel.isVegan? FontAwesomeIcons.leaf: FontAwesomeIcons.hotdog): FontAwesomeIcons.hotdog, title:"", subTitle: "",),
                            Container(color: Theme.of(context).dividerColor, width: 1, height: 50,),
                            IconTitle(icon: mState != null?(mState.userModel.smoke == 0? FontAwesomeIcons.smokingBan: mState.userModel.smoke == 1? FontAwesomeIcons.smoking: FontAwesomeIcons.smokingBan): FontAwesomeIcons.smokingBan, title:"", subTitle: "",),
                            Container(color: Theme.of(context).dividerColor, width: 1, height: 50,),
                            IconTitle(icon: mState != null?(mState.userModel.alcohol == 0? Icons.no_drinks: mState.userModel.alcohol == 1? FontAwesomeIcons.glassMartini: FontAwesomeIcons.wineBottle): Icons.no_drinks, title:"", subTitle: "",),
                          ],
                        ),
                      ],
                    ),
                  ),

                  ListTile(
                    title: Text(mState != null? countAge(mState.userModel.birthday): ""),
                    subtitle: Text(tr("age")),
                  ),
                  ThemeSwitcher(
                      clipper: const ThemeSwitcherCircleClipper(),
                      builder: (context) {
                        return ListTile(
                          title: Text(tr("Dark theme")),
                          subtitle: const Text(
                              "night theme"),
                          trailing: Switch(
                            onChanged: (bool value) =>
                                onThemeSwitch(context),
                            value: Theme.of(context).brightness ==
                                Brightness.dark,
                          ),
                        );
                      }),
                  ListTile(
                    title: Text(tr("sign_out")),
                    subtitle:
                    const Text("all your data will be deleted from device"),
                    onTap: () => onSignOutPressed(context),
                  ),
                ],
              ),
            ));

        }),
  );

  Widget get _getBottomSheet => BlocConsumer<ProfileUiBloc, ProfileUiState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (context, state) {},
      buildWhen: (previous, current) {
        return previous != current;
      },
      builder: (context, state) {
        return DraggableScrollableActuator(
          child: DraggableScrollableSheet(
              maxChildSize: 0.79,
              minChildSize: 0.45,
              initialChildSize: 0.45,
              builder: (context, scrollController) {
                draggableSheetContext = context;
                return Container(
                  padding: const EdgeInsets.only(top: 16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16)),
                  ),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      children: [
                        Hero(
                          tag: "edit_user",
                          child: Material(
                            color: Colors.transparent,
                            child: ListTile(
                              title: Text(tr("edit_user")),
                              // subtitle:
                              // Text(ctx.read<UserDataBloc>().state.weight.toString()),
                              onTap: () => onUserEdit(context),
                            ),
                          ),
                        ),
                        ThemeSwitcher(
                            clipper: const ThemeSwitcherCircleClipper(),
                            builder: (context) {
                              return ListTile(
                                title: Text(tr("Dark theme")),
                                subtitle: const Text(
                                    "all your data will be deleted from device"),
                                trailing: Switch(
                                  onChanged: (bool value) =>
                                      onThemeSwitch(context),
                                  value: Theme.of(context).brightness ==
                                      Brightness.dark,
                                ),
                              );
                            }),
                        ListTile(
                          title: Text(tr("sign_out")),
                          subtitle:
                              const Text("all your data will be deleted from device"),
                          onTap: () => onSignOutPressed(context),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        );
      });

  onUserEdit(BuildContext ctx) {
    Navigator.push(
        ctx,
        MaterialPageRoute(
            fullscreenDialog: true,
            builder: (BuildContext context) {
              return Scaffold(
                body: Hero(
                    tag: "edit_user", child: UserData(dialogEnabled: false)),
              );
            })).then((value) async {
              print(value);

    });
  }

  void _avatarPreview(BuildContext ctx){
    String? avatar = ctx.read<ProfileUiBloc>().userModel!.avatar.isNotEmpty? ctx.read<ProfileUiBloc>().userModel!.avatar : null;
    if(avatar != null) {
      Navigator.of(ctx).push(
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 1000),
        pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return AvatarPreview(avatar: avatar,);
        },
        transitionsBuilder: (
            BuildContext context,
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
  }

  void onSignOutPressed(BuildContext ctx) {
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: AlertDialog(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0))),
                title: Text(tr("sign_out")),
                content: const Text('How are you?'),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        ctx.read<AuthenticationBloc>().add(SignOut());
                      },
                      child: Text(tr("yes"))),
                  MaterialButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(tr("no")),
                  )
                ],
              ),
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 500),
        barrierDismissible: true,
        barrierLabel: '',
        context: ctx,
        pageBuilder: (context, animation1, animation2) {
          return Row(
            children: [
              MaterialButton(
                onPressed: () {},
                child: Text(tr("yes")),
              )
            ],
          );
        });
  }

  void onThemeSwitch(BuildContext context) {
    ThemeSwitcher.of(context).changeTheme(
        theme: ThemeController().toggleTheme(),
        isReversed: false // default: false
        );
  }


}
/////////
// class UserProfilePage extends StatefulWidget {
//   const UserProfilePage({Key? key}) : super(key: key);
//
//   @override
//   _UserProfilePageState createState() => _UserProfilePageState();
// }
//
// class _UserProfilePageState extends State<UserProfilePage> {
//   @override
//   void initState() {
//     super.initState();
//     loadUser();
//   }
//
//   Future<void> loadUser() async {
//     context.read<ProfileUiBloc>().add(LoadUserEvent());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: RepositoryProvider(
//         create: (context) => FirebaseRepository(),
//         child: _getBody,
//       ),
//     );
//   }
//
//   Widget get _getBody => BlocConsumer<ProfileUiBloc, ProfileUiState>(
//       listenWhen: (previous, current) {
//         return previous != current;
//       },
//       listener: (context, state) {},
//       buildWhen: (previous, current) {
//         return previous != current;
//       },
//       builder: (context, state) {
//         if (state is UserDataLoadError) {
//           return Text("Error");
//         }
//         if (state is UserDataLoadDone) {
//           return Stack(
//             children: [
//               Positioned(
//                   top: 0,
//                   left: 0,
//                   right: 0,
//                   bottom: MediaQuery.of(context).size.height / 3,
//                   child: _getTopFill(state)),
//               _getBottomSheet(context)
//             ],
//           );
//         }
//         return Text("Loading...");
//       });
//
//   static const double minExtent = 0.2;
//   static const double maxExtent = 0.6;
//   bool isExpanded = false;
//   double initialExtent = minExtent;
//   BuildContext? draggableSheetContext;
//
//   void _toggleDraggableScrollableSheet() {
//     if (draggableSheetContext != null) {
//       setState(() {
//         initialExtent = isExpanded ? minExtent : maxExtent;
//         isExpanded = !isExpanded;
//       });
//       DraggableScrollableActuator.reset(draggableSheetContext!);
//     }
//   }
//
//   Widget _getTopFill(UserDataLoadDone state) =>  Container(
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               image: NetworkImage(state.userModel.avatar),
//               fit: BoxFit.cover,
//             ),
//           ),
//           child: BackdropFilter(
//             filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
//             child: Container(
//               decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
//             ),
//           ),
//         );
//
//
//   Widget _getBottomSheet(BuildContext ctx) => FutureBuilder(
//         builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//           return DraggableScrollableActuator(
//             child: DraggableScrollableSheet(
//                 // maxChildSize: 0.89,
//                 // minChildSize: 0.45,
//                 key: Key(initialExtent.toString()),
//                 // initialChildSize: 0.45,
//                 minChildSize: minExtent,
//                 maxChildSize: maxExtent,
//                 initialChildSize: initialExtent,
//                 builder: (context, scrollController) {
//                   draggableSheetContext = context;
//                   return Container(
//                     padding: EdgeInsets.only(top: 16),
//                     decoration: BoxDecoration(
//                       color: Theme.of(context).cardColor,
//                       borderRadius: const BorderRadius.only(
//                           topLeft: Radius.circular(16),
//                           topRight: Radius.circular(16)),
//                     ),
//                     child: SingleChildScrollView(
//                       controller: scrollController,
//                       child: Column(
//                         children: [
//                           ElevatedButton(
//                               onPressed: () {
//                                 _toggleDraggableScrollableSheet();
//                               },
//                               child: Text("asd")),
//                           Hero(
//                             tag: "edit_user",
//                             child: Material(
//                               color: Colors.transparent,
//                               child: ListTile(
//                                 title: Text(tr("edit_user")),
//                                 // subtitle:
//                                 // Text(ctx.read<UserDataBloc>().state.weight.toString()),
//                                 onTap: () => onUserEdit(ctx),
//                               ),
//                             ),
//                           ),
//                           ThemeSwitcher(
//                               clipper: const ThemeSwitcherCircleClipper(),
//                               builder: (context) {
//                                 return ListTile(
//                                   title: Text(tr("Dark theme")),
//                                   subtitle: Text(
//                                       "all your data will be deleted from device"),
//                                   trailing: Switch(
//                                     onChanged: (bool value) =>
//                                         onThemeSwitch(context),
//                                     value: Theme.of(ctx).brightness ==
//                                         Brightness.dark,
//                                   ),
//                                 );
//                               }),
//                           ListTile(
//                             title: Text(tr("sign_out")),
//                             subtitle: Text(
//                                 "all your data will be deleted from device"),
//                             onTap: () => onSignOutPressed(ctx),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 }),
//           );
//         },
//       );
//
//   onUserEdit(BuildContext ctx) {
//     Navigator.push(
//         context,
//         MaterialPageRoute(
//             fullscreenDialog: true,
//             builder: (BuildContext context) {
//               return Scaffold(
//                 body: Hero(
//                     tag: "edit_user", child: UserData(dialogEnabled: false)),
//               );
//             })).then((value) async {
//       context.read<UserDataBloc>().add(UploadData());
//       loadUser();
//     });
//   }
//
//   void onSignOutPressed(BuildContext ctx) {
//     showGeneralDialog(
//         barrierColor: Colors.black.withOpacity(0.5),
//         transitionBuilder: (context, a1, a2, widget) {
//           return Transform.scale(
//             scale: a1.value,
//             child: Opacity(
//               opacity: a1.value,
//               child: AlertDialog(
//                 shape: const RoundedRectangleBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(12.0))),
//                 title: Text(tr("sign_out")),
//                 content: Text('How are you?'),
//                 actions: [
//                   ElevatedButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                         ctx.read<AuthenticationBloc>().add(SignOut());
//                       },
//                       child: Text(tr("yes"))),
//                   MaterialButton(
//                     onPressed: () => Navigator.pop(context),
//                     child: Text(tr("no")),
//                   )
//                 ],
//               ),
//             ),
//           );
//         },
//         transitionDuration: Duration(milliseconds: 500),
//         barrierDismissible: true,
//         barrierLabel: '',
//         context: context,
//         pageBuilder: (context, animation1, animation2) {
//           return Row(
//             children: [
//               MaterialButton(
//                 onPressed: () {},
//                 child: Text(tr("yes")),
//               )
//             ],
//           );
//         });
//   }
//
//   void onThemeSwitch(BuildContext context) {
//     ThemeSwitcher.of(context).changeTheme(
//         theme: ThemeController().toggleTheme(),
//         isReversed: false // default: false
//         );
//   }
// }
