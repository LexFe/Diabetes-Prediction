part of 'main_manage_bloc.dart';

sealed class MainManageState extends Equatable {
  const MainManageState();
  
  @override
  List<Object> get props => [];
}

final class MainManageInitial extends MainManageState {}
