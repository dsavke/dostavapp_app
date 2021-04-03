import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import './dialog_button.dart';

import '../repositories/request_respository.dart';

import '../models/supplier.dart';
import '../models/request.dart';

import '../utils/ui/colors.dart';

class DialogCard extends StatelessWidget {
  final Request request;
  final Supplier supplier;

  const DialogCard({this.request, this.supplier});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: Color.fromRGBO(204, 204, 204, 1.0),
          style: BorderStyle.solid,
          width: 1,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 10,
            left: 10,
            right: 10,
            child: Text(
              this.supplier != null
                  ? '${this.request.userName} poslao Vam je zahtjev!'
                  : '${this.request.supplierName} je ${this.request.status == 1 ? 'prihvatio' : 'odbio'} vas zahtjev!',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: AppColors.lightBlack,
                fontSize: 16,
                letterSpacing: 1.11,
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            right: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (request.status == 2 || request.status == 0)
                  DialogButton(
                    iconData: Icons.close,
                    btnHandler: () {
                      RequestRepository()
                          .changeStatus(this.request.requestId, 0);
                    },
                    isSelected: request.status == 0,
                    isDisabled: supplier == null || request.status != 2,
                  ),
                if (request.status == 2)
                  SizedBox(
                    width: 20,
                  ),
                if (request.status == 2 || request.status == 1)
                  DialogButton(
                    iconData: Icons.check,
                    btnHandler: () {
                      RequestRepository()
                          .changeStatus(this.request.requestId, 1);
                    },
                    isSelected: request.status == 1,
                    isDisabled: supplier == null || request.status != 2,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
