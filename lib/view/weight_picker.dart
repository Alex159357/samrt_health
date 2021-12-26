import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:samrt_health/bloc/bloc/user_data/user_data_bloc.dart';
import 'package:samrt_health/bloc/event/user_data/user_data_event.dart';
import 'package:samrt_health/bloc/state/user_data/user_data_state.dart';
import 'package:samrt_health/theme/widget_themes.dart';

class WeightPicker extends StatelessWidget {
  const WeightPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDataBloc, UserDataState>(
        builder: (BuildContext context, state) {
        return  AnimatedContainer(
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
                      Text("Weight", style: Theme.of(context).textTheme.headline6),
                    ),
                    NumberPicker(
                      value: state.weight.toInt(),
                      minValue: 40,
                      maxValue: 150,
                      itemCount: 3,
                      step: 1,
                      itemWidth: 50,
                      selectedTextStyle: TextStyle(
                          fontSize: 22,
                          foreground: Paint()
                            ..shader = WidgetThemes.linearGradient(context)),
                      textStyle: Theme.of(context).textTheme.bodyText1,
                      itemHeight: 60,
                      axis: Axis.horizontal,
                      onChanged: (value) => context
                          .read<UserDataBloc>()
                          .add(OnWeightChangeEvent(value.toDouble())),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/img/blob.png"),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );

    });
  }
}
