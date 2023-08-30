import 'package:deliverly_app/common/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/constants.dart';

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

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: Theme.of(context).textTheme.bodyLarge,
      cursorColor: secondaryTextColor,
      controller: controller,
      keyboardType: keyboardType,
      maxLength: isPhoneField ? 16 : null,
      maxLines: isDescription ? null : 1,
      onChanged: (value) {
        if (isPhoneField) {
          phoneNumberFormat(value: value, controller: controller);
        }
      },
      inputFormatters: [
        FilteringTextInputFormatter.singleLineFormatter,
      ],
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
