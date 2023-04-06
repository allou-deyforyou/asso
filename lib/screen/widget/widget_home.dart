import 'package:flutter/cupertino.dart';

import '_widget.dart';

class HomeAppBar extends DefaultAppBar {
  const HomeAppBar({
    super.key,
    this.onLeadingPressed,
    this.onTrailingPressed,
  });

  final VoidCallback? onLeadingPressed;
  final VoidCallback? onTrailingPressed;

  @override
  Widget build(BuildContext context) {
    final localizations = context.localizations;
    return CupertinoNavigationBar(
      border: const Border.fromBorderSide(BorderSide.none),
      leading: CustomButton(
        onPressed: onLeadingPressed,
        child: const Icon(CupertinoIcons.chart_bar_circle),
      ),
      middle: Text(localizations.asso.capitalize()),
      trailing: CustomButton(
        onPressed: onTrailingPressed,
        child: const Icon(CupertinoIcons.gear),
      ),
    );
  }
}
