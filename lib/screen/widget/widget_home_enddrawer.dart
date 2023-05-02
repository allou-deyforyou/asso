import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '_widget.dart';

class HomeEndDrawerAppBar extends DefaultAppBar {
  const HomeEndDrawerAppBar({super.key, this.onTrailingPressed});

  final VoidCallback? onTrailingPressed;

  @override
  Widget build(BuildContext context) {
    final localizations = context.localizations;
    return PlatformBuilder(
      iOSBuilder: (context) {
        return CupertinoNavigationBar(
          padding: const EdgeInsetsDirectional.only(start: 8.0, end: 16.0),
          leading: CupertinoButton(
            padding: EdgeInsets.zero,
            alignment: Alignment.centerLeft,
            onPressed: () => Navigator.pop(context),
            child: const Icon(CupertinoIcons.back, size: 32.0),
          ),
          middle: Text('${localizations.notification}s'.capitalize()),
        );
      },
      builder: (context, platform) {
        return AppBar(
          title: Text('${localizations.notification}s'.capitalize()),
        );
      },
    );
  }
}
