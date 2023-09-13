import 'dart:ui';

import 'package:deliverly_app/models/purchase_order.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../common/constants/app_palette.dart';

class PurchaseWidget extends StatelessWidget {
  final PurchaseOrder purchase;

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
        color: AppPalette.borderColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              purchase.products.length >= 2
                  ? Positioned(
                      left: 25,
                      child: Container(
                        height: 50,
                        width: 60,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(purchase.products.first.image),
                            fit: BoxFit.cover,
                          ),
                        ),
                        alignment: Alignment.centerRight,
                        child: ClipRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 4),
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: Text('+${purchase.products.length - 1}'),
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
                    image: NetworkImage(purchase.products.first.image),
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
                text: purchase.deliveryTime,
                children: [
                  TextSpan(
                    text: ' ${DateFormat.d().format(purchase.deliveryDate)}-',
                  ),
                  TextSpan(
                    text: '${DateFormat.m().format(purchase.deliveryDate)}-',
                  ),
                  TextSpan(
                    text: DateFormat.y().format(purchase.deliveryDate),
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
