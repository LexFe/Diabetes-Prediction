import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/common/utils/http_utils.dart';
import 'package:frontend/screen/predict/bloc/predict_bloc.dart';

class PredictController {
  final BuildContext context;
  const PredictController({required this.context});

  Future<void> handlePredict() async {
    final state = context.read<PredictBloc>().state;
    int pregnancies = state.pregnancies;
    int glucose = state.glucose;
    int bloodPressure = state.bloodPressure;
    int skinThickness = state.skinThickness;
    int insulin = state.insulin;
    double bmi = state.bmi;
    int age = state.age;
    double diabetesPedigreeFunction = state.diabetesPedigreeFunction;

    if (pregnancies == 0 ||
        glucose == 0 ||
        bloodPressure == 0 ||
        skinThickness == 0 ||
        insulin == 0 ||
        bmi == 0.0 ||
        age == 0 ||
        diabetesPedigreeFunction == 0.0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('ກະລຸນາພິມຂໍ້ມູນທີ່ຕ້ອງການກວດສອບ'),
        ),
      );
      return;
    }
    try {
      Response response = await HttpUtil().post('/predict/one-predict', data: {
        "age": age,
        "pregnancies": pregnancies,
        "glucose": glucose,
        "bloodPressure": bloodPressure,
        "skinthickness": skinThickness,
        "insulin": insulin,
        "diabetespedigreefunction": diabetesPedigreeFunction,
        "bmi": bmi
      });

      if (response.statusCode == 200) {
        if (context.mounted) {
          // context.read<PredictBloc>().add(const ResetState());
          showDialog(
            useSafeArea: true,
            context: context,
            builder: (_) => AlertDialog(
              alignment: AlignmentDirectional.center,
              surfaceTintColor: Colors.white,
              title: const Text("ຄ່າກາານວິເຄາະ"),
              content: Text(response.data['result']),
            ),
          );
        }
      } else {
        // ignore: use_build_context_synchronously
        print(response.data);
      }
    } catch (e) {
      debugPrint('predictsModel: $e');
    }
  }
}
