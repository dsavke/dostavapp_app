import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'find_supplier.dart';

import '../widgets/primary_button.dart';
import '../widgets/text_input.dart';

import '../providers/supplier_provider.dart';

import '../models/location.dart';
import '../models/supplier.dart';

import '../utils/ui/colors.dart';
import '../utils/ui/images.dart';

class RegisterSupplierManScreen extends StatelessWidget {
  static const routeName = '/registerDeliveryMan';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.red,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.4,
              child: Center(
                child: SvgPicture.asset(Images.logo_white),
              ),
            ),
            Container(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height * 0.6,
                minWidth: double.infinity,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
              child: Stack(
                children: [
                  _RegisterSupplierManForm(),
                  Positioned(
                    bottom: 31,
                    left: 0,
                    right: 0,
                    child: Text(
                      'Više informacija o aplikaciji',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: AppColors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RegisterSupplierManForm extends StatefulWidget {
  @override
  __RegisterSupplierManFormState createState() =>
      __RegisterSupplierManFormState();
}

class __RegisterSupplierManFormState extends State<_RegisterSupplierManForm> {
  final TextEditingController _firstNameEditingController =
      TextEditingController();

  final TextEditingController _lastNameEditingController =
      TextEditingController();

  final TextEditingController _phoneNumberEditingController =
      TextEditingController();

  @override
  void dispose() {
    _firstNameEditingController.dispose();
    _lastNameEditingController.dispose();
    _phoneNumberEditingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 48,
        ),
        TextInput(
          controller: _firstNameEditingController,
          hintText: 'Ime',
          textInputType: TextInputType.text,
        ),
        SizedBox(
          height: 24.0,
        ),
        TextInput(
          controller: _lastNameEditingController,
          hintText: 'Prezime',
          textInputType: TextInputType.text,
        ),
        SizedBox(
          height: 24.0,
        ),
        TextInput(
          controller: _phoneNumberEditingController,
          hintText: 'Broj telefona',
          textInputType: TextInputType.phone,
        ),
        SizedBox(
          height: 40.0,
        ),
        PrimaryButton(
          btnText: 'Registruj se',
          btnHandler: () async {
            await _registerDeliveryMan(context);
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
      ],
    );
  }

  Future<void> _registerDeliveryMan(context) async {
    Supplier supplier = Supplier(
      firstName: _firstNameEditingController.text,
      lastName: _lastNameEditingController.text,
      phoneNumber: _phoneNumberEditingController.text,
      available: false,
      location: Location(latitude: 44.7783621, longitude: 17.1863173),
    );

    bool successed = await Provider.of<SupplierProvider>(context, listen: false)
        .addSupplier(supplier);

    if (successed) {
      Navigator.pushReplacementNamed(context, FindSupplierScreen.routeName);
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Doslo je do greske!'),
      ));
    }
  }
}
