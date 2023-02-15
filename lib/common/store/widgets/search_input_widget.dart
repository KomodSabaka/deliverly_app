import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../generated/l10n.dart';
import '../../../utils/colors.dart';

class SearchInputWidget extends StatelessWidget {
  final TextEditingController controller;

  const SearchInputWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: Theme.of(context).textTheme.bodyLarge,
      cursorColor: secondaryTextColor,
      decoration: InputDecoration(
        focusColor: borderColor,
        fillColor: borderColor,
        hintText: S.of(context).search,
        hintStyle: Theme.of(context).textTheme.bodyLarge,
        prefixIcon: Padding(
          padding:
              const EdgeInsets.only(top: 12.0, bottom: 12, left: 22, right: 16),
          child: SvgPicture.asset('assets/icons/search.svg'),
        ),
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
