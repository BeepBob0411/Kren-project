import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:location/location.dart' as location;
import 'package:permission_handler/permission_handler.dart';

Future<void> getLocation() async {
  final location.Location locationService = location.Location(); // Instantiate locationService

  var status = await Permission.location.request();

  if (status == PermissionStatus.granted) {
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
        // Use the address value according to your needs.
      }
    } catch (e) {
      print('Error getting location: $e');
    }
  } else {
    print('Location permission denied.');
  }
}
