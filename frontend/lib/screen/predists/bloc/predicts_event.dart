part of 'predicts_bloc.dart';

sealed class PredictsEvent extends Equatable {
  const PredictsEvent();

  @override
  List<Object> get props => [];
}

class PredictsFetch extends PredictsEvent {
  final List<PredictsModel> predictsModel;
  const PredictsFetch({required this.predictsModel});

  @override
  List<Object> get props => [predictsModel];
}

class ChangeStatus extends PredictsEvent {
  final StateStatus status;
  const ChangeStatus({required this.status});

  @override
  List<Object> get props => [status];
}

class SearchPredict extends PredictsEvent {
  final String search;
  const SearchPredict({required this.search});

  @override
  List<Object> get props => [search];
}
