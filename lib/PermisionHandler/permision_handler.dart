import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';

Future<void> getLocation() async {
  PermissionStatus status = await Permission.locationWhenInUse.request();
  if (status == PermissionStatus.granted) {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      print('Latitude: ${position.latitude}, Longitude: ${position.longitude}');
    } catch (e) {
      print('Error getting location: $e');
    }
  } else {
    print('Location permission denied.');
  }
}
