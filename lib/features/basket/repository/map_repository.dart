import 'package:deliverly_app/models/map_repository_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

final mapRepositoryProvider =
    StateNotifierProvider<MapRepositoryNotifier, MapRepositoryState>(
        (ref) => MapRepositoryNotifier());

class MapRepositoryNotifier extends StateNotifier<MapRepositoryState> {
  MapRepositoryNotifier()
      : super(const MapRepositoryState(
          latLng: null,
          markers: [],
          address: '',
        ));

  Future setMarker({required LatLng latLng}) async {
    try {
      await addressFromCoordinates(latLng: latLng).whenComplete(
        () {
          state = state.copyWith(
            markers: [
              Marker(
                width: 150,
                height: 100,
                point: latLng,
                rotate: true,
                anchorPos: AnchorPos.align(AnchorAlign.top),
                builder: (context) {
                  return Container(
                    padding: const EdgeInsets.all(12),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.orange[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      state.address,
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.start,
                    ),
                  );
                },
              ),
            ],
          );
        },
      );
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<void> addressFromCoordinates({required LatLng latLng}) async {
    var response = await placemarkFromCoordinates(
      latLng.latitude,
      latLng.longitude,
    );
    var street = response
        .map((e) => e.street)
        .toString()
        .split(',')[0]
        .replaceAll('(', '');
    var number = response
        .map((e) => e.name)
        .toString()
        .split(',')[0]
        .replaceAll('(', '');

    var address = '$street $number';

    state = state.copyWith(address: address, latLng: latLng);
  }

  Future getCurrentLocation() async {
    try {
      if (state.latLng == null) {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );

        state = state.copyWith(
            latLng: LatLng(position.latitude, position.longitude));
        setMarker(latLng: LatLng(position.latitude, position.longitude));
      } else {
        setMarker(
            latLng: LatLng(state.latLng!.latitude, state.latLng!.longitude));
      }
    } catch (e) {
      print(e);
    }
  }
}
