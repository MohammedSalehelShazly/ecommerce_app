import '../styles/responsive.dart';
import 'staticVariables.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {

  Function onPressed;
  Widget content;
  Color clr;
  double width;
  double height;

  AppButton({
    @required this.content,
    @required this.onPressed,
    this.clr,
    this.width,
    this.height

  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: content,
      color: clr ??Colors.white,
      minWidth: width ??responsive.sWidth(context),
      height: height ??responsive.responsiveHigh(context, 0.07),
      shape: RoundedRectangleBorder(
        borderRadius: staticVars.borderRadius
      ),
    );
  }
}
