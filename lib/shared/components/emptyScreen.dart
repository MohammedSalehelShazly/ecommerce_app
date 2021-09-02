import '../../shared/styles/responsive.dart';
import '../../shared/localization/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      //mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 50,),
        Container(
          alignment: Alignment.center,
          width: responsive.sWidth(context)*0.8,
          height: responsive.sWidth(context)*0.8,
          child: SvgPicture.asset('assets/images/empty.svg'),
        ),
        SizedBox(height: 20,),
        Text(getTranslated(context, 'Not found items yet..') ,style: TextStyle(fontSize: responsive.textScale(context)*20, fontWeight: FontWeight.bold),)
      ],
    );
  }
}
