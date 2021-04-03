import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import './providers/supplier_provider.dart';
import './providers/location_provider.dart';

import './utils/config/routes.dart';

void main() {
  runApp(DeliveryApp());
}

class DeliveryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: SupplierProvider(),
        ),
        ChangeNotifierProvider.value(
          value: LocationProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Dostava',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: AppRoutes().routes,
        initialRoute: AppRoutes.initialRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
