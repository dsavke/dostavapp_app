import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

import './primary_button.dart';

import '../repositories/request_respository.dart';

import '../models/supplier.dart';
import '../models/request.dart';

import '../utils/ui/colors.dart';
import '../utils/ui/images.dart';

class SupplierInfoModal extends StatelessWidget {
  final Supplier supplier;

  const SupplierInfoModal({
    Key key,
    this.supplier,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      width: double.infinity,
      height: 350,
      child: Column(
        children: [
          SizedBox(
            height: 48,
          ),
          Text(
            'Informacije o dostavljacu',
            style: GoogleFonts.poppins(
              color: AppColors.modalDarkBlack,
              fontSize: 21,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.66,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: SvgPicture.asset(Images.account_circle),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(
                  'Ime i prezime',
                  style: GoogleFonts.poppins(
                    color: AppColors.modalDarkBlack,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.67,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '${supplier.firstName} ${supplier.lastName}',
              textAlign: TextAlign.left,
              style: GoogleFonts.poppins(
                color: AppColors.modalLightBlack,
                fontSize: 16,
                letterSpacing: 0.67,
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: SvgPicture.asset(Images.phone),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(
                  'Kontakt',
                  style: GoogleFonts.poppins(
                    color: AppColors.modalDarkBlack,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.67,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '${supplier.phoneNumber}',
              textAlign: TextAlign.left,
              style: GoogleFonts.poppins(
                color: AppColors.modalLightBlack,
                fontSize: 16,
                letterSpacing: 0.67,
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          PrimaryButton(
            btnText: 'Posalji zahtjev',
            btnHandler: () async {
              Request request = Request(
                supplierId: supplier.supplierId,
                supplierName: '${supplier.firstName} ${supplier.lastName}',
                userName: 'Korisnik Korisnik',
                status: 2,
              );

              String key = await RequestRepository().addRequest(request);

              if (key != null) {
                Navigator.of(context).pop();
              } else {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('Doslo je do greske!'),
                ));
              }
            },
            border: Border.all(color: AppColors.red, width: 1),
            foregroundColor: AppColors.red,
          ),
        ],
      ),
    );
  }
}
