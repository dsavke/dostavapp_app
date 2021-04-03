import 'package:flutter/material.dart';

import 'package:firebase_database/firebase_database.dart';

import './dialog_card.dart';

import '../repositories/request_respository.dart';

import '../models/supplier.dart';
import '../models/request.dart';

class RequestList extends StatelessWidget {
  final Supplier supplier;

  RequestList({this.supplier});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Event>(
        stream: this.supplier != null
            ? RequestRepository().getRequestsBySupplierId(supplier.supplierId)
            : RequestRepository().getRequests(),
        builder: (BuildContext ctx, snapshot) {
          if (snapshot.hasError || !snapshot.hasData) return Container();

          if (snapshot.data.snapshot.value == null) return Container();

          final Map<String, dynamic> data =
              new Map<String, dynamic>.from(snapshot.data.snapshot.value);

          List<Request> requests = [];

          data.forEach((String key, value) {
            Request request = Request.fromJson(value);
            request.requestId = key;

            if (!(supplier == null && request.status == 2))
              requests.add(request);
          });

          requests.sort((Request prev, Request next) =>
              next.status.compareTo(prev.status));

          return Container(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: requests.length,
              itemBuilder: (BuildContext ctx, int index) => Padding(
                padding: EdgeInsets.only(
                  left: 10.0,
                  right: (requests.length - 1 == index ? 10.0 : 0),
                ),
                child: DialogCard(request: requests[index], supplier: supplier),
              ),
            ),
          );
        });
  }
}
