import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    // final localizations = context.localizations;
    return PlatformBuilder(
      androidBuilder: (context) {
        return AppBar(
          centerTitle: true,
          surfaceTintColor: Colors.transparent,
          shape: const Border.fromBorderSide(BorderSide.none),
          leading: ConstrainedBox(
            constraints: const BoxConstraints.tightFor(width: kToolbarHeight),
            child: IconButton(
              onPressed: onLeadingPressed,
              icon: const Icon(Icons.menu),
            ),
          ),
          title: IntrinsicWidth(
            child: Material(
              color: Colors.transparent,
              child: CustomButton(
                onPressed: () {},
                child: const CustomLabelTile(
                  title: Center(child: Text('Your departure')),
                  subtitle: Center(child: Text('Quartier Abatta')),
                ),
              ),
            ),
          ),
          actions: [
            ConstrainedBox(
              constraints: const BoxConstraints.tightFor(width: kToolbarHeight),
              child: IconButton(
                onPressed: onTrailingPressed,
                icon: const Icon(CupertinoIcons.bell),
              ),
            ),
          ],
        );
      },
      builder: (context, platform) {
        return CupertinoNavigationBar(
          border: const Border.fromBorderSide(BorderSide.none),
          trailing: CustomButton(
            onPressed: onTrailingPressed,
            child: const Icon(CupertinoIcons.bell),
          ),
          middle: IntrinsicWidth(
            child: Material(
              color: Colors.transparent,
              child: CustomButton(
                onPressed: () {},
                child: const CustomLabelTile(
                  title: Center(child: Text('Your departure')),
                  subtitle: Center(child: Text('Quartier Abatta')),
                ),
              ),
            ),
          ),
          leading: CustomButton(
            onPressed: onLeadingPressed,
            child: const Icon(CupertinoIcons.bars, size: 28.0),
          ),
        );
      },
    );
  }
}

class HomeTripItemWidget extends StatelessWidget {
  const HomeTripItemWidget({
    super.key,
    required this.departureTitle,
    required this.departureSubtitle,
    required this.destinationTitle,
    required this.destinationSubtitle,
    required this.departureDateTime,
    required this.amount,
    required this.places,
    this.onPressed,
  });

  final String departureTitle;
  final String departureSubtitle;

  final String destinationTitle;
  final String destinationSubtitle;

  final String departureDateTime;
  final String amount;
  final String places;

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final cupertinoTheme = context.cupertinoTheme;
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          children: [
            Stack(
              children: [
                Positioned(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomListTile(
                        leading: const Icon(CupertinoIcons.largecircle_fill_circle),
                        subtitle: Text(departureSubtitle),
                        title: Text(
                          departureTitle,
                          style: cupertinoTheme.textTheme.navLargeTitleTextStyle.copyWith(
                            fontSize: theme.textTheme.headlineSmall!.fontSize,
                          ),
                        ),
                        iconColor: cupertinoTheme.textTheme.navLargeTitleTextStyle.color,
                      ),
                      CustomListTile(
                        leading: const Icon(CupertinoIcons.circle),
                        subtitle: Text(destinationSubtitle),
                        title: Text(
                          destinationTitle,
                          style: cupertinoTheme.textTheme.navLargeTitleTextStyle.copyWith(
                            fontSize: theme.textTheme.headlineSmall!.fontSize,
                          ),
                        ),
                        iconColor: cupertinoTheme.textTheme.navLargeTitleTextStyle.color,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 35.0,
                  left: 25.0,
                  bottom: 35.0,
                  child: VerticalDivider(thickness: 2.0, color: cupertinoTheme.textTheme.navLargeTitleTextStyle.color),
                ),
              ],
            ),
            const Divider(indent: 16.0, endIndent: 16.0, height: 16.0),
            DefaultTextStyle(
              style: TextStyle(
                letterSpacing: -0.6,
                color: cupertinoTheme.textTheme.tabLabelTextStyle.color,
                fontWeight: cupertinoTheme.textTheme.tabLabelTextStyle.fontWeight,
              ),
              child: IconTheme(
                data: IconThemeData(
                  size: 18.0,
                  color: context.cupertinoTheme.textTheme.tabLabelTextStyle.color,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: OverflowBar(
                    alignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text.rich(
                          TextSpan(children: [
                            const WidgetSpan(child: Icon(CupertinoIcons.calendar)),
                            const TextSpan(text: ' '),
                            TextSpan(text: departureDateTime),
                          ]),
                        ),
                      ),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text.rich(
                          TextSpan(children: [
                            const WidgetSpan(child: Icon(CupertinoIcons.money_dollar_circle)),
                            const TextSpan(text: ' '),
                            TextSpan(text: amount),
                          ]),
                        ),
                      ),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text.rich(
                          TextSpan(text: places),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
