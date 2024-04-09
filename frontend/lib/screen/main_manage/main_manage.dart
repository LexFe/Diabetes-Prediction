import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend/controller/admin_controller.dart';

class MainManagePages extends StatelessWidget {
  const MainManagePages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'ຈັດການຂໍ້ມູນ',
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
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
              title: "ຈັດການຂໍ້ມູນຜູ້ໃຊ້",
              iconData: Icons.supervised_user_circle,
              onTap: () {
               
              }),
          buildItem(
              title: "ຈັດການຂໍ້ມູນແອັດມິນ",
              iconData: Icons.admin_panel_settings,
              onTap: () {
                AdminController(context: context).handleGetAdmin();
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
