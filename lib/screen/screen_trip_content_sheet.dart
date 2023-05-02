import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '_screen.dart';

class TripContentSheet extends StatefulWidget {
  const TripContentSheet({
    super.key,
    required this.maxChildSize,
  });

  final double maxChildSize;

  @override
  State<TripContentSheet> createState() => _TripContentSheetState();
}

class _TripContentSheetState extends State<TripContentSheet> {
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final cupertinoTheme = context.cupertinoTheme;
    return DraggableScrollableSheet(
      snap: true,
      expand: false,
      minChildSize: 0.5,
      initialChildSize: 0.5,
      maxChildSize: widget.maxChildSize,
      snapSizes: [0.5, widget.maxChildSize],
      builder: (context, scrollController) {
        return Scaffold(
          appBar: TripMapSearchAppBar(
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
              heroTag: CupertinoIcons.add.codePoint,
              backgroundColor: CupertinoColors.activeGreen,
              child: const Icon(CupertinoIcons.add),
            ),
          ),
          body: CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: DefaultTextStyle(
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
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                      child: OverflowBar(
                        alignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text.rich(
                              TextSpan(children: [
                                WidgetSpan(child: Icon(CupertinoIcons.calendar)),
                                TextSpan(text: ' '),
                                TextSpan(text: "Aujourd'hui à 15h00"),
                              ]),
                            ),
                          ),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text.rich(
                              TextSpan(children: [
                                WidgetSpan(child: Icon(CupertinoIcons.money_dollar_circle)),
                                TextSpan(text: ' '),
                                TextSpan(text: "2000 FCFA"),
                              ]),
                            ),
                          ),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text.rich(
                              TextSpan(text: "02 Places"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: TripRegisterPlaceListWidget(
                  departureTitle: "Koumassi Mairie",
                  destinationTitle: "Adjame Mairie",
                  departureSubtitle: "Bingerville, Côte d'Ivoire",
                  destinationSubtitle: "Bingerville, Côte d'Ivoire",
                  onDeparturePressed: () {},
                  onDestinationPressed: () {},
                ),
              ),
              const SliverToBoxAdapter(child: Divider(height: 8.0, thickness: 8.0)),
              const SliverToBoxAdapter(child: CustomLabelTile(title: Text('Admin'))),
              SliverToBoxAdapter(
                child: CustomListTile(
                  onTap: () {},
                  leading: const CircleAvatar(),
                  title: const Text('Allou Coulibaly'),
                  subtitle: const Text('4.5 / 5'),
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
                    ],
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
