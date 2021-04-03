import 'package:flutter/foundation.dart';

import './location.dart';

class Supplier {
  static const documentName = 'suppliers';

  String supplierId;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final bool available;
  final Location location;

  Supplier({
    this.supplierId,
    @required this.firstName,
    @required this.lastName,
    @required this.phoneNumber,
    @required this.available,
    @required this.location,
  });

  factory Supplier.fromJson(dynamic data) => Supplier(
        firstName: data['firstName'],
        lastName: data['lastName'],
        phoneNumber: data['phoneNumber'],
        available: data['available'],
        location: data['location'] == null
            ? null
            : Location.fromJson(data['location']),
      );

  Map<String, dynamic> toJson() => {
        'firstName': this.firstName,
        'lastName': this.lastName,
        'phoneNumber': this.phoneNumber,
        'available': this.available,
        'location': this.location.toJson(),
      };
}
