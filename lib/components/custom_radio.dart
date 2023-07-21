import 'package:flutter/material.dart';
import 'package:theunion/resources/colors.dart';

class CustomRadioButton extends StatelessWidget {
  final String label;
  final String value;
  final String groupValue;
  final Function(String) onChange;
  const CustomRadioButton(
      {super.key,
      required this.label,
      required this.value,
      required this.groupValue,
      required this.onChange});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio(
            fillColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return Colors.white.withOpacity(.32);
              }
              return PRIMARY_COLOR;
            }),
            value: label,
            groupValue: groupValue,
            onChanged: (value) => onChange),
        Text(label)
      ],
    );
  }
}
