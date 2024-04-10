import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/controller/predict_controller.dart';
import 'package:frontend/screen/predict/bloc/predict_bloc.dart';

class PredictPages extends StatelessWidget {
  const PredictPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        surfaceTintColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'ວິເຄາະແບບດຽວ',
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(
            height: 10,
          ),
          GridView.count(
            padding: const EdgeInsets.all(15),
            physics: const BouncingScrollPhysics(),
            mainAxisSpacing: 15,
            shrinkWrap: true,
            crossAxisSpacing: 15,
            crossAxisCount: 2,
            childAspectRatio: 1.8,
            children: [
              buildPhoneTextFrom(
                  context: context,
                  labelText: 'ຈຳນວນຖືພາ',
                  hintText: 'ຈຳນວນຖືພາ',
                  onChanged: (value) {
                    context.read<PredictBloc>().add(
                        Pregnancies(pregnancies: int.tryParse(value) ?? 0));
                  }),
              buildPhoneTextFrom(
                context: context,
                labelText: 'ຄ່ານ້ຳຕານ',
                hintText: 'ຄ່ານ້ຳຕານ',
                onChanged: (value) {
                  context
                      .read<PredictBloc>()
                      .add(Glucose(glucose: int.tryParse(value) ?? 0));
                },
              ),
              buildPhoneTextFrom(
                context: context,
                labelText: 'ຄວາມ​ດັນ​ເລືອດ',
                hintText: 'ຄວາມ​ດັນ​ເລືອດ',
                onChanged: (value) {
                  context.read<PredictBloc>().add(
                      BloodPressure(bloodPressure: int.tryParse(value) ?? 0));
                },
              ),
              buildPhoneTextFrom(
                context: context,
                labelText: 'ຄວາມໜາຂອງຜິວໜັງ',
                hintText: 'ຄວາມໜາຂອງຜິວໜັງ',
                onChanged: (value) {
                  context.read<PredictBloc>().add(
                      SkinThickness(skinThickness: int.tryParse(value) ?? 0));
                },
              ),
              buildPhoneTextFrom(
                context: context,
                labelText: 'ຄ່າອີນຊູລິນ',
                hintText: 'ຄ່າອີນຊູລິນ',
                onChanged: (value) {
                  context
                      .read<PredictBloc>()
                      .add(Insulin(insulin: int.tryParse(value) ?? 0));
                },
              ),
              buildPhoneTextFrom(
                context: context,
                labelText: 'ຄວາມສ່ຽງຈາກກຳມະພັນ',
                hintText: 'ຄວາມສ່ຽງຈາກກຳມະພັນ',
                onChanged: (value) {
                  context.read<PredictBloc>().add(DiabetesPedigreeFunction(
                      diabetesPedigreeFunction: double.tryParse(value) ?? 0.0));
                },
              ),
              buildPhoneTextFrom(
                context: context,
                labelText: 'bmi',
                hintText: 'bmi',
                onChanged: (value) {
                  context
                      .read<PredictBloc>()
                      .add(Bmi(bmi: double.tryParse(value) ?? 0.0));
                },
              ),
              buildPhoneTextFrom(
                context: context,
                labelText: 'ອາຍຸ',
                hintText: 'ອາຍຸ',
                onChanged: (value) {
                  context
                      .read<PredictBloc>()
                      .add(Age(age: int.tryParse(value) ?? 0));
                },
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: SizedBox(
              height: 60,
              width: 400,
              child: ElevatedButton(
                onPressed: () {
                  PredictController(context: context).handlePredict();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'ວິເຄາະດຽວນີ້',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPhoneTextFrom({
    required BuildContext context,
    required String hintText,
    required String labelText,
    required Function(String) onChanged,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 60,
          child: BlocBuilder<PredictBloc, PredictState>(
            builder: (context, state) {
              return TextFormField(
                // controller: TextEditingController.fromValue(
                //   TextEditingValue(
                //     text: state.age.toString(),
                //     selection: TextSelection.collapsed(
                //       offset: state.age.toString().isEmpty
                //           ? 0
                //           : state.age.toString().length,
                //     ),
                //   ),
                // ),
                inputFormatters: <TextInputFormatter>[
                  LengthLimitingTextInputFormatter(10),
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                ],
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                maxLines: 1,
                cursorColor: Colors.grey,
                onChanged: onChanged,
                decoration: InputDecoration(
                  prefixIconColor: MaterialStateColor.resolveWith(
                    (states) => states.contains(MaterialState.focused)
                        ? Colors.blue
                        : Colors.grey,
                  ),
                  hintText: hintText,
                  hintStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

 
}
