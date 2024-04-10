part of 'predict_bloc.dart';

sealed class PredictEvent extends Equatable {
  const PredictEvent();

  @override
  List<Object> get props => [];
}

class Pregnancies extends PredictEvent {
  final int pregnancies;

  const Pregnancies({required this.pregnancies});

  @override
  List<Object> get props => [pregnancies];
}

class Glucose extends PredictEvent {
  final int glucose;

  const Glucose({required this.glucose});

  @override
  List<Object> get props => [glucose];
}

class BloodPressure extends PredictEvent {
  final int bloodPressure;

  const BloodPressure({required this.bloodPressure});

  @override
  List<Object> get props => [bloodPressure];
}

class SkinThickness extends PredictEvent {
  final int skinThickness;

  const SkinThickness({required this.skinThickness});

  @override
  List<Object> get props => [skinThickness];
}

class Insulin extends PredictEvent {
  final int insulin;

  const Insulin({required this.insulin});

  @override
  List<Object> get props => [insulin];
}

class Bmi extends PredictEvent {
  final double bmi;

  const Bmi({required this.bmi});

  @override
  List<Object> get props => [bmi];
}

class DiabetesPedigreeFunction extends PredictEvent {
  final double diabetesPedigreeFunction;

  const DiabetesPedigreeFunction({required this.diabetesPedigreeFunction});

  @override
  List<Object> get props => [diabetesPedigreeFunction];
}

class Age extends PredictEvent {
  final int age;

  const Age({required this.age});

  @override
  List<Object> get props => [age];
}

class ResetState extends PredictEvent {
  const ResetState();

  @override
  List<Object> get props => [];
}