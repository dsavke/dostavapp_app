import 'package:flutter/foundation.dart';

import '../repositories/supplier_repository.dart';

import '../models/supplier.dart';
import '../models/location.dart';

class SupplierProvider with ChangeNotifier {
  SupplierRepository _supplierRepository = SupplierRepository();

  Supplier supplier;

  ///This [method] creats a new supplier and notify all listeners.
  ///
  ///The [supplier] argument must be not null.
  ///The return value is [bool] and represent if adding supplier went success.
  Future<bool> addSupplier(Supplier supplier) async {
    bool successed = false;

    String key = await _supplierRepository.addSupplier(supplier);

    if (key != null) {
      supplier = Supplier(
        supplierId: key,
        firstName: supplier.firstName,
        lastName: supplier.lastName,
        phoneNumber: supplier.phoneNumber,
        available: supplier.available,
        location: supplier.location,
      );
      this.supplier = supplier;

      successed = true;
      notifyListeners();
    }

    return successed;
  }

  ///This [method] changes property [available] of registered supplier
  ///and notify all listeners.
  ///
  ///The [available] argument must be not null.
  Future<void> changeAvailability(bool available) async {
    await _supplierRepository.changeAvailability(
        this.supplier.supplierId, available);

    this.supplier = Supplier(
      supplierId: this.supplier.supplierId,
      firstName: this.supplier.firstName,
      lastName: this.supplier.lastName,
      phoneNumber: this.supplier.phoneNumber,
      available: available,
      location: this.supplier.location,
    );

    notifyListeners();
  }

  ///This [method] changes property [location] of registered supplier
  ///and notify all listeners.
  ///
  ///The [location] argument must be not null.
  Future<void> changeLocation(Location location) async {
    await _supplierRepository.changeLocation(
        this.supplier.supplierId, location);

    this.supplier = Supplier(
      supplierId: this.supplier.supplierId,
      firstName: this.supplier.firstName,
      lastName: this.supplier.lastName,
      phoneNumber: this.supplier.phoneNumber,
      available: this.supplier.available,
      location: location,
    );

    notifyListeners();
  }
}
