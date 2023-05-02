import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '_widget.dart';

class TripRegisterAppBar extends DefaultAppBar {
  const TripRegisterAppBar({super.key, this.onTrailingPressed});

  final VoidCallback? onTrailingPressed;

  @override
  Widget build(BuildContext context) {
    final localizations = context.localizations;
    return PlatformBuilder(
      iOSBuilder: (context) {
        return CupertinoNavigationBar(
          padding: const EdgeInsetsDirectional.only(start: 6.0, end: 16.0),
          leading: CupertinoButton(
            padding: EdgeInsets.zero,
            alignment: Alignment.centerLeft,
            onPressed: () => Navigator.pop(context),
            child: const Icon(CupertinoIcons.back, size: 32.0),
          ),
          middle: Text(localizations.newcarpool.capitalize()),
          trailing: CustomButton(
            onPressed: onTrailingPressed,
            child: Text(localizations.create.capitalize()),
          ),
        );
      },
      builder: (context, platform) {
        return AppBar(
          title: Text(localizations.newcarpool.capitalize()),
        );
      },
    );
  }
}

class TripRegisterPlaceListWidget extends StatelessWidget {
  const TripRegisterPlaceListWidget({
    super.key,
    required this.departureTitle,
    required this.departureSubtitle,
    required this.destinationTitle,
    required this.destinationSubtitle,
    this.onDestinationPressed,
    this.onDeparturePressed,
  });

  final String departureTitle;
  final String departureSubtitle;

  final String destinationTitle;
  final String destinationSubtitle;

  final VoidCallback? onDeparturePressed;
  final VoidCallback? onDestinationPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomListTile(
                onTap: onDeparturePressed,
                title: Text(departureTitle),
                subtitle: Text(departureSubtitle),
                iconColor: CupertinoColors.black,
                leading: const Icon(CupertinoIcons.largecircle_fill_circle),
              ),
              const Divider(indent: 40.0),
              CustomListTile(
                onTap: () {},
                title: Text(destinationTitle),
                iconColor: CupertinoColors.black,
                subtitle: Text(destinationSubtitle),
                leading: const Icon(CupertinoIcons.circle),
              ),
            ],
          ),
        ),
        const Positioned(
          top: 35.0,
          left: 25.0,
          bottom: 35.0,
          child: VerticalDivider(thickness: 2.0, color: CupertinoColors.black),
        ),
      ],
    );
  }
}
