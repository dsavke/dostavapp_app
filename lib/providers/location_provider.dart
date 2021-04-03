import 'package:flutter/foundation.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationProvider with ChangeNotifier {
  LatLng _location = LatLng(0.0, 0.0);

  LatLng get location {
    return _location;
  }

  set location(LatLng newLocation) {
    if (_location.latitude != newLocation.latitude ||
        _location.longitude != newLocation.longitude) {
      _location = newLocation;
      print('pozvan notifyListener kod lokacije');
      notifyListeners();
    }
  }
}
