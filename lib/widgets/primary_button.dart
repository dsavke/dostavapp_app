import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class PrimaryButton extends StatelessWidget {
  final String btnText;
  final Function btnHandler;
  final Color backgroundColor;
  final Color foregroundColor;
  final Border border;
  final List<BoxShadow> boxShadow;

  /// Creates a rectangle button with text.
  ///
  /// Default value for [backgroundColor] and [foregroundColor] is [Colors.white]
  /// The [btnText] argument must be not null and also not empty.
  PrimaryButton(
      {@required this.btnText,
      @required this.btnHandler,
      this.backgroundColor = Colors.white,
      this.border,
      this.boxShadow,
      this.foregroundColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: this.btnHandler,
      padding: const EdgeInsets.all(0.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      color: this.backgroundColor,
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          boxShadow: this.boxShadow ?? [],
          border: this.border ?? Border(),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Text(
            this.btnText,
            style: GoogleFonts.poppins(
              color: this.foregroundColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.25,
            ),
          ),
        ),
      ),
    );
  }
}
