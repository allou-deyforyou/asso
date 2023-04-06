import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static const String path = 'settings';
  static const String name = 'settings';

  @override
  Widget build(BuildContext context) {
    final cupertinoTheme = context.cupertinoTheme;
    return Scaffold(
      appBar: const SettingsAppBar(),
      backgroundColor: defaultTargetPlatform == TargetPlatform.android ? null : cupertinoTheme.barBackgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: PlatformBuilder(
              androidBuilder: (context) {
                return const CustomListTile(
                  height: 80.0,
                  leading: CircleAvatar(radius: 25.0),
                  title: Text('Allou Coulibaly'),
                  subtitle: Text('+225 0749414602'),
                );
              },
              builder: (context) {
                return CupertinoListSection(
                  children: const [
                    CupertinoListTile.notched(
                      leadingSize: 40.0,
                      leading: CircleAvatar(radius: 25.0),
                      title: Text('Allou Coulibaly'),
                      subtitle: Text('+225 0749414602'),
                    ),
                  ],
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: PlatformBuilder(
              androidBuilder: (context) {
                return Column(
                  children: const [
                    Divider(),
                    CustomListTile(
                      height: 60.0,
                      title: Text('Confidentialité'),
                      subtitle: Text('Securité'),
                    ),
                    CustomListTile(
                      height: 60.0,
                      title: Text('Notifications'),
                      subtitle: Text('Securité'),
                    ),
                  ],
                );
              },
              builder: (context) {
                return CupertinoListSection(
                  additionalDividerMargin: 0.0,
                  children: const [
                    CupertinoListTile(
                      trailing: CupertinoListTileChevron(),
                      title: Text('Confidentialité'),
                    ),
                    CupertinoListTile(
                      trailing: CupertinoListTileChevron(),
                      title: Text('Notifications'),
                    ),
                  ],
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: PlatformBuilder(
              androidBuilder: (context) {
                return Column(
                  children: const [
                    Divider(),
                    CustomListTile(
                      height: 60.0,
                      title: Text('Devenir conducteur'),
                      subtitle: Text('Securité'),
                    ),
                    CustomListTile(
                      height: 60.0,
                      title: Text('Support / Aide'),
                      subtitle: Text('Securité'),
                    ),
                    Divider(),
                    CustomListTile(
                      height: 60.0,
                      title: Text('Inviter un ami'),
                    ),
                  ],
                );
              },
              builder: (context) {
                return CupertinoListSection(
                  additionalDividerMargin: 0.0,
                  children: const [
                    CupertinoListTile(
                      trailing: CupertinoListTileChevron(),
                      title: Text('Devenir conducteur'),
                    ),
                    CupertinoListTile(
                      trailing: CupertinoListTileChevron(),
                      title: Text('Support / Aide'),
                    ),
                    CupertinoListTile(
                      trailing: CupertinoListTileChevron(),
                      title: Text('Inviter un ami'),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
