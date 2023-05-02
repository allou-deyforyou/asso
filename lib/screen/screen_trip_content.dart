import 'package:flutter/material.dart';
import 'package:maplibre_gl/mapbox_gl.dart';

import '_screen.dart';

class TripContentScreen extends StatefulWidget {
  const TripContentScreen({super.key});

  static const String path = 'trip/content';
  static const String name = 'trip_content';

  @override
  State<TripContentScreen> createState() => _TripContentScreenState();
}

class _TripContentScreenState extends State<TripContentScreen> {
  /// Widgets
  late final GlobalKey<ScaffoldState> _scaffoldKey;

  /// Navigator
  // void _openTripMapSheet() async {
    // final controller = _scaffoldKey.currentState!.showBottomSheet(
    //   (context) {
    //     return const TripContentSheet();
    //   },
    //   enableDrag: false,
    //   elevation: 6.0,
    // );

    // await controller.closed;
    // if (mounted) Navigator.pop(context);
  // }

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
      bottomSheet: TripContentSheet(maxChildSize: maxChildSize),
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
