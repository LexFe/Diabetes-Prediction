import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/screen/home/bloc/home_bloc.dart';

class AppBlocProvider {
  static get allBlocProvider => [
        BlocProvider(
          create: (context) => HomeBloc(),
        ),
      ];
}
