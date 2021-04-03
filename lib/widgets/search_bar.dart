import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../providers/location_provider.dart';

import '../utils/ui/colors.dart';
import '../utils/ui/images.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _addressEditingController =
      TextEditingController();

  @override
  void dispose() {
    _addressEditingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(28)),
          boxShadow: [
            BoxShadow(
                blurRadius: 12,
                color: AppColors.shadow3,
                offset: Offset(0, 2),
                spreadRadius: 0),
          ]),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              controller: _addressEditingController,
              keyboardType: TextInputType.streetAddress,
              style: GoogleFonts.poppins(
                color: AppColors.lightBlack,
                fontSize: 16,
                letterSpacing: 1.11,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.only(
                  left: 24.0,
                  top: 0.0,
                  right: 24.0,
                ),
                hintText: 'Adresa za dostavu?',
                hintStyle: GoogleFonts.poppins(
                  color: AppColors.lightBlack,
                  fontSize: 16,
                  letterSpacing: 1.11,
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(right: 24.0),
            child: GestureDetector(
              child: SvgPicture.asset(Images.near_me),
              onTap: () => this._searchAddress(context),
            ),
          ),
        ],
      ),
    );
  }

  void _searchAddress(BuildContext context) async {
    List<Location> locations =
        await locationFromAddress(_addressEditingController.text);

    if (locations != null && locations.length > 0) {
      Provider.of<LocationProvider>(context, listen: false).location =
          LatLng(locations[0].latitude, locations[0].longitude);
    }
  }
}
