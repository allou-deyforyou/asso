import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '_screen.dart';

class TripRegisterScreen extends StatefulWidget {
  const TripRegisterScreen({super.key});

  static const String path = 'trip/register';
  static const String name = 'trip_register';

  @override
  State<TripRegisterScreen> createState() => _TripRegisterScreenState();
}

class _TripRegisterScreenState extends State<TripRegisterScreen> {
  void _pushToTripMapScreen() {
    context.pushNamed(TripMapScreen.name);
  }

  @override
  Widget build(BuildContext context) {
    final localizations = context.localizations;
    return Scaffold(
      appBar: TripRegisterAppBar(
        onTrailingPressed: _pushToTripMapScreen,
      ),
      body: CustomScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        slivers: [
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
              label: Text(localizations.price.capitalize()),
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
        builder: (context, platform) => const SizedBox.shrink(),
        androidBuilder: (context) {
          return BottomAppBar(
            child: ListTile(
              title: CupertinoButton.filled(
                padding: EdgeInsets.zero,
                onPressed: _pushToTripMapScreen,
                borderRadius: BorderRadius.circular(30.0),
                child: Text(localizations.create.capitalize()),
              ),
            ),
          );
        },
      ),
    );
  }
}
