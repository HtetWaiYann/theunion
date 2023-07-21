import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:theunion/resources/colors.dart';
import 'package:theunion/resources/dimens.dart';

showToast(msg, Color? color, webColor) {
  return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 2,
      webShowClose: false,
      backgroundColor: color ?? SUCCESS_COLOR,
      webPosition: "center",
      webBgColor: webColor ?? WEB_SUCCESS_COLOR,
      textColor: Colors.white,
      fontSize: TEXT_REGULAR_2X);
}

final spinkit = SpinKitFadingCircle(
  color: PRIMARY_COLOR,
  size: 25.0,
);
