import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:theunion/resources/colors.dart';
import 'package:theunion/resources/dimens.dart';

class CustomDropdown extends StatelessWidget {
  final String label;
  final String selectedValue;
  final List<String> itemsList;
  final Function(dynamic) onChange;
  final bool disable;
  final SingleValueDropDownController controller;
  final String? Function(String?) validator;

  CustomDropdown(
      {Key? key,
      required this.label,
      required this.selectedValue,
      required this.itemsList,
      required this.onChange,
      this.disable = false,
      required this.controller,
      required this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide: const BorderSide(color: INPUT_COLOR),
    );
    return AbsorbPointer(
      absorbing: disable,
      
      child: DropDownTextField(
        dropdownRadius: 5.0,
        textStyle: const TextStyle(color: PRIMARY_COLOR, fontSize: TEXT_REGULAR),
        listTextStyle: const TextStyle(fontSize: TEXT_REGULAR),  
        textFieldDecoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: const EdgeInsets.all(MARGIN_MEDIUM_4),
          labelText: label,
          hintStyle: const TextStyle(color: Colors.grey),
          focusedBorder: border,
          enabledBorder: border,
          border: border,
          disabledBorder: border,
          labelStyle: const TextStyle(color: INPUT_COLOR),
          floatingLabelStyle: const TextStyle(color: INPUT_COLOR),
          focusColor: INPUT_COLOR,
        ),
        controller: controller,
        clearOption: false,
        dropdownColor: PRIMARY_COLOR, 
        validator: validator,
        dropDownItemCount: itemsList.length,
        dropDownList: itemsList.map((String item) {
          return DropDownValueModel(name: item, value: item);
        }).toList(),
        onChanged: onChange,
      ),
    );

    // AbsorbPointer(
    //   absorbing: disable,
    //   child: DropdownButtonHideUnderline(
    //     child: DropdownButtonFormField(
    //       style: const TextStyle(color: INPUT_COLOR),
    //       dropdowncolor: PRIMARY_COLOR, fontSize: TEXT_REGULAR,
    //       decoration: InputDecoration(
    //         fillColor: Colors.red,
    //         contentPadding: const EdgeInsets.all(MARGIN_MEDIUM_4),
    //         labelText: label,
    //         hintStyle: const TextStyle(color: Colors.grey),
    //         focusedBorder: border,
    //         enabledBorder: border,
    //         border: border,
    //         disabledBorder: border,
    //         labelStyle: const TextStyle(color: INPUT_COLOR),
    //         floatingLabelStyle: const TextStyle(color: INPUT_COLOR),
    //         focusColor: INPUT_COLOR,
    //       ),
    //       value: selectedValue,
    //       items: itemsList.map((String items) {
    //         return DropdownMenuItem(
    //           value: items,
    //           child: Text(
    //             items,
    //             style: const TextStyle(
    //               color: Colors.black, // Customize the text color.
    //             ),
    //           ),
    //         );
    //       }).toList(),
    //       onChanged: (value) {
    //         onChange;
    //       },
    //       validator: validator,
    //     ),
    //   ),
    // );
  }
}
