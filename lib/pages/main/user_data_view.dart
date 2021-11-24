import 'dart:ffi';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:gender_picker/source/gender_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_segmented_control/material_segmented_control.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:samrt_health/bloc/user_data/user_data_bloc.dart';
import 'package:samrt_health/state/user_data/user_data_state.dart';
import 'package:samrt_health/theme/theme.dart';
import 'package:samrt_health/theme/widget_themes.dart';
import 'package:samrt_health/view/men.dart';
import 'package:samrt_health/view/test2.dart';
import 'package:samrt_health/view/user_chart_rounded.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:weight_slider/weight_slider.dart';
import 'package:samrt_health/event/user_data/user_data_event.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:sensors/sensors.dart';
import '../../main.dart';

class UserData extends StatelessWidget {
  UserData({Key? key}) : super(key: key);
  ScrollController _scrollController = ScrollController();

  Future<void> _showMyDialog(BuildContext context) async {
    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Stack(
        children: [
          Positioned(
              left: 280,
              right: -300,
              bottom: -300,
              child: Opacity(
                opacity: 0.2,
                child: CustomPaint(
                  painter: RPSCustomPainter2(),
                  size: Size(900, (500 * 0.8666666666666666).toDouble()),
                ),
              )),
          SizedBox(
            height: 300.0,
            width: 300.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    tr(
                      "user_data_text",
                    ),
                  ),
                ),
                Padding(padding: const EdgeInsets.only(top: 50.0)),
                TextButton(
                    onPressed: () {
                      // prefs.setBool("if_user_data_aller_shown", true);
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      tr("ok_button"),
                      style: GoogleFonts.roboto(color: Theme.of(context).colorScheme.primary, fontSize: 18.0, fontWeight: FontWeight.w300),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
    showDialog(
        context: context, builder: (BuildContext context) => errorDialog);
  }

  @override
  Widget build(BuildContext context) {
    // gyroscopeEvents.listen((GyroscopeEvent event) {
    //   // _scrollController.jumpTo(event.y);
    // });
    // WidgetsBinding.instance!.addPostFrameCallback((_) async {
    //   await showCupertinoModalPopup(context: context, builder: (BuildContext context){
    //     return Text("TEST");
    //   });
    // });
    _scrollController.addListener(() {
      if (!(prefs.getBool("if_user_data_aller_shown") ?? false)) _showMyDialog(context);
    });
    return Scaffold(
      body: BlocProvider(
          create: (BuildContext context) => UserDataBloc(),
          child: _getBody(context)),
    );
  }

  Widget _getBody(BuildContext context) => CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            iconTheme: Theme.of(context).iconTheme,
            backgroundColor: Theme.of(context).backgroundColor,
            collapsedHeight: 60,
            title: Text("Text", style: Theme.of(context).textTheme.caption),
            actions: [
              ThemeSwitcher(
                  clipper: ThemeSwitcherCircleClipper(),
                  builder: (context) {
                    return ThemeSwitcher(
                      builder: (context) {
                        return IconButton(
                          onPressed: () {
                            var brightness =
                                ThemeProvider.of(context)!.brightness;
                            ThemeSwitcher.of(context)!.changeTheme(
                              theme: brightness == Brightness.light
                                  ? AppTheme.darkTheme
                                  : AppTheme.lightTheme,
                              reverseAnimation:
                                  brightness == Brightness.dark ? true : false,
                            );
                          },
                          icon: ThemeProvider.of(context)!.brightness ==
                                  Brightness.light
                              ? Icon(Icons.brightness_3, size: 25)
                              : Icon(Icons.brightness_4, size: 25),
                        );
                      },
                    );
                  })
            ],
            expandedHeight: MediaQuery.of(context).size.height / 3,
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(0.0),
                      bottomRight: Radius.circular(0.0)),
                  image: DecorationImage(
                    image: AssetImage(ThemeProvider.of(context)!.brightness ==
                            Brightness.light
                        ? "assets/img/day.jpg"
                        : "assets/img/night.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.7),

                ),
              ),
              stretchModes: [
                StretchMode.blurBackground,
                StretchMode.zoomBackground
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: ResponsiveGridRow(children: [
              // ResponsiveGridCol(
              //   lg: 4,
              //   md: 5,
              //   xs: 5,
              //   sm: 5,
              //   child: Container(
              //     height: 500,
              //     color: Colors.purple,
              //     child: SfSlider.vertical(
              //       min: 130.0,
              //       max: 250.0,
              //       value: 150,
              //       interval: 20,
              //       showTicks: true,
              //       showLabels: true,
              //       enableTooltip: true,
              //       minorTicksPerInterval: 1,
              //       onChanged: (dynamic value) {
              //
              //       },
              //     ),
              //   ),
              // ),
              ResponsiveGridCol(
                lg: 12,
                md: 12,
                xs: 12,
                sm: 12,
                child: Container(
                  child: ResponsiveGridRow(children: [
                    ResponsiveGridCol(
                        xs: 5, sm: 5, md: 5, lg: 4, child: _getHeightSlider),
                    ResponsiveGridCol(
                        xs: 7, sm: 7, md: 7, lg: 4, child: _getWeight),
                    ResponsiveGridCol(
                      xs: 12,
                      sm: 4,
                      md: 4,
                      lg: 4,
                      child: _getStepsPerDay,
                    ),
                    ResponsiveGridCol(
                        xs: 12,
                        sm: 5,
                        md: 5,
                        lg: 5,
                        child: _geWeekSportTimeSlider),
                    ResponsiveGridCol(
                        xs: 12, sm: 12, md: 7, lg: 7, child: _getBirthday),
                  ]),
                ),
              ),
            ]),
          ),
          SliverList(
              delegate: SliverChildListDelegate(
                  [_getGender, _getSmoking, _getAlcohol]))
        ],
      );

