import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BackArrowWidget extends StatelessWidget {
  const BackArrowWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: SvgPicture.asset('assets/icons/arrow_back.svg'),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
