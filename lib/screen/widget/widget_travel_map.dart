import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:maplibre_gl/mapbox_gl.dart';

import '_widget.dart';

class TravelMapAppBar extends DefaultAppBar {
  const TravelMapAppBar({
    super.key,
    this.onLeadingPressed,
  });

  final ValueChanged<BuildContext>? onLeadingPressed;

  @override
  Size get preferredSize => super.preferredSize * 1.2;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return SafeArea(
      child: Stack(
        children: [
          Positioned(
            left: 12.0,
            bottom: 0.0,
            child: Card(
              elevation: 0.8,
              margin: EdgeInsets.zero,
              shape: const CircleBorder(),
              child: CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () => Navigator.pop(context),
                child: IconTheme(
                  data: IconThemeData(color: theme.colorScheme.onSurface),
                  child: PlatformBuilder(
                    builder: (context) => const Icon(CupertinoIcons.back),
                    androidBuilder: (context) => const Icon(CupertinoIcons.arrow_left),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0.0,
            right: 12.0,
            child: Card(
              elevation: 0.8,
              margin: EdgeInsets.zero,
              shape: const CircleBorder(),
              child: CupertinoButton(
                onPressed: () {},
                padding: EdgeInsets.zero,
                child: IconTheme(
                  data: IconThemeData(color: theme.colorScheme.onSurface),
                  child: const Icon(CupertinoIcons.drop),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TravelMap extends StatelessWidget {
  const TravelMap({
    super.key,
    this.onMapIdle,
    this.onMapClick,
    this.onCameraIdle,
    this.onMapCreated,
    this.onMapLongClick,
    this.initialCameraPosition,
    this.onUserLocationUpdated,
    this.onStyleLoadedCallback,
    this.myLocationEnabled = true,
  });

  final bool myLocationEnabled;
  final VoidCallback? onMapIdle;
  final VoidCallback? onCameraIdle;
  final OnMapClickCallback? onMapClick;
  final MapCreatedCallback? onMapCreated;
  final OnMapClickCallback? onMapLongClick;
  final VoidCallback? onStyleLoadedCallback;
  final CameraPosition? initialCameraPosition;
  final OnUserLocationUpdated? onUserLocationUpdated;

  @override
  Widget build(BuildContext context) {
    return MaplibreMap(
      onMapIdle: onMapIdle,
      compassEnabled: false,
      onMapClick: onMapClick,
      onMapCreated: onMapCreated,
      trackCameraPosition: true,
      onCameraIdle: onCameraIdle,
      onMapLongClick: onMapLongClick,
      myLocationEnabled: myLocationEnabled,
      onUserLocationUpdated: onUserLocationUpdated,
      onStyleLoadedCallback: onStyleLoadedCallback ?? () {},
      gestureRecognizers: {Factory<OneSequenceGestureRecognizer>(() => EagerGestureRecognizer())},
      initialCameraPosition: initialCameraPosition ?? const CameraPosition(target: LatLng(0.0, 0.0)),
      styleString: 'https://api.maptiler.com/maps/86f5df0b-f809-4e6f-b8f0-9d3e0976fe90/style.json?key=ohdDnBihXL3Yk2cDRMfO',
    );
  }
}
