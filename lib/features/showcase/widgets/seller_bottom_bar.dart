import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/constants/app_images.dart';
import '../../../common/constants/app_palette.dart';

class SellerBottomBar extends StatefulWidget {
  final int currentIndex;
  final Function(int index) setIndex;

  const SellerBottomBar({
    Key? key,
    required this.currentIndex,
    required this.setIndex,
  }) : super(key: key);

  @override
  State<SellerBottomBar> createState() => _SellerBottomBarState();
}

class _SellerBottomBarState extends State<SellerBottomBar> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: 80,
      width: double.infinity,
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: AppPalette.borderColor),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: 80,
            width: size.width / 2,
            child: InkWell(
              onTap: () {
                widget.setIndex(0);
              },
              child: SvgPicture.asset(
                AppImages.grid,
                fit: BoxFit.none,
                color: widget.currentIndex == 0
                    ? AppPalette.selectedBottomIconColor
                    : AppPalette.secondaryTextColor,
              ),
            ),
          ),
          SizedBox(
            height: 80,
            width: size.width / 2,
            child: InkWell(
              onTap: () {
                widget.setIndex(1);
              },
              child: SvgPicture.asset(
                AppImages.user,
                fit: BoxFit.none,
                color: widget.currentIndex == 1
                    ? AppPalette.selectedBottomIconColor
                    : AppPalette.secondaryTextColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
