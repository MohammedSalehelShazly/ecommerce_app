import 'package:flutter/material.dart';

import '../../shared/localization/language_constants.dart';
import '../../shared/styles/colors.dart';

class DiscountRectangle extends StatelessWidget {
  num discount;
  DiscountRectangle(this.discount);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      padding: const EdgeInsets.all(2),
      margin: const EdgeInsets.symmetric(horizontal: 3),
      child: Text(
          getTranslated(context, 'Discount')+' '+'$discount%' ,
          style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontFamily: appClrs.secondFontFamily ,fontWeight: FontWeight.w600))
    );
  }
}
