import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '_screen.dart';

class TripMapSearchSheet extends StatefulWidget {
  const TripMapSearchSheet({
    super.key,
    required this.maxChildSize,
  });

  final double maxChildSize;

  @override
  State<TripMapSearchSheet> createState() => _TripMapSearchSheetState();
}

class _TripMapSearchSheetState extends State<TripMapSearchSheet> {
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final localizations = context.localizations;
    return DraggableScrollableSheet(
      snap: true,
      expand: false,
      minChildSize: 0.5,
      initialChildSize: 0.5,
      maxChildSize: widget.maxChildSize,
      snapSizes: [0.5, widget.maxChildSize],
      builder: (context, scrollController) {
        return Scaffold(
          body: CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverPinnedHeader(
                child: TripMapSearchAppBar(
                  leading: FloatingActionButton.small(
                    elevation: 0.0,
                    onPressed: () {},
                    shape: const CircleBorder(),
                    heroTag: CupertinoIcons.location.codePoint,
                    backgroundColor: theme.colorScheme.onSurface,
                    child: const Icon(CupertinoIcons.location),
                  ),
                  trailing: FloatingActionButton.small(
                    elevation: 0.0,
                    onPressed: () {},
                    shape: const CircleBorder(),
                    heroTag: CupertinoIcons.checkmark.codePoint,
                    backgroundColor: CupertinoColors.activeGreen,
                    child: const Icon(CupertinoIcons.checkmark),
                  ),
                ),
              ),
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
                                  backgroundColor: CupertinoColors.tertiarySystemFill,
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
                                  backgroundColor: CupertinoColors.tertiarySystemFill,
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
        );
      },
    );
  }
}
