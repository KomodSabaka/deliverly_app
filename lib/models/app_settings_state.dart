import 'package:deliverly_app/common/enums/mode_enum.dart';
import 'package:deliverly_app/models/user.dart';

class AppSettingsState {
  final ModeEnum? mode;
  final AppUser? user;
  final bool? isAnon;
  final double currentExchangeRate;

  const AppSettingsState({
    this.mode,
    this.user,
    this.isAnon,
    this.currentExchangeRate = 0.0,
  });

  AppSettingsState copyWith({
    ModeEnum? mode,
    AppUser? user,
    bool? isAnon,
    double? currentExchangeRate,
  }) {
    return AppSettingsState(
      mode: mode ?? this.mode,
      user: user ?? this.user,
      isAnon: isAnon ?? this.isAnon,
      currentExchangeRate: currentExchangeRate ?? this.currentExchangeRate,
    );
  }
}
