

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samrt_health/navigation/auth/auth_pages.dart';

class AuthCubit extends Cubit<AuthPages>{
  AuthCubit() : super(AuthPages.LOGIN);

  void goTo(AuthPages pages) => emit(pages);
}