import 'package:deliverly_app/features/basket/repository/map_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../../../common/widgets/back_arrow_widget.dart';

class MapPage extends ConsumerStatefulWidget {
  final TextEditingController addressController;

  const MapPage({
    super.key,
    required this.addressController,
  });

  @override
  ConsumerState createState() => _MapPageState();
}

class _MapPageState extends ConsumerState<MapPage> {
  void _getCurrentLocation() async {
    await ref.read(mapRepositoryProvider.notifier).getCurrentLocation();
    widget.addressController.text = ref.read(mapRepositoryProvider).address;
  }

  void _setMarker({required LatLng latLng}) async {
    await ref.read(mapRepositoryProvider.notifier).setMarker(latLng: latLng);
    widget.addressController.text = ref.read(mapRepositoryProvider).address;
  }

  @override
  void initState() {
    _getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mapState = ref.watch(mapRepositoryProvider);
    return Scaffold(
      appBar: AppBar(
        leading: BackArrowWidget(
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: mapState.latLng == null
          ? const Center(child: CircularProgressIndicator())
          : FlutterMap(
              options: MapOptions(
                center: mapState.latLng,
                zoom: 17.0,
                onTap: (position, latLong) => _setMarker(latLng: latLong),
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                ),
                MarkerLayer(
                  markers: ref.watch(mapRepositoryProvider).markers,
                ),
                if (ref.watch(mapRepositoryProvider).markers.isNotEmpty)
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 36.0),
                      child: ElevatedButton(
                        onPressed:() => Navigator.of(context).pop(),
                        child: const Text('Select'),
                      ),
                    ),
                  ),
              ],
            ),
    );
  }
}
