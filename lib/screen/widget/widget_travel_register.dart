import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '_widget.dart';

class TravelRegisterAppBar extends DefaultAppBar {
  const TravelRegisterAppBar({super.key, this.onTrailingPressed});

  final VoidCallback? onTrailingPressed;

  @override
  Widget build(BuildContext context) {
    final localizations = context.localizations;
    return PlatformBuilder(
      iOSBuilder: (context) {
        return CupertinoNavigationBar(
          middle: Text(localizations.newcarpool.capitalize()),
          trailing: CustomButton(
            onPressed: onTrailingPressed,
            child: Text(localizations.create.capitalize()),
          ),
        );
      },
      builder: (context) {
        return AppBar(
          title: Text(localizations.createtravel.capitalize()),
        );
      },
    );
  }
}
