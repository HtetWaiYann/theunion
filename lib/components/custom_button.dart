import 'package:flutter/material.dart';
import 'package:theunion/resources/colors.dart';
import 'package:theunion/resources/dimens.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback press;
  final Color color, textColor;
  final bool loading;
  const CustomButton({
    Key? key,
    required this.text,
    required this.press,
    this.color = PRIMARY_BUTTON_COLOR,
    this.textColor = PRIMARY_TEXT_COLOR,
    this.loading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: MARGIN_MEDIUM),
      child: newElevatedButton(),
    );
  }

  Widget newElevatedButton() {
    return ElevatedButton(
      onPressed: press,
      
      style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: EdgeInsets.symmetric(vertical: MARGIN_MEDIUM_3),
          textStyle: TextStyle(color: textColor),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(color: textColor),
          ),
          loading
              ? Container(
                  width: 15,
                  height: 15,
                  // padding: EdgeInsets.only(right: 20),
                  margin: const EdgeInsets.only(left: 10),
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    valueColor: AlwaysStoppedAnimation<Color>(textColor),
                  ))
              : Container(),
        ],
      ),
    );
  }
}
