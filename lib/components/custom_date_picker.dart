import 'package:flutter/material.dart';
import 'package:theunion/resources/colors.dart';
import 'package:intl/intl.dart';
import 'package:theunion/resources/dimens.dart';

class CustomDatePicker extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final bool disable;
  final String? Function(String?)? validator;
  final bool next;
  final Function(String) onChange;

  const CustomDatePicker(
      {super.key,
      required this.label,
      required this.controller,
      this.disable = false,
      this.next = true,
      required this.validator,
      required this.onChange});

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide: const BorderSide(color: INPUT_COLOR),
    );

    return GestureDetector(
      onTap: () async {
        debugPrint("=====> ${widget.disable}");
        if (widget.disable) {
          // View Form
        } else {
          var birthDate;
          final datePick = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime(2100));
          if (datePick != null && datePick != birthDate) {
            setState(() {
              birthDate = datePick;
              String formattedDate = DateFormat('MMMM dd, yyyy').format(birthDate);
              widget.controller.text = formattedDate;
              widget.onChange(formattedDate);
            });
          }
        }
      },
      child: AbsorbPointer(
        absorbing: true,
        child: TextFormField(
          controller: widget.controller,
          cursorColor: INPUT_COLOR,
          style: TextStyle(color: INPUT_COLOR, fontSize: TEXT_REGULAR),
          textInputAction: widget.next ? TextInputAction.next : TextInputAction.done,
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding: EdgeInsets.all(MARGIN_MEDIUM_4),
            labelText: widget.label,
            focusedBorder: border,
            enabledBorder: border,
            border: border,
            disabledBorder: border,
            labelStyle:
               const TextStyle(color: INPUT_COLOR),
            floatingLabelStyle: const TextStyle(color: INPUT_COLOR),
            suffixIcon: GestureDetector(
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                child: const Icon(
                  Icons.date_range_outlined,
                  color: PRIMARY_COLOR,
                ),
              ),
            ),
          ),
          validator: widget.validator,
        ),
      ),
    );
  }
}
