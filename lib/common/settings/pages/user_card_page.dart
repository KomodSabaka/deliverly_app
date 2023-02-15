import 'package:deliverly_app/utils/widgets/input_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../generated/l10n.dart';
import '../../../utils/colors.dart';

class UserCardPage extends StatelessWidget {
  final TextEditingController cardNumberController;
  final TextEditingController cardNameController;
  final TextEditingController cardDateController;
  final TextEditingController cardRCVController;
  final VoidCallback saveCard;

  const UserCardPage({
    Key? key,
    required this.cardNumberController,
    required this.cardNameController,
    required this.cardDateController,
    required this.cardRCVController,
    required this.saveCard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset('assets/icons/arrow_back.svg'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                border: Border.all(color: borderColor),
                borderRadius: BorderRadius.circular(10),
                gradient:const LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.topLeft,
                  stops: [
                    0.3,
                    0.6,
                    0.9,],
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
              child:  SizedBox(
                width: 100,
                child: Text(
                  S.of(context).save_card,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
