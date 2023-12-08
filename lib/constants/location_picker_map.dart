import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationPickerMap extends StatefulWidget {
  @override
  _LocationPickerMapState createState() => _LocationPickerMapState();
}

class _LocationPickerMapState extends State<LocationPickerMap> {
  late GoogleMapController _mapController;
  LatLng? _selectedLocation;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    // Memeriksa dan meminta izin
    var status = await Permission.location.request();

    if (status == PermissionStatus.granted) {
      try {
        final Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        setState(() {
          _selectedLocation = LatLng(position.latitude, position.longitude);
        });

        // Pusatkan peta ke lokasi pengguna saat ini
        _mapController.animateCamera(
          CameraUpdate.newLatLng(_selectedLocation!),
        );
      } catch (e) {
        print("Error getting location: $e");
      }
    } else {
      // Izin tidak diberikan
      print('Location permission denied.');
    }
  }

  void _sendLocationToReport() {
    if (_selectedLocation != null) {
      Navigator.pop(context, _selectedLocation); // Send back the location to the previous screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pick Location"),
        actions: [
          IconButton(
            icon: Icon(Icons.send),
            onPressed: _sendLocationToReport,
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
          setState(() {
            _mapController = controller;
          });
        },
      ),
    );
  }

  void _onMapTap(LatLng latLng) {
    print("Map tapped at: $latLng");
    setState(() {
      _selectedLocation = latLng;
    });
  }
}
