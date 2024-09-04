import 'package:bloc/bloc.dart';
import 'package:flutter_cubit_login/cubit/auth_state.dart';

import '../data/user.dart';

class AuthCubit extends Cubit<AuthState>{
  AuthCubit() : super(const AuthInitial());

  // trong phần cubit này có thể viết các func để gọi api từ repository

  void login(String username, String password){
    if(username.isNotEmpty && password.isNotEmpty){
      emit(AuthSuccess( user: User(username: username, password: password)));
    } else {
      emit(AuthError(message: "Invalid credentials"));
    }
  }
}