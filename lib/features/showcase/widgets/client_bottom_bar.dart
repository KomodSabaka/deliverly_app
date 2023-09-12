import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/utils/constants.dart';


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
        border: Border(top: BorderSide(color: borderColor)),
      ),
      child: Row(
        children: [
          SizedBox(
            height: 80,
            width: size.width / 3,
            child: InkWell(
              onTap: () => setIndex(0),
              child: SvgPicture.asset(
                AppImage.grid,
                fit: BoxFit.none,
                color: currentIndex == 0
                    ? selectedBottomIconColor
                    : secondaryTextColor,
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
                    AppImage.shoppingCart,
                    fit: BoxFit.none,
                    color: currentIndex == 1
                        ? selectedBottomIconColor
                        : secondaryTextColor,
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
                AppImage.user,
                fit: BoxFit.none,
                color: currentIndex == 2
                    ? selectedBottomIconColor
                    : secondaryTextColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
