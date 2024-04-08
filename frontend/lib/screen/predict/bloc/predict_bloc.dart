import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'predict_event.dart';
part 'predict_state.dart';

class PredictBloc extends Bloc<PredictEvent, PredictState> {
  PredictBloc() : super(PredictInitial()) {
    on<PredictEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
