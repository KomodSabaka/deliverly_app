import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/constants/app_images.dart';
import '../../../common/constants/app_palette.dart';
import '../../../generated/l10n.dart';

class SearchInputWidget extends StatelessWidget {
  final TextEditingController controller;

  const SearchInputWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textField = TextField(
      controller: controller,
      style: Theme.of(context).textTheme.bodyLarge,
      cursorColor: AppPalette.secondaryTextColor,
      decoration: InputDecoration(
        focusColor: AppPalette.borderColor,
        fillColor: AppPalette.borderColor,
        hintText: S.of(context).search,
        hintStyle: Theme.of(context).textTheme.bodyLarge,
        prefixIcon: Padding(
          padding:
          const EdgeInsets.only(top: 12.0, bottom: 12, left: 22, right: 16),
          child: SvgPicture.asset(AppImages.search),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(27),
            borderSide: const BorderSide(
              color: AppPalette.borderColor,
            )),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(27),
            borderSide: const BorderSide(
              color: AppPalette.borderColor,
            )),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(27),
            borderSide: const BorderSide(
              color: AppPalette.borderColor,
            )),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(27),
            borderSide: const BorderSide(
              color: AppPalette.borderColor,
            )),
      ),
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return SizedBox(
            width: 600,
            child: textField,
          );
        } else {
          return textField;
        }
      }
    );
  }
}
