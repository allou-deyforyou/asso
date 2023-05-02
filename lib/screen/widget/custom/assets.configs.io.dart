import 'dart:io';

import 'assets.gen.dart';
import 'assets.configs.dart';

class $AssetsConfigs extends AssetsConfigs {
  @override
  Future<void> initialize() async {
    return SecurityContext.defaultContext.setTrustedCertificates(Assets.files.letsEncryptR3);
  }
}
