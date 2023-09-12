import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/constants.dart';

class InputFieldWidget extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final int? maxLength;
  final int? maxLine;
  final Function(String)? onChanged;
  final Widget? suffix;
  final bool readOnly;

  const InputFieldWidget({
    Key? key,
    this.hintText = '',
    this.controller,
    this.keyboardType = TextInputType.text,
    this.maxLength,
    this.maxLine = 1,
    this.onChanged,
    this.suffix,
    this.readOnly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: Theme.of(context).textTheme.bodyLarge,
      cursorColor: secondaryTextColor,
      controller: controller,
      keyboardType: keyboardType,
      maxLength: maxLength,
      maxLines: maxLine,
      readOnly: readOnly,
      onChanged: onChanged,
      inputFormatters: [
        FilteringTextInputFormatter.singleLineFormatter,
      ],
      decoration: InputDecoration(
        focusColor: borderColor,
        fillColor: borderColor,
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.bodyLarge,
        counterText: '',
        suffix: suffix,
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
