import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/common/utils/http_utils.dart';
import 'package:frontend/common/values/constant.dart';
import 'package:frontend/global.dart';
import 'package:frontend/routes/name.dart';
import 'package:frontend/screen/login/bloc/login_bloc.dart';

class LoginController {
  final BuildContext context;
  const LoginController({required this.context});

  Future<void> handleLogin() async {
    final state = BlocProvider.of<LoginBloc>(context).state;
    String email = state.email;
    String password = state.password;
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('ກະລຸນາກວດສອບຂໍ້ມູນ'),
        ),
      );
      return;
    }
    if (!email.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('ກະລຸນາໃສ່ອີເມວທີ່ຖືກຕ້ອງ'),
        ),
      );
      return;
    }
    if (password.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('ລະຫັດຜ່ານຕ້ອງ 6 ໂຕອັກສອນຂຶ້ນໄປ'),
        ),
      );
      return;
    } else {
      var formData = FormData.fromMap({
        'username': email,
        'password': password,
      });
      Response response = await HttpUtil().post('/auth', data: formData);
      if (response.statusCode == 200) {
        Global.userService.setString(
          AppConstants.STORAGE_USER_TOKEN_KEY,
          response.data['access_token'],
        );

        Navigator.pushNamedAndRemoveUntil(
            context, AppRoutes.Home, (route) => false);
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("ບັນຂີຜູ້ໃຊ້ຫຼືລະຫັດຜ່ານບໍ່ຖືກຕ້ອງ"),
            ),
          );
          return;
        }
      }
    }
  }
}
