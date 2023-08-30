import 'package:deliverly_app/common/enums/mode_enum.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/app_settings.dart';
import '../../models/user.dart';

final appSettingsProvider =
    StateNotifierProvider<AppSettingsNotifier, AppSettings>(
  (ref) => AppSettingsNotifier(),
);

class AppSettingsNotifier extends StateNotifier<AppSettings> {
  AppSettingsNotifier() : super(const AppSettings(mode: ModeEnum.client));

  bool get isClientMode {
    return state.mode == ModeEnum.client ? true : false;
  }

  void setUser({required AppUser user}) {
    state.copyWith(user: user);
  }

  void setMode({required ModeEnum mode}) {
    state.copyWith(mode: mode);
  }

  ModeEnum getMode() {
    return state.mode;
  }
}
