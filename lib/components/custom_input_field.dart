import 'package:flutter/material.dart';
import 'package:theunion/resources/colors.dart';
import 'package:theunion/resources/dimens.dart';

class CustomInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  final bool disable;
  final bool iconDisalbe;
  final String? Function(String?)? validator;
  final bool isNumber;
  final bool isTextarea;
  final bool floatLabel;
  final bool next;

  const CustomInputField(
      {Key? key,
      required this.hintText,
      this.icon = Icons.person,
      required this.onChanged,
      required this.controller,
      this.disable = false,
      this.iconDisalbe = false,
      this.validator,
      this.isNumber = false,
      this.isTextarea = false,
      this.floatLabel = true,
      this.next = true
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide: const BorderSide(color: INPUT_COLOR),
    );
    return AbsorbPointer(
      absorbing: disable,
      // child: TextFieldContainer(
      child: Container(
        child: TextFormField(
          maxLines: isTextarea ? 3 : 1,
          controller: controller,
          onChanged: onChanged,
          keyboardType: isNumber ? TextInputType.number : TextInputType.text,
          cursorColor: INPUT_COLOR,
          style: TextStyle(color: INPUT_COLOR, fontSize: TEXT_REGULAR),
          textInputAction: next ? TextInputAction.next : TextInputAction.done,
          decoration: InputDecoration(
            
              floatingLabelBehavior: floatLabel
                  ? FloatingLabelBehavior.always
                  : FloatingLabelBehavior.auto,
              contentPadding: EdgeInsets.all(MARGIN_MEDIUM_4),
              labelText: hintText,
              focusedBorder: border,
              enabledBorder: border,
              border: border,
              disabledBorder: border,
              labelStyle:
                 TextStyle(color: INPUT_COLOR),
              floatingLabelStyle: TextStyle(color: INPUT_COLOR)),
          validator: validator,
        ),
      ),
      // ),
    );
  }
}
