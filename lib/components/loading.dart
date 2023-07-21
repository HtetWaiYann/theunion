import 'package:flutter/material.dart';
import 'package:theunion/services/common.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      child: Center(child: spinkit),
    );
  }
}
