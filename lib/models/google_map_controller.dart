import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapControllerPage extends StatefulWidget {
  @override
  _GoogleMapControllerPageState createState() => _GoogleMapControllerPageState();
}

class _GoogleMapControllerPageState extends State<GoogleMapControllerPage> {
  late GoogleMapController _mapController;

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
          target: LatLng(-6.2088, 106.8456), // Default to Jakarta, Indonesia
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
