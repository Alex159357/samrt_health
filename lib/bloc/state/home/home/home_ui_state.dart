
import 'package:flutter/material.dart';

class HomeMainUiState{

  final bool ifActionsOpened;

  HomeMainUiState({this.ifActionsOpened = false});

  HomeMainUiState copyWith({bool? ifActionsOpened}) => HomeMainUiState(
    ifActionsOpened: ifActionsOpened ?? this.ifActionsOpened
  );


}

