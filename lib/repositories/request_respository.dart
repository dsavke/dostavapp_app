import 'package:firebase_database/firebase_database.dart';

import '../models/request.dart';

class RequestRepository {
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  ///This [method] creats a new request.
  ///
  ///The [request] argument must be not null.
  ///The return value is key of new added supplier and is type of [String].
  ///If the return value is [null] then request isn't added.
  Future<String> addRequest(Request request) async {
    String key;

    try {
      DatabaseReference requestRef =
          _database.reference().child(Request.documentName).push();

      await requestRef.set(request.toJson());

      key = requestRef.key;
    } catch (error) {
      print(error);
    }

    return key;
  }

  ///This [method] return [Stream<Event>] of [Request] of targeted [supplierId].
  Stream<Event> getRequestsBySupplierId(String supplierId) {
    return _database
        .reference()
        .child(Request.documentName)
        .orderByChild('supplierId')
        .equalTo(supplierId)
        .onValue;
  }

  ///This [method] return [Stream<Event>] of [Request] for specific user.
  Stream<Event> getRequests() {
    return _database
        .reference()
        .child(Request.documentName)
        .orderByChild('status')
        .onValue;
  }

  ///This [method] changes property [status] of targeted request.
  ///
  ///The [id] and [status] arguments must be not null.
  Future<void> changeStatus(String id, int status) async {
    try {
      await _database
          .reference()
          .child(Request.documentName)
          .child(id)
          .update({'status': status});
    } catch (error) {
      print(error);
    }
  }
}
