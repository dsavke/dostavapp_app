import 'package:flutter/foundation.dart';

class Location {
  final double latitude;
  final double longitude;

  Location({
    @required this.latitude,
    @required this.longitude,
  });

  factory Location.fromJson(dynamic data) => Location(
        latitude: data['latitude'],
        longitude: data['longitude'],
      );

  Map<String, dynamic> toJson() => {
        'latitude': this.latitude,
        'longitude': this.longitude,
      };
}
