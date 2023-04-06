import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '_screen.dart';

class TravelRegisterScreen extends StatefulWidget {
  const TravelRegisterScreen({super.key});

  static const String path = 'travel/register';
  static const String name = 'travel_register';

  @override
  State<TravelRegisterScreen> createState() => _TravelRegisterScreenState();
}

class _TravelRegisterScreenState extends State<TravelRegisterScreen> {
  void _pushToTravelMapScreen() {
    context.pushNamed(TravelMapScreen.name);
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final localizations = context.localizations;
    final cupertinoTheme = context.cupertinoTheme;
    return Scaffold(
      appBar: TravelRegisterAppBar(
        onTrailingPressed: _pushToTravelMapScreen,
      ),
      backgroundColor: defaultTargetPlatform == TargetPlatform.android ? null : cupertinoTheme.barBackgroundColor,
      body: CustomScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        slivers: [
          SliverToBoxAdapter(
            child: LocationSearchPlaceListTile(
              onTap: () {},
              subtitle: const Text("Bingerville, Côte d'Ivoire"),
              title: const Text("Koumassi Mairie"),
              iconColor: CupertinoColors.activeBlue,
            ),
          ),
          const SliverToBoxAdapter(child: Divider(indent: 40.0)),
          SliverToBoxAdapter(
            child: LocationSearchPlaceListTile(
              onTap: () {},
              subtitle: const Text("Bingerville, Côte d'Ivoire"),
              title: const Text("Adjame Mairie"),
              iconColor: CupertinoColors.activeOrange,
            ),
          ),
          const SliverToBoxAdapter(child: Divider()),
          const SliverToBoxAdapter(child: SizedBox(height: 16.0)),
          SliverToBoxAdapter(
            child: CustomTextField(
              label: Text("${localizations.passenger}s".capitalize()),
              placeholder: localizations.count.capitalize(),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 8.0)),
          SliverToBoxAdapter(
            child: CustomTextField(
              label: Text(localizations.participation.capitalize()),
              placeholder: localizations.amount.capitalize(),
              suffix: const Text("F"),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 8.0)),
          SliverToBoxAdapter(
            child: CustomTextField(
              placeholder: "${localizations.type.capitalize()}...",
              label: Text(localizations.description.capitalize()),
              minLines: 4,
              maxLines: 5,
            ),
          ),
        ],
      ),
      bottomNavigationBar: PlatformBuilder(
        builder: (context) => const SizedBox.shrink(),
        androidBuilder: (context) {
          return SafeArea(
            child: ListTile(
              shape: Border(top: BorderSide(width: 0.8, color: theme.dividerTheme.color!)),
              title: CupertinoButton.filled(
                padding: EdgeInsets.zero,
                borderRadius: BorderRadius.zero,
                onPressed: _pushToTravelMapScreen,
                child: Text(localizations.create.capitalize()),
              ),
            ),
          );
        },
      ),
    );
  }
}
