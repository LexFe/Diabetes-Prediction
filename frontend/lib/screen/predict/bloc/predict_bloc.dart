import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'predict_event.dart';
part 'predict_state.dart';

class PredictBloc extends Bloc<PredictEvent, PredictState> {
  PredictBloc() : super(const PredictState()) {
    on<Pregnancies>((event, emit) {
      emit(state.copyWith(pregnancies: event.pregnancies));
    });
    on<Glucose>((event, emit) {
      emit(state.copyWith(glucose: event.glucose));
    });
    on<BloodPressure>((event, emit) {
      emit(state.copyWith(bloodPressure: event.bloodPressure));
    });
    on<SkinThickness>((event, emit) {
      emit(state.copyWith(skinThickness: event.skinThickness));
    });
    on<Insulin>((event, emit) {
      emit(state.copyWith(insulin: event.insulin));
    });
    on<Bmi>((event, emit) {
      emit(state.copyWith(bmi: event.bmi));
    });

    on<Age>((event, emit) {
      emit(state.copyWith(age: event.age));
    });

    on<DiabetesPedigreeFunction>((event, emit) {
      emit(state.copyWith(
          diabetesPedigreeFunction: event.diabetesPedigreeFunction));
    });

    on<ResetState>((event, emit) {
      emit(state.copyWith(
          pregnancies: 0,
          glucose: 0,
          bloodPressure: 0,
          skinThickness: 0,
          insulin: 0,
          bmi: 0.0,
          age: 0,
          diabetesPedigreeFunction: 0.0));
    });
  }
}
