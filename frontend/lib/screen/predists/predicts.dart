import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/common/enum/state_status.dart';
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
          if (state.status == StateStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          }
          return ListView.builder(
              padding: const EdgeInsets.all(10),
              physics: const BouncingScrollPhysics(),
              itemCount: state.predictsModel.length,
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
                      subtitle: Text(state.predictsModel[index].predict ?? ''),
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
    );
  }
}
