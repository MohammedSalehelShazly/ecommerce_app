import 'staticVariables.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {

  TextEditingController controller;
  FormFieldValidator<String> validator;
  ValueChanged<String> onFieldSubmitted;
  TextInputAction textInputAction;
  String hintText;
  Widget prefixIcon;
  Widget suffixIcon;
  Color fillColor;
  TextInputType textInputType;
  bool obscureText;
  bool alwaysLeftDirection;
  int maxLines;
  bool enabled;
  FocusNode focusNode;
  bool autoFocus;

  AppTextField({
    @required this.controller,
    @required this.validator,
    this.onFieldSubmitted,
    this.textInputAction ,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.fillColor,
    this.textInputType,
    this.obscureText = false,
    this.alwaysLeftDirection =false,
    this.maxLines,
    this.enabled,
    this.focusNode,
    this.autoFocus =false
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textDirection: alwaysLeftDirection ?TextDirection.ltr :null,
      enabled: enabled,
      focusNode: focusNode,
      autofocus: autoFocus,

      validator: validator,
      onFieldSubmitted: onFieldSubmitted,
      keyboardType: textInputType ??TextInputType.name,
      obscureText: obscureText,
      textInputAction: textInputAction,
      maxLines: maxLines ??1,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 0 ,horizontal: 5),
        hintText: hintText,
        hintTextDirection: alwaysLeftDirection ?TextDirection.ltr :null,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: fillColor ??Colors.white,
        border: OutlineInputBorder(
          borderRadius: staticVars.borderRadius,
          borderSide: BorderSide()
        ),
      ),
    );
  }
}
