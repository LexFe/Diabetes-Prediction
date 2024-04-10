import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/global.dart';
import 'package:frontend/routes/name.dart';
import 'package:frontend/screen/admin/admin.dart';
import 'package:frontend/screen/admin/bloc/admin_bloc.dart';
import 'package:frontend/screen/home/bloc/home_bloc.dart';
import 'package:frontend/screen/home/home.dart';
import 'package:frontend/screen/login/bloc/login_bloc.dart';
import 'package:frontend/screen/login/login.dart';
import 'package:frontend/screen/main_manage/bloc/main_manage_bloc.dart';
import 'package:frontend/screen/main_manage/main_manage.dart';
import 'package:frontend/screen/predict/bloc/predict_bloc.dart';
import 'package:frontend/screen/predict/predict.dart';
import 'package:frontend/screen/predists/bloc/predicts_bloc.dart';
import 'package:frontend/screen/predists/predicts.dart';
import 'package:frontend/screen/recomment/bloc/recomment_bloc.dart';
import 'package:frontend/screen/recomment/recomment.dart';

class AppPage {
  static List<PageEntity> routes() {
    return [
      PageEntity(
        route: AppRoutes.Home,
        page: const HomePages(),
        bloc: BlocProvider(
          create: (_) => HomeBloc(),
        ),
      ),
      PageEntity(
        route: AppRoutes.Predict,
        page: const PredictPages(),
        bloc: BlocProvider(
          create: (_) => PredictBloc(),
        ),
      ),
      PageEntity(
        route: AppRoutes.Predicts,
        page: const PredictsPages(),
        bloc: BlocProvider(
          create: (_) => PredictsBloc(),
        ),
      ),
      PageEntity(
        route: AppRoutes.MainManages,
        page: const MainManagePages(),
        bloc: BlocProvider(
          create: (_) => MainManageBloc(),
        ),
      ),
      PageEntity(
        route: AppRoutes.Admin,
        page: const AdminPages(),
        bloc: BlocProvider(
          create: (_) => AdminBloc(),
        ),
      ),
      PageEntity(
        route: AppRoutes.Recomment,
        page: const RecommentPages(),
        bloc: BlocProvider(
          create: (_) => RecommentBloc(),
        ),
      ),
      PageEntity(
        route: AppRoutes.Login,
        page: const LoginPages(),
        bloc: BlocProvider(
          create: (_) => LoginBloc(),
        ),
      ),
    ];
  }

  static List<dynamic> allBlocProvider(BuildContext context) {
    List<dynamic> blocProvider = <dynamic>[];
    for (var bloc in routes()) {
      blocProvider.add(bloc.bloc);
    }
    return blocProvider;
  }

  // ignore: non_constant_identifier_names
  static MaterialPageRoute GenerateRoutsSettings(RouteSettings settings) {
    if (settings.name != null) {
      var result = routes().where((element) => element.route == settings.name);
      if (result.isNotEmpty) {
        if (result.first.route == AppRoutes.Home) {
          bool isLogin = Global.userService.getIsLoggedIn();
          if (isLogin) {
            return MaterialPageRoute(
                builder: (_) => const HomePages(), settings: settings);
          }
        }
        return MaterialPageRoute(
            builder: (_) => result.first.page, settings: settings);
      }
    }
    return MaterialPageRoute(
        builder: (_) => const HomePages(), settings: settings);
  }
}

class PageEntity {
  String route;
  Widget page;
  dynamic bloc;
  PageEntity({required this.route, required this.page, required this.bloc});
}
