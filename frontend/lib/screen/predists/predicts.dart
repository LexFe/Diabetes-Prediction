import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/screen/predists/bloc/predicts_bloc.dart';

class PredictsPages extends StatelessWidget {
  const PredictsPages({super.key});

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
      body: BlocBuilder<PredictsBloc, PredictsState>(
        builder: (context, state) {
          return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: state.predictsModel.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(state.predictsModel[index].name ?? ''),
                    subtitle: Text(state.predictsModel[index].predict ?? ''),
                  ),
                );
              });
        },
      ),
    );
  }
}
