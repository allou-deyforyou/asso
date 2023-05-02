import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '_widget.dart';

class LocationSearchAppBar extends DefaultAppBar {
  const LocationSearchAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = context.localizations;
    return PlatformBuilder(androidBuilder: (context) {
      return AppBar(
        shape: const Border.fromBorderSide(BorderSide.none),
      );
    }, builder: (context, platform) {
      return CupertinoNavigationBar(
        border: const Border.fromBorderSide(BorderSide.none),
        leading: CustomButton(
          onPressed: () => Navigator.pop(context),
          child: Text(localizations.cancel.capitalize()),
        ),
      );
    });
  }
}

class LocationSearchPlaceListTile extends StatelessWidget {
  const LocationSearchPlaceListTile({
    super.key,
    required this.title,
    required this.iconColor,
    this.subtitle,
    this.onTap,
  });

  final Widget title;
  final Widget? subtitle;
  final Color iconColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      trailing: onTap != null ? const Icon(CupertinoIcons.map, color: CupertinoColors.systemGrey, size: 20.0) : null,
      leading: Icon(CupertinoIcons.circle, color: iconColor, size: 16.0),
      subtitle: subtitle,
      title: title,
      onTap: onTap,
    );
  }
}

class LocationSearchTextField extends StatelessWidget {
  const LocationSearchTextField({
    super.key,
    this.onSourceTaped,
    this.onDestinationTaped,
  });

  final VoidCallback? onSourceTaped;
  final VoidCallback? onDestinationTaped;

  @override
  Widget build(BuildContext context) {
    final localizations = context.localizations;
    final cupertinoTheme = context.cupertinoTheme;
    return Container(
      color: cupertinoTheme.barBackgroundColor,
      child: Stack(
        children: [
          Positioned(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CupertinoSearchTextField(
                  onTap: onSourceTaped,
                  borderRadius: BorderRadius.zero,
                  backgroundColor: Colors.transparent,
                  suffixIcon: const Icon(CupertinoIcons.clear),
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  placeholder: localizations.departurepoint.capitalize(),
                  prefixInsets: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 8.0, 0.0),
                  prefixIcon: const Icon(CupertinoIcons.largecircle_fill_circle, color: CupertinoColors.black),
                ),
                const Divider(indent: 45.0),
                CupertinoSearchTextField(
                  onTap: onDestinationTaped,
                  borderRadius: BorderRadius.zero,
                  backgroundColor: Colors.transparent,
                  suffixIcon: const Icon(CupertinoIcons.clear),
                  placeholder: localizations.wheretogo.capitalize(),
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  prefixInsets: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 8.0, 0.0),
                  prefixIcon: const Icon(CupertinoIcons.circle, color: CupertinoColors.black),
                ),
              ],
            ),
          ),
          const Positioned(
            top: 34.0,
            left: 25.0,
            bottom: 30.0,
            child: VerticalDivider(thickness: 2.0, color: CupertinoColors.black),
          ),
        ],
      ),
    );
  }
}
