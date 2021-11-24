

import 'package:flutter/foundation.dart';

@immutable
abstract class UserDataEvent{}

class OnNameChangeEvent extends UserDataEvent{
  final String name;

  OnNameChangeEvent(this.name);
}

class OnEmailChangeEvent extends UserDataEvent{
  final String email;

  OnEmailChangeEvent(this.email);
}

class OnEgeChangeEvent extends UserDataEvent{
  final int age;

  OnEgeChangeEvent(this.age);
}

class OnWeightChangeEvent extends UserDataEvent{
  final double weight;

  OnWeightChangeEvent(this.weight);
}

class OnHeightChangeEvent extends UserDataEvent{
  final double height;

  OnHeightChangeEvent(this.height);
}

class OnStetsChangeEvent extends UserDataEvent{
  final double steps;

  OnStetsChangeEvent(this.steps);
}

class OnAvatarChangeEvent extends UserDataEvent{
  final String avatar;

  OnAvatarChangeEvent(this.avatar);
}

class OnGenderChangeEvent extends UserDataEvent{
  final String gender;

  OnGenderChangeEvent(this.gender);
}

class OnVeganChangeEvent extends UserDataEvent{
  final bool ifVegan;

  OnVeganChangeEvent(this.ifVegan);
}

class OnHoursSportChangeEvent extends UserDataEvent{
  final double hourSportPerWeek;

  OnHoursSportChangeEvent(this.hourSportPerWeek);
}

class OnAlcoholChangeEvent extends UserDataEvent{
  final int alcohol;

  OnAlcoholChangeEvent(this.alcohol);
}

class OnBirthdayChangeEvent extends UserDataEvent{
  final int birthday;

  OnBirthdayChangeEvent(this.birthday);
}

class OnSmokeChangeEvent extends UserDataEvent{
  final int smoke;

  OnSmokeChangeEvent(this.smoke);
}





