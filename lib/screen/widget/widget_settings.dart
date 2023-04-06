import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '_widget.dart';

class SettingsAppBar extends DefaultAppBar {
  const SettingsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = context.localizations;
    return PlatformBuilder(
      iOSBuilder: (context) {
        return CupertinoNavigationBar(
          middle: Text('${localizations.setting}s'.capitalize()),
        );
      },
      builder: (context) {
        return AppBar(
          title: Text('${localizations.setting}s'.capitalize()),
        );
      },
    );
  }
}
