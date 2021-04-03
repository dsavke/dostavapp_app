import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_svg/flutter_svg.dart';

import './request_list.dart';
import './search_bar.dart';

import '../providers/location_provider.dart';

import '../models/supplier.dart';

import '../utils/ui/colors.dart';
import '../utils/ui/images.dart';

class MapNavigation extends StatefulWidget {
  final Supplier supplier;

  MapNavigation({this.supplier});

  @override
  _MapNavigationState createState() => _MapNavigationState();
}

class _MapNavigationState extends State<MapNavigation> {
  bool isRequestListShowed = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (this.isRequestListShowed)
          Positioned(
            top: 10,
            right: 0,
            left: 0,
            child: RequestList(
              supplier: this.widget.supplier,
            ),
          ),
        if (this.widget.supplier != null)
          Positioned(
            bottom: 24,
            left: 0,
            right: 0,
            child: SearchBar(),
          ),
        Positioned(
          right: 16,
          bottom: this.widget.supplier != null ? 104 : 16,
          child: FloatingActionButton(
            heroTag: 'btnLocation',
            onPressed: () => this._getCurrentPosition(context),
            child: SvgPicture.asset(Images.my_location),
            backgroundColor: Colors.white,
            elevation: 2.0,
          ),
        ),
        Positioned(
          left: 16,
          bottom: this.widget.supplier != null ? 104 : 16,
          child: FloatingActionButton(
            heroTag: 'btnSupplierRequests',
            onPressed: () {
              setState(() {
                isRequestListShowed = !isRequestListShowed;
              });
            },
            child: Icon(
              isRequestListShowed == true ? Icons.close : Icons.assignment,
              color: AppColors.red,
            ),
            backgroundColor: Colors.white,
            elevation: 2.0,
          ),
        ),
      ],
    );
  }

  void _getCurrentPosition(BuildContext context) async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    Provider.of<LocationProvider>(context, listen: false).location =
        LatLng(position.latitude, position.longitude);
  }
}
