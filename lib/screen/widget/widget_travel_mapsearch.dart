import 'package:flutter/cupertino.dart';

import '_widget.dart';

class TravelMapSearchAppBar extends DefaultAppBar {
  const TravelMapSearchAppBar({
    super.key,
    this.leading,
    this.trailing,
  });

  final Widget? leading;
  final Widget? trailing;

  @override
  Size get preferredSize => super.preferredSize * 1.2;

  @override
  Widget build(BuildContext context) {
    final localizations = context.localizations;
    final cupertinoTheme = context.cupertinoTheme;
    return SizedBox(
      height: preferredSize.height,
      child: CupertinoNavigationBar(
        leading: leading,
        trailing: trailing,
        transitionBetweenRoutes: false,
        automaticallyImplyLeading: false,
        backgroundColor: cupertinoTheme.scaffoldBackgroundColor,
        middle: IntrinsicWidth(
          child: CustomLabelTile(
            height: 35.0,
            title: Center(child: Text(localizations.timeelapsed.capitalize())),
            subtitle: const Center(child: FittedBox(fit: BoxFit.scaleDown, child: Text('05:10'))),
          ),
        ),
      ),
    );
  }
}
