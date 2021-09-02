import '../../shared/localization/language_constants.dart';
import '../../shared/styles/colors.dart';
import 'package:flutter/material.dart';

class PriceTxt extends StatelessWidget {

  PriceTxt({
    @required this.price,
    @required this.isOldPrice
  });
  num price;
  bool isOldPrice;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(price.toInt().toString(), textAlign: TextAlign.start,
          maxLines: 1,
          style: TextStyle(
              fontSize: isOldPrice ? 18 :20,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.3,
              decoration: isOldPrice? TextDecoration.lineThrough :null,
              color: isOldPrice? Colors.grey :appClrs.mainColor),),
        const SizedBox(width: 5,),
        Text(getTranslated(context, 'EGP')),
      ],
    );
  }
}
