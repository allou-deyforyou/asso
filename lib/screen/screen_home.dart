import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String path = '/';
  static const String name = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// Custom
  late final GlobalKey<ScaffoldState> _scaffoldKey;
  late final TextEditingController _searchTextController;
  late final FocusNode _searchFocusNode;

  void _unfocus() {
    _searchFocusNode.unfocus();
  }

  void _onLeadingPressed() {
    _unfocus();
  }

  void _onTrailingPressed() {
    _unfocus();
    context.pushNamed(SettingsScreen.name);
  }

  void _onLocationSearchPressed() {
    _unfocus();
    context.pushNamed(LocationSearchScreen.name);
  }

  @override
  void initState() {
    super.initState();

    /// Custom
    _scaffoldKey = GlobalKey<ScaffoldState>();
    _searchTextController = TextEditingController();
    _searchFocusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = context.localizations;
    return Scaffold(
      key: _scaffoldKey,
      appBar: HomeAppBar(
        onLeadingPressed: _onLeadingPressed,
        onTrailingPressed: _onTrailingPressed,
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0.8,
        shape: const CircleBorder(),
        onPressed: _onLocationSearchPressed,
        child: const Icon(CupertinoIcons.add),
      ),
      body: CustomScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        slivers: [
          SliverPinnedHeader(
            child: AppBarSearchTextField(
              controller: _searchTextController,
              focusNode: _searchFocusNode,
            ),
          ),
          SliverPinnedHeader.builder((context, overlap) {
            return Visibility(visible: !overlap, child: const Divider());
          }),
          const CupertinoSliverRefreshControl(),
          MultiSliver(
            pushPinnedChildren: true,
            children: [
              SliverPinnedHeader.builder((context, overlap) {
                return CustomLabelTile(overlap: overlap, title: Text(localizations.nearyou.capitalize()));
              }),
              SliverPinnedHeader.builder((context, overlap) {
                return Visibility(visible: overlap, child: const Divider());
              }),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (index.isEven) {
                      index ~/= 2;
                      return CustomListTile(
                        title: const Text('Abatta - Koumassi'),
                        subtitle: const Text('1000 F'),
                        trailing: const CircleAvatar(
                          radius: 15.0,
                          backgroundColor: CupertinoColors.activeGreen,
                          child: Text('12'),
                        ),
                        onTap: () {},
                      );
                    }
                    return const Divider(indent: 16.0);
                  },
                  childCount: max(0, 2 * 2 - 1),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
