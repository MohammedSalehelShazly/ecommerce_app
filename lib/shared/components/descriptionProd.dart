import '../../shared/styles/responsive.dart';
import '../../shared/localization/language_constants.dart';
import '../../shared/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DescriptionProd extends StatelessWidget {

  String description;
  DescriptionProd(this.description);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20 ,horizontal: responsive.sWidth(context)*0.05),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white70,
        border: Border.all()
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          SizedBox(height: 15,),
          Text(getTranslated(context, 'Details') ,style: TextStyle(
              fontSize: responsive.textScale(context)*17,
              fontWeight: FontWeight.bold),),
          SizedBox(height: 15,),

          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: appClrs.mainColor.withOpacity(0.8),
            ),
            padding: const EdgeInsets.all(12),
            width: responsive.sWidth(context)*0.9,
            child: Text(description ,
              textAlign: TextAlign.justify,
              style: TextStyle(
                color: Colors.black87,
                fontSize: responsive.textScale(context)*17,
                fontWeight: FontWeight.w400 ,
                fontFamily: appClrs.secondFontFamily,
            ),),
          ),
        ],
      ),
    );
  }
}
