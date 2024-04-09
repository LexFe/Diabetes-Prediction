import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/common/utils/http_utils.dart';

class AdminController {
  final BuildContext context;
  const AdminController({required this.context});

  Future<void> handleGetAdmin() async {
    try {
      Response response = await HttpUtil().get('/user/all');
      if (response.statusCode == 200) {
        print(response.data);
        Fluttertoast.showToast(msg: 'Get admin success');
      } else {
        print(response.data);
        Fluttertoast.showToast(msg: 'Get admin failed');
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: 'Get admin failed');
    }
  }
}   // Path: lib/controller/admin_controller.dart 
