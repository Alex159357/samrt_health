


import 'package:flutter_bloc/flutter_bloc.dart';

import 'intr.dart';

class IntroCubit extends Cubit<Intro>{
  IntroCubit(Intro initialState) : super(initialState);

  void add(Intro intro) => emit(intro);
}