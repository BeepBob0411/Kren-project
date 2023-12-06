import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:location/location.dart' as location;

Future<void> getLocation() async {
  final location.Location locationService = location.Location();
  location.PermissionStatus status = await locationService.hasPermission();

  if (status == location.PermissionStatus.denied) {
    await locationService.requestPermission();
    status = await locationService.hasPermission();
  }

  if (status == location.PermissionStatus.granted) {
    try {
      location.LocationData userLocation = await locationService.getLocation();
      List<geocoding.Placemark> placemarks = await geocoding.placemarkFromCoordinates(
        userLocation.latitude!,
        userLocation.longitude!,
      );

      if (placemarks.isNotEmpty) {
        geocoding.Placemark place = placemarks[0];
        String address =
            "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";

        print('User Location: $address');
        // Gunakan nilai address sesuai kebutuhan Anda.
      }
    } catch (e) {
      print('Error getting location: $e');
    }
  } else {
    print('Location permission denied.');
  }
}
