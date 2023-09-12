import 'dart:io';

import 'package:deliverly_app/features/settings/repositores/client_settings_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/pay_card.dart';
import '../../../models/purchase_order.dart';

final clientSettingsController = Provider<ClientSettingsController>((ref) {
  return ClientSettingsController(
    clientSettingRepository: ref.watch(
      clientSettingRepository,
    ),
  );
});

class ClientSettingsController {
  final ClientSettingRepository clientSettingRepository;

  const ClientSettingsController({
    required this.clientSettingRepository,
  });

  Future changeClient({
    required String name,
    required String phone,
    required PayCard card,
  }) async {
    await clientSettingRepository.changeClient(
      name: name,
      phone: phone,
      card: card,
    );
  }

  Future<List<PurchaseOrder>> getHistory() async {
    return await clientSettingRepository.getHistory();
  }
}
