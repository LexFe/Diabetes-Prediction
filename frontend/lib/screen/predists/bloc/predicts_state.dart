part of 'predicts_bloc.dart';

class PredictsState extends Equatable {
  final StateStatus status;
  final List<PredictsModel> predictsModel;
  const PredictsState({
    this.status = StateStatus.loading,
    this.predictsModel = const <PredictsModel>[],
  });

  PredictsState copyWith({
    StateStatus? status,
    List<PredictsModel>? predictsModel,
  }) {
    return PredictsState(
      status: status ?? this.status,
      predictsModel: predictsModel ?? this.predictsModel,
    );
  }

  @override
  List<Object> get props => [status, predictsModel];
}
