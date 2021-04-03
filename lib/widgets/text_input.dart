import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import '../utils/ui/colors.dart';

class TextInput extends StatelessWidget {
  final String hintText;
  final TextInputType textInputType;
  final TextEditingController controller;

  /// Creates a rectangle text input control.
  ///
  /// The [controller] argument must be not null.
  TextInput({
    this.hintText = '',
    @required this.textInputType,
    @required this.controller,
  });

  final TextStyle _textStyle = GoogleFonts.poppins(
    color: AppColors.lightBlack,
    fontSize: 16,
    letterSpacing: 1.11,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 24.0, right: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: Color.fromRGBO(204, 204, 204, 1.0),
          style: BorderStyle.solid,
          width: 1,
        ),
      ),
      height: 57.0,
      child: TextField(
        controller: controller,
        keyboardType: this.textInputType,
        style: _textStyle,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: this.hintText,
          hintStyle: _textStyle,
        ),
        textInputAction: TextInputAction.next,
      ),
    );
  }
}
