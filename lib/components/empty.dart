import 'package:flutter/material.dart';
import 'package:theunion/resources/colors.dart';
import 'package:theunion/resources/dimens.dart';

class Empty extends StatelessWidget {
  const Empty({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/empty.png", color: EMPTY_COLOR, height: size.width * 0.2,),
          Text('No data found.', style: TextStyle(color: EMPTY_COLOR, fontSize: TEXT_REGULAR),)
        ],
      )),
    );
  }
}
