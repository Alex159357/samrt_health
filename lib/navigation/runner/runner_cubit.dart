

import 'package:flutter_bloc/flutter_bloc.dart';

class RunnerCubit extends Cubit<bool>{
  RunnerCubit() : super(false);

  void complete(bool state)=> emit(state);

}