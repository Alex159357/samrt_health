
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samrt_health/navigation/main/pages.dart';

class MainNavCubit extends Cubit<Pages>{

  MainNavCubit(Pages initialState) : super(initialState);

  void goToScreen(Pages pages) => emit(pages);

}