import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '_screen.dart';

class LocationSearchScreen extends StatefulWidget {
  const LocationSearchScreen({super.key});

  static const String path = 'location/search';
  static const String name = 'location_search';

  @override
  State<LocationSearchScreen> createState() => _LocationSearchScreenState();
}

class _LocationSearchScreenState extends State<LocationSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LocationSearchAppBar(),
      body: SafeArea(
        child: CustomScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: [
            const SliverPinnedHeader(child: LocationSearchTextField()),
            const SliverPinnedHeader(child: Divider(height: 8.0, thickness: 8.0)),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index.isEven) {
                    index ~/= 2;
                    return CustomListTile(
                      title: const Text("Abatta Village"),
                      subtitle: const Text("Bingerville, Côte d'Ivoire"),
                      leading: const Icon(CupertinoIcons.location_solid, color: CupertinoColors.systemGrey2),
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) {
                              return const TravelRegisterScreen();
                            },
                          ),
                        );
                      },
                    );
                  }
                  return const Divider(indent: 45.0);
                },
                childCount: max(0, 20 * 2 - 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
