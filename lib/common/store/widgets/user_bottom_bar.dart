import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/colors.dart';

class UserBottomBar extends StatelessWidget {
  final int currentIndex;
  final int basketLength;
  final Function(int index) setIndex;

  const UserBottomBar({
    Key? key,
    required this.currentIndex,
    required this.basketLength,
    required this.setIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            width: MediaQuery.of(context).size.width / 3,
            child: InkWell(
              onTap: () => setIndex(0),
              child: SvgPicture.asset(
                'assets/icons/grid.svg',
                fit: BoxFit.none,
                color: currentIndex == 0
                    ? selectedBottomIconColor
                    : secondaryTextColor,
              ),
            ),
          ),
          SizedBox(
            height: 80,
            width: MediaQuery.of(context).size.width / 3,
            child: InkWell(
              onTap: () => setIndex(1),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/icons/shopping-cart.svg',
                    fit: BoxFit.none,
                    color: currentIndex == 1
                        ? selectedBottomIconColor
                        : secondaryTextColor,
                  ),
                  basketLength != 0
                      ? Positioned(
                          top: 42,
                          left: 70,
                          child: Container(
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
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 80,
            width: MediaQuery.of(context).size.width / 3,
            child: InkWell(
              onTap: () => setIndex(2),
              child: SvgPicture.asset(
                'assets/icons/user.svg',
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
