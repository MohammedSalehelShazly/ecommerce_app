import '../../shared/styles/colors.dart';
import 'package:flutter/material.dart';

class DiscountCircle extends StatelessWidget {

  num discount;
  DiscountCircle(this.discount);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/boom.png')
        )
      ),
      child: Text('-$discount%' ,
          textDirection: TextDirection.ltr,
          style: TextStyle(
              fontSize: 16,
              fontFamily: appClrs.secondFontFamily ,fontWeight: FontWeight.w600))
    );
  }
}
