import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/common/service/storage_service.dart';
import 'package:frontend/routes/global_observer.dart';

class Global {
  
  static late Service userService;
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    Bloc.observer = MyGlobalObserver();
    userService = await Service().init();
  }
}
