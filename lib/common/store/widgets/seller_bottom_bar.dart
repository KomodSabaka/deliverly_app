import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/colors.dart';

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
    return Container(
      height: 80,
      width: double.infinity,
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: borderColor)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: 80,
            width: MediaQuery.of(context).size.width / 2,
            child: InkWell(
              onTap: () {
                widget.setIndex(0);
              },
              child: SvgPicture.asset(
                'assets/icons/grid.svg',
                fit: BoxFit.none,
                color: widget.currentIndex == 0
                    ? selectedBottomIconColor
                    : secondaryTextColor,
              ),
            ),
          ),
          SizedBox(
            height: 80,
            width: MediaQuery.of(context).size.width / 2,
            child: InkWell(
              onTap: () {
                widget.setIndex(1);
              },
              child: SvgPicture.asset(
                'assets/icons/user.svg',
                fit: BoxFit.none,
                color: widget.currentIndex == 1
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
