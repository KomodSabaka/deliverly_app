import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deliverly_app/common/app_settings/app_settings.dart';
import 'package:deliverly_app/common/enums/mode_enum.dart';
import 'package:deliverly_app/features/auth/controller/auth_controller.dart';
import 'package:deliverly_app/models/address.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../../common/constants/firebase_fields.dart';
import '../../../models/purchase_order.dart';
import '../pages/map_page.dart';
import '../states/basket_state.dart';

final checkoutRepositoryProvider = Provider(
  (ref) => CheckoutRepository(
    ref: ref,
    firebaseAuth: FirebaseAuth.instance,
    firebaseFirestore: FirebaseFirestore.instance,
  ),
);

class CheckoutRepository {
  final ProviderRef ref;
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  CheckoutRepository({
    required this.ref,
    required this.firebaseAuth,
    required this.firebaseFirestore,
  });

  void selectAddress({
    required BuildContext context,
    required TextEditingController addressController,
  }) async {
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MapPage(
                  addressController: addressController,
                )));
  }

  void buyProducts({
    required DateTime deliveryDate,
    required String deliveryTime,
    required Address address,
  }) async {
    String buyId = const Uuid().v1();

    PurchaseOrder purchaseOrder = PurchaseOrder(
      id: buyId,
      clientId: firebaseAuth.currentUser!.uid,
      clearanceTime: DateTime.now(),
      deliveryDate: deliveryDate,
      deliveryTime: deliveryTime,
      address: address,
      products: ref.watch(basketProvider),
    );

    await firebaseFirestore
        .collection(FirebaseFields.client)
        .doc(firebaseAuth.currentUser!.uid)
        .update({'address': address.toMap()});

    var user =
        await ref.read(authController).getUserData(mode: ModeEnum.client);

    ref.read(appSettingsProvider.notifier).setUser(user: user);

    await firebaseFirestore
        .collection(FirebaseFields.client)
        .doc(firebaseAuth.currentUser!.uid)
        .collection(FirebaseFields.buyList)
        .doc(buyId)
        .set(purchaseOrder.toMap());

    ref.read(basketProvider.notifier).deleteAllProducts();
//       NotificationService().createNotification(
//         id: 10,
//         title: S.of(context).thank_purchase,
//         body: S.of(context).thank_purchase,
//  dateAndTime: dateAndTime,
//     );
  }
}
