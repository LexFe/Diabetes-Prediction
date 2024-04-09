import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'recomment_event.dart';
part 'recomment_state.dart';

class RecommentBloc extends Bloc<RecommentEvent, RecommentState> {
  RecommentBloc() : super(RecommentInitial()) {
    on<RecommentEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
