import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';

class ModeSelectionButtons extends StatelessWidget {
  final VoidCallback ifPressedClient;
  final VoidCallback ifPressedSeller;

  const ModeSelectionButtons({
    super.key,
    required this.ifPressedClient,
    required this.ifPressedSeller,
  });

  @override
  Widget build(BuildContext context) {
    var clientButtons = ElevatedButton(
        onPressed: ifPressedClient, child: Text(S.of(context).customer));
    var sellerButtons = ElevatedButton(
        onPressed: ifPressedSeller, child: Text(S.of(context).seller));
    var size = MediaQuery.of(context).size;

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return Column(
            children: [
              SizedBox(
                height: size.height * 0.07,
                width: 600,
                child: clientButtons,
              ),
              const SizedBox(height: 32),
              SizedBox(
                height: size.height * 0.07,
                width: 600,
                child: sellerButtons,
              ),
            ],
          );
        } else {
          return Column(
            children: [
              SizedBox(
                height: size.height * 0.07,
                width: size.width * 0.9,
                child: clientButtons,
              ),
              const SizedBox(height: 32),
              SizedBox(
                height: size.height * 0.07,
                width: size.width * 0.9,
                child: sellerButtons,
              ),
            ],
          );
        }
      },
    );
  }
}
