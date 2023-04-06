import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '_screen.dart';

class TravelMapSearchSheet extends StatefulWidget {
  const TravelMapSearchSheet({super.key});

  @override
  State<TravelMapSearchSheet> createState() => _TravelMapSearchSheetState();
}

class _TravelMapSearchSheetState extends State<TravelMapSearchSheet> {
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final localizations = context.localizations;
    return FractionallySizedBox(
      heightFactor: 0.5,
      child: Scaffold(
        appBar: TravelMapSearchAppBar(
          leading: FloatingActionButton.small(
            elevation: 0.0,
            onPressed: () {},
            heroTag: 'location',
            shape: const CircleBorder(),
            backgroundColor: theme.colorScheme.onSurface,
            child: const Icon(CupertinoIcons.location),
          ),
          trailing: FloatingActionButton.small(
            elevation: 0.0,
            onPressed: () {},
            shape: const CircleBorder(),
            heroTag: 'arrow_up_to_line',
            backgroundColor: CupertinoColors.activeGreen,
            child: const Icon(CupertinoIcons.checkmark),
          ),
        ),
        body: CustomScrollView(
          slivers: [
            const SliverPinnedHeader(child: SizedBox(height: 0.0001)),
            SliverPinnedHeader.builder((context, overlap) {
              return CustomLabelTile(overlap: overlap, title: Text('${localizations.passenger}s'.capitalize()));
            }),
            SliverVisibility(
              replacementSliver: const SliverFillRemaining(
                child: Center(
                  child: IntrinsicWidth(
                    child: CustomListTile(
                      subtitle: Text("Les passagers inscrits s'afficheront ici"),
                    ),
                  ),
                ),
              ),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (index.isEven) {
                      return CustomListTile(
                        onTap: () {},
                        leading: const CircleAvatar(),
                        title: const Text('Allou Coulibaly'),
                        subtitle: const Text('Abidjan, Abobo'),
                        trailing: OverflowBar(
                          children: [
                            IconButton(
                              onPressed: () {},
                              padding: EdgeInsets.zero,
                              visualDensity: VisualDensity.compact,
                              style: IconButton.styleFrom(
                                foregroundColor: CupertinoColors.black,
                                backgroundColor: CupertinoColors.systemFill,
                              ),
                              icon: const Icon(CupertinoIcons.phone),
                            ),
                            const SizedBox(width: 8.0),
                            IconButton(
                              onPressed: () {},
                              padding: EdgeInsets.zero,
                              visualDensity: VisualDensity.compact,
                              style: IconButton.styleFrom(
                                foregroundColor: CupertinoColors.destructiveRed,
                                backgroundColor: CupertinoColors.systemFill,
                              ),
                              icon: const Icon(CupertinoIcons.trash),
                            ),
                          ],
                        ),
                      );
                    }
                    return const Divider(indent: 65.0);
                  },
                  childCount: max(0, 4 * 2 - 1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
