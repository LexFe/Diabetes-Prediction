import 'package:flutter/material.dart';
import 'package:frontend/global.dart';
import 'package:frontend/routes/name.dart';

class HomePages extends StatelessWidget {
  const HomePages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        surfaceTintColor: Colors.blue,
        centerTitle: true,
        automaticallyImplyLeading: false,
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
                Navigator.pushNamed(context, AppRoutes.Predicts);
              }),
          buildItem(
              title: "ແນະນຳ",
              iconData: Icons.info,
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.Recomment);
              }),
          buildItem(
              title: "ຈັດການຂໍ້ມູນ",
              iconData: Icons.manage_accounts,
              onTap: () {
                if (Global.userService.getIsLoggedIn() == false) {
                  Navigator.pushNamed(context, AppRoutes.Login);
                  return;
                } else {
                  Navigator.pushNamed(context, AppRoutes.MainManages);
                }
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
