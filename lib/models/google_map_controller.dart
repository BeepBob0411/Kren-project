import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class GoogleMapControllerPage extends StatefulWidget {
  @override
  _GoogleMapControllerPageState createState() =>
      _GoogleMapControllerPageState();
}

class _GoogleMapControllerPageState extends State<GoogleMapControllerPage> {
  late GoogleMapController _mapController;
  LatLng? _initialCameraPosition;

  @override
  void initState() {
    super.initState();
    _checkLocationPermissionAndFetch();
  }

  Future<void> _checkLocationPermissionAndFetch() async {
    // Memeriksa dan meminta izin
    var status = await Permission.location.request();

    if (status == PermissionStatus.denied) {
      status = await Permission.location.request();
    }

    if (status == PermissionStatus.permanentlyDenied) {
      // Handle the case where the user has permanently denied location access
      return;
    }

    if (status == PermissionStatus.granted) {
      await _getUserLocation();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps Controller'),
      ),
      body: GoogleMap(
        onMapCreated: (controller) {
          setState(() {
            _mapController = controller;
          });
        },
        initialCameraPosition: CameraPosition(
          target: _initialCameraPosition ?? LatLng(-6.2088, 106.8456),
          zoom: 14.0,
        ),
      ),
    );
  }

  Future<void> _getUserLocation() async {
    try {
      final Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _initialCameraPosition =
            LatLng(position.latitude, position.longitude);
      });
    } catch (e) {
      print("Error getting user location: $e");
      setState(() {
        // Fallback to a default location if the user's location cannot be determined
        _initialCameraPosition = LatLng(-6.2088, 106.8456);
      });
    }
  }

  void moveToLocation(LatLng location) {
    _mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: location,
          zoom: 14.0,
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose the controller when the widget is disposed
    _mapController.dispose();
    super.dispose();
  }
}
