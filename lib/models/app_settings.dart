import 'package:deliverly_app/common/enums/mode_enum.dart';
import 'package:deliverly_app/models/user.dart';

class AppSettings {
  final ModeEnum mode;
  final AppUser? user;

  const AppSettings({
    required this.mode,
    this.user,
  });

  AppSettings copyWith({
    ModeEnum? mode,
    AppUser? user,
  }) {
    return AppSettings(
      mode: mode ?? this.mode,
      user: user ?? this.user,
    );
  }
}