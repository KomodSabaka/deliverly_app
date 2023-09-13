import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/constants/app_images.dart';
import '../../../common/constants/app_palette.dart';


class ClientBottomBar extends StatelessWidget {
  final int currentIndex;
  final int basketLength;
  final Function(int index) setIndex;

  const ClientBottomBar({
    Key? key,
    required this.currentIndex,
    required this.basketLength,
    required this.setIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: 80,
      alignment: Alignment.center,
      width: double.infinity,
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppPalette.borderColor)),
      ),
      child: Row(
        children: [
          SizedBox(
            height: 80,
            width: size.width / 3,
            child: InkWell(
              onTap: () => setIndex(0),
              child: SvgPicture.asset(
                AppImages.grid,
                fit: BoxFit.none,
                color: currentIndex == 0
                    ? AppPalette.selectedBottomIconColor
                    : AppPalette.secondaryTextColor,
              ),
            ),
          ),
          InkWell(
            onTap: () => setIndex(1),
            child: Container(
              height: 80,
              width: size.width / 3,
              alignment: Alignment.center,
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  SvgPicture.asset(
                    AppImages.shoppingCart,
                    fit: BoxFit.none,
                    color: currentIndex == 1
                        ? AppPalette.selectedBottomIconColor
                        : AppPalette.secondaryTextColor,
                  ),
                  basketLength != 0
                      ? Container(
                        alignment: Alignment.center,
                        height: 14,
                        width: 14,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                        ),
                        child: Text(
                          basketLength.toString(),
                          style: const TextStyle(fontSize: 12),
                        ),
                      )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 80,
            width: size.width / 3,
            child: InkWell(
              onTap: () => setIndex(2),
              child: SvgPicture.asset(
                AppImages.user,
                fit: BoxFit.none,
                color: currentIndex == 2
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
