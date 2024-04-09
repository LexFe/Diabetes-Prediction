import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'main_manage_event.dart';
part 'main_manage_state.dart';

class MainManageBloc extends Bloc<MainManageEvent, MainManageState> {
  MainManageBloc() : super(MainManageInitial()) {
    on<MainManageEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
