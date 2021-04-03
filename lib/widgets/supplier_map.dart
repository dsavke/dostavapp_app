import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import './supplier_info_modal.dart';

import '../providers/location_provider.dart';
import '../providers/supplier_provider.dart';

import '../models/supplier.dart';
import '../models/location.dart';

import '../utils/ui/images.dart';
import '../utils/helpers/marker_icon.dart';

class SupplierMap extends StatefulWidget {
  final DataSnapshot snapshot;

  SupplierMap(this.snapshot);

  @override
  _SupplierMapState createState() => _SupplierMapState();
}

class _SupplierMapState extends State<SupplierMap> {
  GoogleMapController mapController;

  Marker _currentLocation;

  Set<Marker> _markers = Set<Marker>();

  BitmapDescriptor personPinCircleIcon;

  @override
  void initState() {
    if (this.widget.snapshot != null)
      Future.delayed(Duration.zero, () async {
        personPinCircleIcon = await MarkerIcon()
            .bitmapDescriptorFromSvgAsset(context, Images.person_pin_circle);

        this._showMarkers(context);
      });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<LocationProvider>(context, listen: false)
        .addListener(this._updateCamera);

    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: const LatLng(44.7783621, 17.1863173),
        zoom: 11.0,
      ),
      mapType: MapType.normal,
      myLocationEnabled: false,
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
      mapToolbarEnabled: false,
      markers: _markers,
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _updateCamera() async {
    if (context == null) return;

    LatLng cameraLatLng =
        Provider.of<LocationProvider>(context, listen: false).location;

    _currentLocation = Marker(
      markerId: MarkerId('currentLocation'),
      position: cameraLatLng,
    );

    setState(() {
      _markers.add(_currentLocation);
    });

    mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: cameraLatLng, zoom: 17)));

    Supplier supplier =
        Provider.of<SupplierProvider>(context, listen: false).supplier;

    if (supplier != null) {
      await Provider.of<SupplierProvider>(context, listen: false)
          .changeLocation(Location(
        latitude: cameraLatLng.latitude,
        longitude: cameraLatLng.longitude,
      ));
    }
  }

  void _showMarkers(BuildContext context) async {
    List<Marker> markers = <Marker>[];

    if (widget.snapshot.value == null) return;

    final Map<String, dynamic> data =
        new Map<String, dynamic>.from(widget.snapshot.value);

    data.forEach((String key, value) {
      Supplier newSupplier = Supplier.fromJson(value);
      newSupplier.supplierId = key;

      final Marker marker = this._createSupplierMarker(newSupplier);

      markers.add(marker);
    });

    setState(() {
      _markers = markers.toSet();
    });
  }

  Marker _createSupplierMarker(Supplier supplier) {
    return Marker(
      markerId: MarkerId(supplier.supplierId),
      position: supplier.location != null
          ? LatLng(
              supplier.location.latitude,
              supplier.location.longitude,
            )
          : LatLng(0, 0),
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext ctx) => SupplierInfoModal(supplier: supplier),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.0),
              topRight: Radius.circular(24.0),
            ),
          ),
          elevation: 2.0,
        );
      },
      icon: personPinCircleIcon,
    );
  }
}
