import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/global.dart';
import 'package:frontend/screen/app.dart';

Future<void> main() async {
  Global.init();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}