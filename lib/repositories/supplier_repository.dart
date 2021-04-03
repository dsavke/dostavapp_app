import 'package:firebase_database/firebase_database.dart';

import '../models/supplier.dart';
import '../models/location.dart';

class SupplierRepository {
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  ///This [method] return [Stream<Event>] of all available suppliers.
  Stream<Event> getAvailableSuppliers() {
    return _database
        .reference()
        .child(Supplier.documentName)
        .orderByChild('available')
        .equalTo(true)
        .onValue;
  }

  ///This [method] creats a new supplier.
  ///
  ///The [supplier] argument must be not null.
  ///The return value is key of new added supplier and is type of [String].
  ///If the return value is [null] then supplier isn't added.
  Future<String> addSupplier(Supplier supplier) async {
    String key;

    try {
      DatabaseReference supplierRef =
          _database.reference().child(Supplier.documentName).push();

      await supplierRef.set(supplier.toJson());

      key = supplierRef.key;
    } catch (error) {
      print(error);
    }

    return key;
  }

  ///This [method] changes property [available] of targeted supplier.
  ///
  ///The [id] and [available] arguments must be not null.
  Future<void> changeAvailability(String id, bool available) async {
    try {
      await _database
          .reference()
          .child(Supplier.documentName)
          .child(id)
          .update({'available': available});
    } catch (error) {
      print(error);
    }
  }

  ///This [method] changes property [location] of targeted supplier.
  ///
  ///The [id] and [location] arguments must be not null.
  Future<void> changeLocation(String id, Location location) async {
    try {
      await _database
          .reference()
          .child(Supplier.documentName)
          .child(id)
          .update({'location': location.toJson()});
    } catch (error) {
      print(error);
    }
  }
}
