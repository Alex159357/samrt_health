import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:samrt_health/bloc/user_data/user_data_bloc.dart';
import 'package:samrt_health/state/user_data/user_data_state.dart';
import 'package:samrt_health/theme/theme.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:weight_slider/weight_slider.dart';
import 'package:samrt_health/event/user_data/user_data_event.dart';
import '../../main.dart';

class UserData extends StatelessWidget {
  const UserData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ThemeSwitcher(
              clipper: ThemeSwitcherCircleClipper(),
              builder: (context) {
                return ThemeSwitcher(
                  builder: (context) {
                    return IconButton(
                      onPressed: () {
                        var brightness = ThemeProvider.of(context)!.brightness;
                        ThemeSwitcher.of(context)!.changeTheme(
                          theme: brightness == Brightness.light
                              ? AppTheme.darkTheme
                              : AppTheme.lightTheme,
                          reverseAnimation:
                              brightness == Brightness.dark ? true : false,
                        );
                      },
                      icon: ThemeProvider.of(context)!.brightness == Brightness.light? Icon(Icons.brightness_3, size: 25): Icon(Icons.brightness_4, size: 25),
                    );
                  },
                );
              })
        ],
      ),
      body: BlocProvider(
          create: (BuildContext context) => UserDataBloc(),
          child: SafeArea(child: _getBody(context))),
    );
  }

  Widget _getBody(BuildContext context) => CustomScrollView(
        slivers: [
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
                      lg: 3,
                      child: Card(
                        child: Container(height: 100, child: Text("")),
                      ),
                    ),
                    ResponsiveGridCol(
                        xs: 12,
                        sm: 4,
                        md: 4,
                        lg: 3,
                        child: _getContainer(
                            child: GestureDetector(
                          onTap: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime(1950, 1, 1),
                              firstDate: DateTime(1950, 1),
                              lastDate: DateTime(2010),
                            );
                          },
                          child: Text("Date"),
                        ))),
                  ]),
                ),
              ),
            ]),
          )
        ],
      );

  Widget _getContainer({required Widget child}) {
    return Card(
      borderOnForeground: true,
      child: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          height: 200,
          // decoration: BoxDecoration(
          //   color: Colors.grey,
          //   borderRadius: const BorderRadius.only(
          //       topLeft: Radius.circular(10),
          //       topRight: Radius.circular(10),
          //       bottomLeft: Radius.circular(10),
          //       bottomRight: Radius.circular(10)),
          //   boxShadow: [
          //     BoxShadow(
          //       color: Colors.grey.withOpacity(0.5),
          //       spreadRadius: 5,
          //       blurRadius: 7,
          //       offset: const Offset(0, 3), // changes position of shadow
          //     ),
          //   ],
          // ),
          child: child),
    );
  }

  Widget get _getWeight => BlocBuilder<UserDataBloc, UserDataState>(
        builder: (BuildContext context, state) {
          return _getContainer(
              child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            child: WeightSlider(
              weight: state.weight.toInt(),
              minWeight: 40,
              maxWeight: 120,
              onChange: (val) => context
                  .read<UserDataBloc>()
                  .add(OnWeightChangeEvent(val.toDouble())),
              unit: tr('kg'), // todo add selector metric system
            ),
          ));
        },
      );

  Widget get _getHeightSlider => BlocBuilder<UserDataBloc, UserDataState>(
        builder: (BuildContext context, state) {
          return _getContainer(
              child: SleekCircularSlider(
            appearance: CircularSliderAppearance(
                customWidths: CustomSliderWidths(
                  progressBarWidth: 5,
                ),
                counterClockwise: false,
                infoProperties: InfoProperties(
                  bottomLabelText: tr("height"),
                  // topLabelText: "label",
                  modifier: percentageModifier,
                ),
                customColors: CustomSliderColors(
                    trackColor: Color(0x338167e6),
                    dotColor: Colors.pink,
                    progressBarColors: [Color(0xff8167e6), Colors.tealAccent])),
            min: 100,
            max: 250,
            initialValue: 130,
            onChangeEnd: (double endValue) => context
                .read<UserDataBloc>()
                .add(OnHeightChangeEvent(endValue.ceil().toDouble())),
          ));
        },
      );
}

String percentageModifier(double value) {
  final roundedValue = value.ceil().toInt().toString();
  return '$roundedValue sm';
}
