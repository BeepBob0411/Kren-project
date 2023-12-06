import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart'; // Import Clipboard

class LocationPickerMap extends StatefulWidget {
  @override
  _LocationPickerMapState createState() => _LocationPickerMapState();
}

class _LocationPickerMapState extends State<LocationPickerMap> {
  GoogleMapController? _mapController;
  LatLng? _selectedLocation;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    try {
      final Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _selectedLocation = LatLng(position.latitude, position.longitude);
      });
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  void _copyLocationToClipboard() {
    if (_selectedLocation != null) {
      final String coordinates =
          "${_selectedLocation!.latitude}, ${_selectedLocation!.longitude}";

      Clipboard.setData(ClipboardData(text: coordinates));

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Koordinat disalin ke clipboard: $coordinates"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pick Location"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: _copyLocationToClipboard,
          ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _selectedLocation ?? LatLng(-6.2088, 106.8456),
          zoom: 12.0,
        ),
        markers: _selectedLocation != null
            ? {
          Marker(
            markerId: MarkerId("selectedLocation"),
            position: _selectedLocation!,
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueRed,
            ),
          ),
        }
            : {},
        onTap: (LatLng latLng) {
          _onMapTap(latLng);
        },
        onMapCreated: (GoogleMapController controller) {
          _mapController = controller;
        },
      ),
    );
  }

  void _onMapTap(LatLng latLng) {
    setState(() {
      _selectedLocation = latLng;
    });
  }
}
