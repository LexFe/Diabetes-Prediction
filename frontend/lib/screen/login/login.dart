import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/controller/login_controller.dart';
import 'package:frontend/screen/login/bloc/login_bloc.dart';
import 'package:frontend/screen/predict/bloc/predict_bloc.dart';

class LoginPages extends StatelessWidget {
  const LoginPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        // physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 100),
          const Center(
            child: Text(
              'Login',
              style: TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Center(
            child: Text(
              'ຍິນດີຕ້ອນຮັບການເຂົ້າສູ່ລະບົບ',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: buildPhoneTextFrom(
              obscureText: false,
              hintText: 'ຊື່ຜູ້ໃຊ້',
              labelText: 'ຊື່ຜູ້ໃຊ້',
              onChanged: (value) {
                context.read<LoginBloc>().add(LoginEmailChanged(value));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: buildPhoneTextFrom(
              obscureText: true,
              hintText: 'ລະຫັດຜ່ານ',
              labelText: 'ລະຫັດຜ່ານ',
              onChanged: (value) {
                context.read<LoginBloc>().add(LoginPasswordChanged(value));
              },
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              height: 60,
              width: 400,
              child: ElevatedButton(
                onPressed: () {
                  LoginController(context: context).handleLogin();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'ເຂົ້າສູ່ລະບົບ',
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
    required String hintText,
    required String labelText,
    required Function(String) onChanged,
    required bool obscureText,
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
            color: Colors.black54,
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
                obscureText: obscureText,
                keyboardType: TextInputType.text,
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
