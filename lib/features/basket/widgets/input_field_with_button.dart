import 'package:flutter/material.dart';
import '../../../common/widgets/input_field_widget.dart';

class InputFieldWithButton extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onPressed;
  final String buttonText;

  const InputFieldWithButton({
    super.key,
    required this.controller,
    required this.onPressed,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: InputFieldWidget(
            controller: controller,
            readOnly: true,
            maxLine: 2,
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.35,
          alignment: Alignment.center,
          child: TextButton(
            onPressed: onPressed,
            child: Text(buttonText),
          ),
        ),
      ],
    );
  }
}
