import 'package:flutter/material.dart';

import '../utils/ui/colors.dart';

class DialogButton extends StatelessWidget {
  final IconData iconData;
  final Function btnHandler;
  final bool isSelected;
  final bool isDisabled;

  const DialogButton({
    this.iconData,
    this.btnHandler,
    this.isSelected,
    this.isDisabled,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.lightBlack,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8.0),
        color: this.isSelected ? AppColors.red : Colors.white,
      ),
      child: IconButton(
        onPressed: this.isDisabled ? () {} : this.btnHandler,
        icon: Icon(this.iconData),
        color: this.isSelected ? Colors.white : AppColors.red,
      ),
    );
  }
}
