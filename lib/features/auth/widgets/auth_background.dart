import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/utils/constants.dart';


class AuthBackground extends StatefulWidget {
  final Widget child;

  const AuthBackground({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<AuthBackground> createState() => _AuthBackgroundState();
}

class _AuthBackgroundState extends State<AuthBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _moveUp;
  late Animation<double> _opacity;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _moveUp = Tween(begin: 200.0, end: 0.0).animate(_controller);
    _opacity = Tween(begin: 0.0, end: 1.0).animate(_controller);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward();
    return Scaffold(
      backgroundColor: backgroundColorSelectModePage,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SvgPicture.asset(
            'assets/BG.svg',
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0.0, _moveUp.value),
                child: Opacity(
                  opacity: _opacity.value,
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: backdropColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: widget.child,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
