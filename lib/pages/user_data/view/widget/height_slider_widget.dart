

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:height_slider/height_slider.dart';
import 'package:samrt_health/bloc/bloc/user_data/user_data_bloc.dart';
import 'package:samrt_health/bloc/event/user_data/user_data_event.dart';
import 'package:samrt_health/bloc/state/user_data/user_data_state.dart';

class HeightSliderView extends StatelessWidget {
  const HeightSliderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _getHeightSlider;
  }


  Widget get _getHeightSlider => BlocBuilder<UserDataBloc, UserDataState>(
    builder: (BuildContext context, state) {
      return SizedBox(
        height: 300,
        width: 250,
        child: HeightSlider(
          height: state.height.toInt(),
          onChange: (val) => {
            context
                .read<UserDataBloc>()
                .add(OnHeightChangeEvent(val.toDouble()))
          },
          unit: 'cm', // optional
        ),
      );
    },
  );

}
