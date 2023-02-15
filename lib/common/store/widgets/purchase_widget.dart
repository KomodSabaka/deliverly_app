import 'dart:ui';

import 'package:deliverly_app/models/purchase_model.dart';
import 'package:deliverly_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PurchaseWidget extends StatelessWidget {
  final PurchaseModel purchase;

  const PurchaseWidget({
    Key? key,
    required this.purchase,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      width: double.infinity,
      decoration: BoxDecoration(
        color: borderColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              purchase.productList.length >= 2
                  ? Positioned(
                      left: 25,
                      child: Container(
                        height: 50,
                        width: 60,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(purchase.productList[1].photo),
                            fit: BoxFit.cover,
                          ),
                        ),
                        alignment: Alignment.centerRight,
                        child: ClipRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 4),
                            child: Container(
                              alignment: Alignment.centerRight,
                              child:
                                  Text('+${purchase.productList.length - 1}'),
                            ),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
              Container(
                height: 50,
                width: 60,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(purchase.productList.first.photo),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 32.0),
            child: RichText(
              text: TextSpan(
                text: DateFormat.Hm().format(purchase.date),
                children: [
                  TextSpan(
                    text: ' ${DateFormat.d().format(purchase.date)}-',
                  ),
                  TextSpan(
                    text: '${DateFormat.m().format(purchase.date)}-',
                  ),
                  TextSpan(
                    text: DateFormat.y().format(purchase.date),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
