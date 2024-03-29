import 'package:flutter/material.dart';

import '../../../common/constants/app_palette.dart';
import '../../../common/widgets/back_arrow_widget.dart';
import '../../../common/widgets/input_field_widget.dart';
import '../../../generated/l10n.dart';

class ClientCardPage extends StatelessWidget {
  final TextEditingController cardNumberController;
  final TextEditingController cardNameController;
  final TextEditingController cardDateController;
  final TextEditingController cardRCVController;
  final VoidCallback saveCard;

  const ClientCardPage({
    Key? key,
    required this.cardNumberController,
    required this.cardNameController,
    required this.cardDateController,
    required this.cardRCVController,
    required this.saveCard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: BackArrowWidget(
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    width: constraints.maxWidth >= 600 ? 600 : size.width,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppPalette.borderColor),
                      borderRadius: BorderRadius.circular(10),
                      gradient: const LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.topLeft,
                        stops: [
                          0.3,
                          0.6,
                          0.9,
                        ],
                        colors: [
                          Colors.green,
                          Colors.greenAccent,
                          Colors.green,
                        ],
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InputFieldWidget(
                          hintText: S.of(context).num_card,
                          controller: cardNumberController,
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        SizedBox(
                          width: 200,
                          child: InputFieldWidget(
                            hintText: S.of(context).name,
                            controller: cardNameController,
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: 100,
                              child: InputFieldWidget(
                                hintText: S.of(context).date,
                                controller: cardDateController,
                                keyboardType: TextInputType.datetime,
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: 100,
                              child: InputFieldWidget(
                                hintText: S.of(context).rcv,
                                controller: cardRCVController,
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      saveCard();
                      Navigator.pop(context);
                    },
                    child: SizedBox(
                      width: constraints.maxWidth >= 800 ? size.width * 0.1 : 100,
                      child: Text(
                        S.of(context).save_card,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
