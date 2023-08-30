import 'dart:io';

import 'package:deliverly_app/features/settings/repositores/seller_settings_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final sellerSettingsController = Provider<SellerSettingsController>((ref) {
  return SellerSettingsController(
    sellerSettingRepository: ref.watch(
      sellerSettingRepository,
    ),
  );
});

class SellerSettingsController {
  final SellerSettingRepository sellerSettingRepository;

  const SellerSettingsController({
    required this.sellerSettingRepository,
  });

  Future changeCompany({
    required String name,
    required String description,
    required File? photo,
  }) async {
    await sellerSettingRepository.changeCompany(
      name: name,
      description: description,
      photo: photo,
    );
  }
}
