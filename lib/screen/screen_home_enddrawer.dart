import 'package:flutter/material.dart';

import '_screen.dart';

class HomeEndDrawer extends StatefulWidget {
  const HomeEndDrawer({super.key});

  @override
  State<HomeEndDrawer> createState() => _HomeEndDrawerState();
}

class _HomeEndDrawerState extends State<HomeEndDrawer> {
  @override
  Widget build(BuildContext context) {
    return const Drawer(
      shape: Border.fromBorderSide(BorderSide.none),
      child: Scaffold(
        appBar: HomeEndDrawerAppBar(),
      ),
    );
  }
}
