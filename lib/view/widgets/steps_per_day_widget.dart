

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:samrt_health/bloc/bloc/user_data/user_data_bloc.dart';
import 'package:samrt_health/bloc/event/user_data/user_data_event.dart';
import 'package:samrt_health/bloc/state/user_data/user_data_state.dart';
import 'package:samrt_health/theme/widget_themes.dart';

class StepsPerDayWidget extends StatelessWidget {
  const StepsPerDayWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _getStepsPerDay;
  }

  Widget get _getStepsPerDay => BlocBuilder<UserDataBloc, UserDataState>(
    builder: (BuildContext context, state) {
      return Card(
        child: Column(
          children: [
            Text( tr("steps_per_day"), style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Theme.of(context).primaryColor),),
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
      );
    },
  );
}
