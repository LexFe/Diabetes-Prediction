import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:frontend/common/enum/state_status.dart';
import 'package:frontend/model/predicts_model.dart';

part 'predicts_event.dart';
part 'predicts_state.dart';

class PredictsBloc extends Bloc<PredictsEvent, PredictsState> {
  PredictsBloc() : super(const PredictsState()) {
    on<PredictsFetch>((event, emit) {
      emit(state.copyWith(
          predictsModel: event.predictsModel,
          predictsModelSearch: event.predictsModel));
    });

    on<ChangeStatus>((event, emit) {
      emit(state.copyWith(status: event.status));
    });

    on<SearchPredict>((event, emit) {
      if (event.search.isEmpty) {
        emit(state.copyWith(predictsModel: state.predictsModelSearch));
        return;
      } else {
        final List<PredictsModel> predictsModel = state.predictsModelSearch
            .where((element) => element.name!
                .toLowerCase()
                .contains(event.search.toLowerCase()))
            .toList();
        emit(state.copyWith(predictsModel: predictsModel));
      }
    });
  }
}
