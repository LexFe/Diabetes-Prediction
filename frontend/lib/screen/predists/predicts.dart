import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/common/enum/state_status.dart';
import 'package:frontend/controller/predicts_controller.dart';
import 'package:frontend/screen/predists/bloc/predicts_bloc.dart';

class PredictsPages extends StatefulWidget {
  const PredictsPages({super.key});

  @override
  State<PredictsPages> createState() => _PredictsPagesState();
}

class _PredictsPagesState extends State<PredictsPages> {
  @override
  void initState() {
    PredictsController(context: context).handleGetPredict();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue,
        surfaceTintColor: Colors.blue,
        centerTitle: true,
        foregroundColor: Colors.white,
        title: const Text(
          'ວິເຄາະແບບຫຼາຍ',
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        // physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: buildPhoneTextFrom(
                context: context,
                labelText: 'ຊື່',
                hintText: 'ຄົ້ນຫາ',
                onChanged: (value) {
                  context
                      .read<PredictsBloc>()
                      .add(SearchPredict(search: value));
                }),
          ),
          RefreshIndicator(
            color: Colors.blue,
            onRefresh: () =>
                PredictsController(context: context).handleGetPredict(),
            child: BlocBuilder<PredictsBloc, PredictsState>(
              builder: (context, state) {
                if (state.status == StateStatus.loading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  );
                }

                if (state.predictsModel.isEmpty) {
                  return const Center(
                    child: Text('ບໍ່ພົບຂໍ້ມູນ'),
                  );
                }

                return ListView.builder(
                    padding: const EdgeInsets.all(10),
                    // physics: const BouncingScrollPhysics(),
                    itemCount: state.predictsModel.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Card(
                          elevation: 2,
                          color: Colors.white,
                          child: ListTile(
                            leading: const Icon(
                              Icons.account_circle_rounded,
                              color: Colors.blue,
                              size: 40,
                            ),
                            title: Text(state.predictsModel[index].name ?? ''),
                            subtitle:
                                Text(state.predictsModel[index].predict ?? ''),
                            trailing: const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.black26,
                              size: 20,
                            ),
                          ),
                        ),
                      );
                    });
              },
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
    return SizedBox(
      height: 60,
      child: BlocBuilder<PredictsBloc, PredictsState>(
        builder: (context, state) {
          return TextFormField(
            keyboardType: TextInputType.text,
            maxLines: 1,
            cursorColor: Colors.grey,
            onChanged: onChanged,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
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
    );
  }
}
