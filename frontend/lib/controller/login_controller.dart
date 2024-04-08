import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/common/utils/http_utils.dart';
import 'package:frontend/screen/login/bloc/login_bloc.dart';

class LoginController {
  final BuildContext context;
  const LoginController({required this.context});

  Future<void> handleLogin() async {
    final state = BlocProvider.of<LoginBloc>(context).state;
    String email = state.email;
    String password = state.password;
    if (email.isEmpty || password.isEmpty) {
      Fluttertoast.showToast(msg: 'Email and password cannot be empty');
      return;
    }
    if (!email.contains('@')) {
      Fluttertoast.showToast(msg: 'Invalid email');
      return;
    }
    if (password.length < 6) {
      Fluttertoast.showToast(msg: 'Password must be at least 6 characters');
      return;
    } else {
      Response response = await HttpUtil()
          .post('/auth', data: {'username': email, 'password': password});
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: 'Login success');
      } else {
        Fluttertoast.showToast(msg: 'Login failed');
      }
    }
  }
}
