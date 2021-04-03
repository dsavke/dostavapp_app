import 'package:flutter/foundation.dart';

class Request {
  static const documentName = 'requests';

  String requestId;
  final String supplierId;
  final String userName;
  final String supplierName;
  final int status;

  Request({
    this.requestId,
    @required this.supplierId,
    @required this.supplierName,
    @required this.userName,
    @required this.status,
  });

  factory Request.fromJson(dynamic data) => Request(
        supplierId: data['supplierId'],
        supplierName: data['supplierName'],
        userName: data['userName'],
        status: data['status'],
      );

  Map<String, dynamic> toJson() => {
        'supplierId': this.supplierId,
        'supplierName': this.supplierName,
        'userName': this.userName,
        'status': this.status,
      };
}
