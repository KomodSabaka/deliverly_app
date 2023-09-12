import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';

import '../pages/map_page.dart';

final checkoutRepositoryProvider = Provider(
  (ref) => CheckoutRepository(),
);

class CheckoutRepository {


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

  void buyProducts({required }) {
  //
  // ref.read(basketProvider.notifier).buyProducts(context: context);
  // showSnakeBar(context, S.of(context).thank_purchase);

}


}
