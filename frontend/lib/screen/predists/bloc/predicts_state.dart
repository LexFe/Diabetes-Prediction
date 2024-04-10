part of 'predicts_bloc.dart';

class PredictsState extends Equatable {
  final StateStatus status;
  final String search;
  final List<PredictsModel> predictsModel;
  final List<PredictsModel> predictsModelSearch;

  const PredictsState({
    this.search = '',
    this.status = StateStatus.loading,
    this.predictsModel = const <PredictsModel>[],
    this.predictsModelSearch = const <PredictsModel>[],
  });

  PredictsState copyWith({
    String? search,
    StateStatus? status,
    List<PredictsModel>? predictsModel,
    List<PredictsModel>? predictsModelSearch,
  }) {
    return PredictsState(
      search: search ?? this.search,
      status: status ?? this.status,
      predictsModel: predictsModel ?? this.predictsModel,
      predictsModelSearch: predictsModelSearch ?? this.predictsModelSearch,
    );
  }

  @override
  List<Object> get props => [
        search,
        status,
        predictsModel,
        predictsModelSearch,
      ];
}
