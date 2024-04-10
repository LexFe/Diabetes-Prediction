import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/common/enum/state_status.dart';
import 'package:frontend/common/utils/http_utils.dart';
import 'package:frontend/model/predicts_model.dart';
import 'package:frontend/routes/name.dart';
import 'package:frontend/screen/predists/bloc/predicts_bloc.dart';

class PredictsController {
  final BuildContext context;
  const PredictsController({required this.context});

  Future<void> handleGetPredict() async {
    try {
      context
          .read<PredictsBloc>()
          .add(const ChangeStatus(status: StateStatus.loading));
      Response response = await HttpUtil().get('/predict/all-predict');
      if (response.statusCode == 200) {
        final List dynamicList = response.data as List;
        List<PredictsModel> predictsModel =
            dynamicList.map((json) => PredictsModel.fromJson(json)).toList();
        if (context.mounted) {
        
          context
              .read<PredictsBloc>()
              .add(PredictsFetch(predictsModel: predictsModel));
          context
              .read<PredictsBloc>()
              .add(const ChangeStatus(status: StateStatus.loaded));
        }
      } else {
        debugPrint('predictsModel: ${response.data}');
      }
    } catch (e) {
      debugPrint('predictsModel: $e');
    }
  }
}
