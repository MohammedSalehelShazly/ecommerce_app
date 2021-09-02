import '../../../shared/styles/responsive.dart';
import 'package:flutter/material.dart';

class LoadingCntrItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: responsive.responsiveWidth(context, 0.3),
      width: responsive.responsiveWidth(context, 0.3),
      color: Colors.white,
    );
  }
}