  Widget _getContainer(
      {required BuildContext context,
      required Widget child,
      required String title,
      double? customHeight}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      padding: const EdgeInsets.all(1),
      child: Card(
        borderOnForeground: true,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child:
                    Text(title, style: Theme.of(context).textTheme.headline6),
              ),
              SizedBox(height: customHeight ?? 150, child: child),
            ],
          ),
        ),
      ),
    );
  }

  Widget get _getSmoking => BlocBuilder<UserDataBloc, UserDataState>(
        builder: (BuildContext context, state) {
          List<String> list = ["No", "Electronic", "Classic"];
          return Card(
            child: ListTile(
                title: Text(tr('smoking')),
                trailing: SizedBox(
                    width: 260,
                    child: ListView.builder(
                        itemCount: list.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                              onTap: () {
                                context
                                    .read<UserDataBloc>()
                                    .add(OnSmokeChangeEvent(index));
                              },
                              child: Center(
                                  child: Container(
                                      padding: EdgeInsets.all(8),
                                      margin:
                                          EdgeInsets.only(left: 8, right: 8),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: state.smoke == index
                                                ? Theme.of(context)
                                                    .colorScheme
                                                    .primary
                                                : Theme.of(context).cardColor,
                                          ),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(20))),
                                      child: Text(list[index]))));
                        }))),
          );
        },
      );

  Widget get _getGender => BlocBuilder<UserDataBloc, UserDataState>(
        builder: (BuildContext context, state) {
          List<String> list = ["Female", "Male", "Others"];
          return Card(
            child: AnimatedContainer(
              duration: Duration(milliseconds: 1500),
              child: ListTile(
                  title: Text(tr('gender')),
                  trailing: SizedBox(
                      width: 265,
                      child: ListView.builder(
                          itemCount: list.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                                onTap: () {
                                  context
                                      .read<UserDataBloc>()
                                      .add(OnGenderChangeEvent(list[index]));
                                },
                                child: Center(
                                    child: Container(
                                        padding: EdgeInsets.all(8),
                                        margin:
                                            EdgeInsets.only(left: 8, right: 8),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              color: state.gender == list[index]
                                                  ? Theme.of(context)
                                                      .colorScheme
                                                      .primary
                                                  : Theme.of(context).cardColor,
                                            ),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(20))),
                                        child: Text(list[index]))));
                          }))),
            ),
          );
        },
      );

  Widget get _getAlcohol => BlocBuilder<UserDataBloc, UserDataState>(
        builder: (BuildContext context, state) {
          List<String> list = ["No", "Some times", "Evry day"];
          return Card(
            child: ListTile(
                title: Text(tr("drink_alcohol")),
                trailing: SizedBox(
                    width: 260,
                    child: ListView.builder(
                        itemCount: list.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                              onTap: () {
                                context
                                    .read<UserDataBloc>()
                                    .add(OnAlcoholChangeEvent(index));
                              },
                              child: Center(
                                  child: Container(
                                      padding: EdgeInsets.all(8),
                                      margin:
                                          EdgeInsets.only(left: 8, right: 8),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: state.alcohol == index
                                                ? Theme.of(context)
                                                    .colorScheme
                                                    .primary
                                                : Theme.of(context).cardColor,
                                          ),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(20))),
                                      child: Text(list[index]))));
                        }))),
          );
        },
      );

  Widget get _getStepsPerDay => BlocBuilder<UserDataBloc, UserDataState>(
        builder: (BuildContext context, state) {
          return _getContainer(
              context: context,
              customHeight: 110,
              child: Column(
                children: [
                  Text(tr("steps_per_day_description")),
                  NumberPicker(
                    value: state.stepsPerDay.toInt(),
                    minValue: 0,
                    maxValue: 50000,
                    step: 500,
                    selectedTextStyle: TextStyle(
                        fontSize: 22,
                        foreground: Paint()
                          ..shader = WidgetThemes.linearGradient(context)),
                    textStyle: Theme.of(context).textTheme.bodyText1,
                    itemHeight: 70,
                    axis: Axis.horizontal,
                    onChanged: (value) => context
                        .read<UserDataBloc>()
                        .add(OnStetsChangeEvent(value.toDouble())),
                    // decoration: BoxDecoration(
                    //     image: DecorationImage(
                    //       image: AssetImage("assets/img/blob.png"),
                    //       fit: BoxFit.fitHeight
                    //     ),
                    //   // borderRadius: BorderRadius.circular(1000),
                    //   // border: Border.all(color: Theme.of(context).colorScheme.primary),
                    // ),
                  ),
                ],
              ),
              title: tr("steps_per_day"));
        },
      );

  Widget get _getBirthday => BlocBuilder<UserDataBloc, UserDataState>(
          builder: (BuildContext context, state) {
        return _getContainer(
            context: context,
            customHeight: 200,
            title: tr("birthday"),
            child: Center(
                child: SfDateRangePicker(
                    minDate: DateTime(1950, 1, 1),
                    maxDate: DateTime(2010, 12, 31),
                    selectionTextStyle: TextStyle(fontSize: 12),
                    initialSelectedDate: DateTime(1989, 1, 11),
                    initialDisplayDate: DateTime(1989, 1, 11),
                    onSelectionChanged: (v) => context.read<UserDataBloc>().add(
                        OnBirthdayChangeEvent(
                            v.value.millisecondsSinceEpoch)))));
      });

  Widget get _getWeight => BlocBuilder<UserDataBloc, UserDataState>(
        builder: (BuildContext context, state) {
          return _getContainer(
              customHeight: 100,
              context: context,
              title: tr("weight"),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                child: Container(
                  child: WeightSlider(
                    weight: state.weight.toInt(),
                    minWeight: 40,
                    maxWeight: 120,
                    onChange: (val) => context
                        .read<UserDataBloc>()
                        .add(OnWeightChangeEvent(val.toDouble())),
                    unit: tr("kg"), // todo add selector metric system
                  ),
                ),
              ));
        },
      );

  Widget get _getHeightSlider => BlocBuilder<UserDataBloc, UserDataState>(
        builder: (BuildContext context, state) {
          return _getContainer(
              customHeight: 100,
              context: context,
              title: tr("height"),
              child: SleekCircularSlider(
                appearance: CircularSliderAppearance(
                    animationEnabled: true,
                    customWidths: CustomSliderWidths(
                      progressBarWidth: 5,
                    ),
                    counterClockwise: false,
                    infoProperties: InfoProperties(
                      mainLabelStyle: const TextStyle(fontSize: 20),
                      // topLabelText: "label",
                      modifier: (v) =>
                          WidgetThemes.percentageModifier(v, tr("sm")),
                    ),
                    customColors: CustomSliderColors(
                        trackColor: Theme.of(context).primaryColorLight,
                        dotColor: Colors.transparent,
                        progressBarColors: [
                          Theme.of(context).colorScheme.primary,
                          Theme.of(context).colorScheme.secondary
                        ])),
                min: 100,
                max: 250,
                initialValue: 130,
                onChangeEnd: (double endValue) => context
                    .read<UserDataBloc>()
                    .add(OnHeightChangeEvent(endValue.ceil().toDouble())),
              ));
        },
      );

  Widget get _geWeekSportTimeSlider => BlocBuilder<UserDataBloc, UserDataState>(
        builder: (BuildContext context, state) {
          return _getContainer(
              customHeight: 200,
              context: context,
              title: tr("sports_per_week"),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(tr("sports_per_week_description")),
                  ),
                  SleekCircularSlider(
                    appearance: CircularSliderAppearance(
                        animationEnabled: true,
                        customWidths: CustomSliderWidths(
                          progressBarWidth: 5,
                        ),
                        counterClockwise: false,
                        infoProperties: InfoProperties(
                          mainLabelStyle: const TextStyle(fontSize: 20),
                          // topLabelText: "label",
                          modifier: (v) =>
                              WidgetThemes.percentageModifier(v, ":00"),
                        ),
                        customColors: CustomSliderColors(
                            trackColor: Theme.of(context).primaryColorLight,
                            dotColor: Colors.transparent,
                            progressBarColors: [
                              Theme.of(context).colorScheme.primary,
                              Theme.of(context).colorScheme.secondary
                            ])),
                    min: 0,
                    max: 6,
                    initialValue: 1,
                    onChangeEnd: (double endValue) => context
                        .read<UserDataBloc>()
                        .add(OnHoursSportChangeEvent(
                            endValue.ceil().toDouble())),
                  ),
                ],
              ));
        },
      );

  // Widget get _getGenderSelector => BlocBuilder<UserDataBloc, UserDataState>(
  //       builder: (BuildContext context, state) {
  //         return _getContainer(
  //             customHeight: 100,
  //             context: context,
  //             child: GenderPickerWithImage(
  //               showOtherGender: true,
  //               verticalAlignedText: true,
  //               selectedGender: getGenderByString(state.gender),
  //               selectedGenderTextStyle: TextStyle(
  //                   color: Theme.of(context).cardColor,
  //                   fontWeight: FontWeight.bold),
  //               unSelectedGenderTextStyle: TextStyle(
  //                   color: Theme.of(context).cardColor,
  //                   fontWeight: FontWeight.normal),
  //               onChanged: (gender) {
  //                 context
  //                     .read<UserDataBloc>()
  //                     .add(OnGenderChangeEvent(getGenderString(gender)));
  //               },
  //               equallyAligned: true,
  //               animationDuration: Duration(milliseconds: 500),
  //               isCircular: true,
  //               // default : true,
  //               opacityOfGradient: 0.4,
  //               padding: const EdgeInsets.all(3),
  //               size: ifTablet ? 150 : 50, //default : 40
  //             ),
  //             title: "gender");
  //       },
  //     );

  Gender getGenderByString(String s) {
    switch (s.toUpperCase()) {
      case "MALE":
        return Gender.Male;
      case "FEEALE":
        return Gender.Female;
      default:
        return Gender.Others;
    }
  }

  String getGenderString(Gender? gender) {
    switch (gender) {
      case Gender.Male:
        return "MALE";
      case Gender.Female:
        return "FEEALE";
      default:
        return "OTHERS";
    }
  }
}
