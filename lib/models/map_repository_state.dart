import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapRepositoryState {
  final LatLng? latLng;
  final List<Marker> markers;
  final String address;

  const MapRepositoryState({
    required this.latLng,
    required this.markers,
    required this.address,
  });

  MapRepositoryState copyWith({
    LatLng? latLng,
    List<Marker>? markers,
    String? address,
  }) {
    return MapRepositoryState(
      latLng: latLng ?? this.latLng,
      markers: markers ?? this.markers,
      address: address ?? this.address,
    );
  }
}