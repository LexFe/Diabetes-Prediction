import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/global.dart';
import 'package:frontend/routes/name.dart';
import 'package:frontend/screen/home/bloc/home_bloc.dart';
import 'package:frontend/screen/home/home.dart';


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
