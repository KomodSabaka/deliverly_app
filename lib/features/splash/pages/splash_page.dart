import 'dart:async';
import 'package:deliverly_app/common/navigation/routes.dart';
import 'package:deliverly_app/common/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/constants/app_palette.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  Future initData(Timer timer) async {
    await checkInternetConnection().then(
      (hasInternetConnection) async {
        if (hasInternetConnection == true) {
          // await ref.read(appSettingsProvider.notifier).getCurrentExchangeRate();
          // print(ref.read(appSettingsProvider).currentExchangeRate);
          timer.cancel();
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.selectModePage,
            (route) => false,
          );
        }
      },
    );
  }

  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 2), (timer) async {
      if (mounted) {
        await initData(timer);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            stops: const [
              0.1,
              0.5,
              0.9,
            ],
            end: Alignment.bottomLeft,
            colors: [
              Colors.green[300]!,
              AppPalette.backgroundColorSelectModePage,
              Colors.green[200]!,
            ],
          ),
        ),
        child: Center(
            child: Text(
          'Deliverly\nApp',
          style: TextStyle(
            fontSize: size.width * 0.15,
            letterSpacing: 2.0,
          ),
          textAlign: TextAlign.center,
        )),
      ),
    );
  }
}
