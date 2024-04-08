part of 'predict_bloc.dart';

sealed class PredictState extends Equatable {
  const PredictState();
  
  @override
  List<Object> get props => [];
}

final class PredictInitial extends PredictState {}
