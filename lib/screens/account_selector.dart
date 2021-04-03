import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'find_supplier.dart';
import 'register_supplier_man.dart';

import '../widgets/primary_button.dart';

import '../utils/ui/colors.dart';
import '../utils/ui/images.dart';

class AccountSelectorScreen extends StatelessWidget {
  static const routeName = '/accountSelector';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.red,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.3,
            child: Center(
              child: SvgPicture.asset(Images.logo_white),
            ),
          ),
          Container(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height * 0.7,
              minWidth: double.infinity,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24.00),
                topRight: Radius.circular(24.00),
              ),
              boxShadow: [
                BoxShadow(
                  blurRadius: 12.0,
                  spreadRadius: 0.0,
                  offset: Offset(0, -4),
                  color: AppColors.shadow1,
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Stack(
              fit: StackFit.passthrough,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      PrimaryButton(
                        btnText: 'Trebam dostavu',
                        btnHandler: () {
                          Navigator.pushNamed(
                              context, FindSupplierScreen.routeName);
                        },
                        backgroundColor: AppColors.red,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 12.0,
                            spreadRadius: 0.0,
                            offset: Offset(0, 4),
                            color: AppColors.shadow2,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 48,
                      ),
                      PrimaryButton(
                        btnText: 'Registruj se kao dostavljac',
                        btnHandler: () {
                          Navigator.pushNamed(
                              context, RegisterSupplierManScreen.routeName);
                        },
                        foregroundColor: AppColors.red,
                        border: Border.all(
                          color: AppColors.red,
                          style: BorderStyle.solid,
                          width: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 31),
                    child: Text(
                      'Više informacija o aplikaciji',
                      style: GoogleFonts.poppins(
                        color: AppColors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
