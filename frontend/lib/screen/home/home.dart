import 'package:flutter/material.dart';
import 'package:frontend/controller/predicts_controller.dart';
import 'package:frontend/routes/name.dart';

class HomePages extends StatelessWidget {
  const HomePages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'ໜ້າຫຼັກ',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: GridView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
        children: [
          buildItem(
              title: "ວິເຄາະແບບດຽວ",
              iconData: Icons.person,
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.Predict);
              }),
          buildItem(
              title: "ວິເຄາະແບບຫຼາຍ",
              iconData: Icons.group,
              onTap: () {
                PredictsController(context: context).handleGetPredict();
              }),
          buildItem(
              title: "ແນະນຳ",
              iconData: Icons.info,
              onTap: () {
                Navigator.pushNamed(context, '/main-manages');
              }),
          buildItem(
              title: "ຈັດການຂໍ້ມູນ",
              iconData: Icons.manage_accounts,
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.MainManages );
              }),
        ],
      ),
    );
  }

  Widget buildItem({
    required String title,
    required IconData iconData,
    required Function() onTap,
  }) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 0,
                blurRadius: 3,
                offset: const Offset(0, 2), // changes position of shadow
              ),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconData,
                size: 50,
                color: Colors.blue,
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )),
    );
  }
}
