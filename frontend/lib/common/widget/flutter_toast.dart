import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/theme/app_color.dart';



toasrInfo({
  required String message,
  Color textColor = Colors.white,
}) {
  return Fluttertoast.showToast(
    //set font family
    // fontFamily: 'NotoSansLao',

    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: AppColor.secondaryColor,
    textColor: textColor,
    fontSize: 16.0.sp,
  );
}



