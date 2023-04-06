import 'package:flutter/material.dart';
import 'package:maplibre_gl/mapbox_gl.dart';

import '_screen.dart';

class TravelMapScreen extends StatefulWidget {
  const TravelMapScreen({super.key});

  static const String path = 'travel/map';
  static const String name = 'travel_map';

  @override
  State<TravelMapScreen> createState() => _TravelMapScreenState();
}

class _TravelMapScreenState extends State<TravelMapScreen> {
  /// Widget
  late final GlobalKey<ScaffoldState> _scaffoldKey;

  void _listenAfterLayout(BuildContext context) async {
    _openTravelMapSheet();
  }

  /// Navigator
  void _openTravelMapSheet() async {
    final controller = _scaffoldKey.currentState!.showBottomSheet(
      (context) => const TravelMapSearchSheet(),
      enableDrag: false,
      elevation: 6.0,
    );

    await controller.closed;
    if (mounted) Navigator.pop(context);
  }

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

    /// Widget
    _scaffoldKey = GlobalKey<ScaffoldState>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: const TravelMapAppBar(),
      body: AfterLayout(
        listener: _listenAfterLayout,
        child: Listener(
          onPointerUp: _onMapPointUp,
          child: TravelMap(
            onMapCreated: _onMapCreated,
            onStyleLoadedCallback: _onStyleLoadedCallback,
            onUserLocationUpdated: _onUserLocationUpdated,
          ),
        ),
      ),
    );
  }
}
