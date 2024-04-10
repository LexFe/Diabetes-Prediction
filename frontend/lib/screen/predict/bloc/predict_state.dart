part of 'predict_bloc.dart';

class PredictState extends Equatable {
  final int pregnancies;
  final int glucose;
  final int bloodPressure;
  final int skinThickness;
  final int insulin;
  final double bmi;
  final int age;
  final double diabetesPedigreeFunction;
  const PredictState({
    this.pregnancies = 0,
    this.glucose = 0,
    this.bloodPressure = 0,
    this.skinThickness = 0,
    this.insulin = 0,
    this.bmi = 0.0,
    this.age = 0,
    this.diabetesPedigreeFunction = 0.0,
  });

  PredictState copyWith({
    int? pregnancies,
    int? glucose,
    int? bloodPressure,
    int? skinThickness,
    int? insulin,
    double? bmi,
    int? age,
    double? diabetesPedigreeFunction,
  }) {
    return PredictState(
      pregnancies: pregnancies ?? this.pregnancies,
      glucose: glucose ?? this.glucose,
      bloodPressure: bloodPressure ?? this.bloodPressure,
      skinThickness: skinThickness ?? this.skinThickness,
      insulin: insulin ?? this.insulin,
      bmi: bmi ?? this.bmi,
      age: age ?? this.age,
      diabetesPedigreeFunction:
          diabetesPedigreeFunction ?? this.diabetesPedigreeFunction,
    );
  }

  @override
  List<Object> get props => [
        pregnancies,
        glucose,
        bloodPressure,
        skinThickness,
        insulin,
        bmi,
        age,
        diabetesPedigreeFunction,
      ];
}
