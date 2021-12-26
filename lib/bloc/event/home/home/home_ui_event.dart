


import 'package:flutter/material.dart';

@immutable
abstract class HomeUiEvent{}

class ToggleBSEvent extends HomeUiEvent{
  final bool ifExpanded;

  ToggleBSEvent(this.ifExpanded);
}