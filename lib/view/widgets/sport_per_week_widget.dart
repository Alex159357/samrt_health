

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/src/provider.dart';
import 'package:samrt_health/bloc/bloc/user_data/user_data_bloc.dart';
import 'package:samrt_health/bloc/event/user_data/user_data_event.dart';
import 'package:samrt_health/bloc/state/user_data/user_data_state.dart';
import 'package:samrt_health/theme/widget_themes.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class SportPerDayWidget extends StatelessWidget {
  const SportPerDayWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _geWeekSportTimeSlider;
  }

  Widget get _geWeekSportTimeSlider => BlocBuilder<UserDataBloc, UserDataState>(
    builder: (BuildContext context, state) {
      return Card(
        child: Column(
          children: [
            Text(tr("sports_per_week"), style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Theme.of(context).colorScheme.secondary),),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(tr("sports_per_week_description"), style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Theme.of(context).primaryColor),),
            ),
            SleekCircularSlider(
              appearance: CircularSliderAppearance(
                  animationEnabled: true,
                  customWidths: CustomSliderWidths(
                    progressBarWidth: 5,
                  ),
                  counterClockwise: false,
                  infoProperties: InfoProperties(
                    mainLabelStyle: Theme.of(context).textTheme.bodyText2?.copyWith(color: Theme.of(context).primaryColor),
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
        ),
      );
    },
  );

}
