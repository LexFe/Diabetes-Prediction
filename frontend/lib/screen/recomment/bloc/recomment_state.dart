part of 'recomment_bloc.dart';

sealed class RecommentState extends Equatable {
  const RecommentState();
  
  @override
  List<Object> get props => [];
}

final class RecommentInitial extends RecommentState {}
