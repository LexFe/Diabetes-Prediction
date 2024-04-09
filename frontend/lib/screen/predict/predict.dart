import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PredictPages extends StatelessWidget {
  const PredictPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
    );
  }
}
