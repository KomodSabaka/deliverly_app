import 'package:flutter/material.dart';

import '../colors.dart';

class InputFieldWidget extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool isPhoneField;
  final bool isDescription;

  const InputFieldWidget({
    Key? key,
    required this.hintText,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.isPhoneField = false,
    this.isDescription = false,
  }) : super(key: key);

  void phoneValid(String value) {
    if (value.endsWith(' ') || value.endsWith('-') || value.endsWith('+')) {
      controller.text = value.substring(0, value.length - 1);
      controller.selection =
          TextSelection.collapsed(offset: controller.text.length);
    } else if (value.length == 1) {
      controller.text = '+$value ';
      controller.selection =
          TextSelection.collapsed(offset: controller.text.length);
    } else if (value.length == 6) {
      controller.text = '$value ';
      controller.selection =
          TextSelection.collapsed(offset: controller.text.length);
    } else if (value.length == 10 || value.length == 13) {
      controller.text = '$value-';
      controller.selection =
          TextSelection.collapsed(offset: controller.text.length);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: Theme.of(context).textTheme.bodyLarge,
      cursorColor: secondaryTextColor,
      controller: controller,
      keyboardType: keyboardType,
      maxLength: isPhoneField ? 16 : null,
      maxLines: isDescription ? null : 1,
      onChanged: (value) {
        if (isPhoneField) phoneValid(value);
      },
      decoration: InputDecoration(
        focusColor: borderColor,
        fillColor: borderColor,
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.bodyLarge,
        counterText: '',
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(27),
            borderSide: const BorderSide(
              color: borderColor,
            )),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(27),
            borderSide: const BorderSide(
              color: borderColor,
            )),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(27),
            borderSide: const BorderSide(
              color: borderColor,
            )),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(27),
            borderSide: const BorderSide(
              color: borderColor,
            )),
      ),
    );
  }
}
