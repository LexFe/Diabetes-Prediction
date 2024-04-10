part of 'predicts_bloc.dart';

class PredictsState extends Equatable {
  final StateStatus status;
  final List<PredictsModel> predictsModel;
  final List<PredictsModel> predictsModelSearch;

  const PredictsState({
    this.status = StateStatus.loading,
    this.predictsModel = const <PredictsModel>[],
    this.predictsModelSearch = const <PredictsModel>[],
  });

  PredictsState copyWith({
    StateStatus? status,
    List<PredictsModel>? predictsModel,
    List<PredictsModel>? predictsModelSearch,

  }) {
    return PredictsState(
      status: status ?? this.status,
      predictsModel: predictsModel ?? this.predictsModel,
      predictsModelSearch: predictsModelSearch ?? this.predictsModelSearch,
    );
  }

  @override
  List<Object> get props => [status, predictsModel , predictsModelSearch];
}
