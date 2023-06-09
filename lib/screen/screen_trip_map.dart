import 'package:flutter/material.dart';
import 'package:maplibre_gl/mapbox_gl.dart';

import '_screen.dart';

class TripMapScreen extends StatefulWidget {
  const TripMapScreen({super.key});

  static const String path = 'trip/map';
  static const String name = 'trip_map';

  @override
  State<TripMapScreen> createState() => _TripMapScreenState();
}

class _TripMapScreenState extends State<TripMapScreen> {
  /// Widgets
  late final GlobalKey<ScaffoldState> _scaffoldKey;

  /// MapLibre
  MaplibreMapController? _mapController;
  UserLocation? _userLocation;

  void _onMapCreated(MaplibreMapController controller) {
    _mapController = controller;
    _onStyleLoadedCallback();
  }

  Future<void> _updateContentInsets() {
    final size = _scaffoldKey.currentContext!.size!;
    return _mapController!.updateContentInsets(EdgeInsets.only(bottom: size.height * 0.3));
  }

  void _onStyleLoadedCallback() async {
    await _updateContentInsets();
    if (_userLocation != null) await _goToPosition(_userLocation!.position);
  }

  void _onUserLocationUpdated(UserLocation location) {
    if (_userLocation == null) _goToPosition(location.position);
    _userLocation = location;
  }

  Future<bool?> _goToPosition(LatLng target) async {
    return _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: target, zoom: 16.0),
      ),
      duration: const Duration(seconds: 1),
    );
  }

  void _onMapPointUp(PointerUpEvent event) {}

  @override
  void initState() {
    super.initState();

    /// Widgets
    _scaffoldKey = GlobalKey<ScaffoldState>();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = context.mediaQuery;
    final height = mediaQuery.size.height;
    final paddingTop = mediaQuery.padding.top + 10;
    final maxChildSize = (height - paddingTop) / height;
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: const TripMapAppBar(),
      bottomSheet: TripMapSearchSheet(
        maxChildSize: maxChildSize,
      ),
      body: Listener(
        onPointerUp: _onMapPointUp,
        child: TripMap(
          onMapCreated: _onMapCreated,
          onStyleLoadedCallback: _onStyleLoadedCallback,
          onUserLocationUpdated: _onUserLocationUpdated,
        ),
      ),
    );
  }
}
