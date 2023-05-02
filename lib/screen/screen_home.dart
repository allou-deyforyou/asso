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
    _scaffoldKey.currentState!.openDrawer();
    _unfocus();
  }

  void _onTrailingPressed() {
    _scaffoldKey.currentState!.openEndDrawer();
    _unfocus();
  }

  void _onLocationSearchPressed() {
    context.pushNamed(LocationSearchScreen.name);
  }

  void _onTripItemPressed() {
    context.pushNamed(TripContentScreen.name);
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
    // final localizations = context.localizations;
    return Scaffold(
      key: _scaffoldKey,
      drawer: const HomeDrawer(),
      endDrawer: const HomeEndDrawer(),
      appBar: HomeAppBar(
        onLeadingPressed: _onLeadingPressed,
        onTrailingPressed: _onTrailingPressed,
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0.0,
        shape: const CircleBorder(),
        onPressed: _onLocationSearchPressed,
        child: const Icon(CupertinoIcons.add),
      ),
      body: CustomScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        slivers: [
          SliverPinnedHeader(
            child: AppBarSearchTextField(
              focusNode: _searchFocusNode,
              controller: _searchTextController,
            ),
          ),
          const SliverPinnedHeader(child: Divider()),
          const CupertinoSliverRefreshControl(),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index.isEven) {
                  index ~/= 2;
                  return HomeTripItemWidget(
                    places: "02 Places",
                    amount: "1000 FCFA",
                    departureDateTime: "Aujourd'hui à 20h00",
                    departureTitle: "Koumassi Mairie",
                    departureSubtitle: "Bingerville, Côte d'Ivoire",
                    destinationTitle: "Adjame Mairie",
                    destinationSubtitle: "Bingerville, Côte d'Ivoire",
                    onPressed: _onTripItemPressed,
                  );
                }
                return const Divider(height: 12.0, thickness: 12.0);
              },
              childCount: max(0, 4 * 2 - 1),
            ),
          ),
          const SliverFillRemaining(
            hasScrollBody: false,
            child: SafeArea(child: SizedBox(height: 80.0)),
          ),
        ],
      ),
    );
  }
}
