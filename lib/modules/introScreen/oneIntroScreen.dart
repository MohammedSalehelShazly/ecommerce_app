import '../../shared/styles/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OneIntroScreen extends StatelessWidget {

  String img;
  String txt;
  BuildContext sContext;
  OneIntroScreen({
    @required this.sContext,
    @required this.img,
    @required this.txt,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SvgPicture.asset(img,)),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10,0,10,20),
          child: Text(txt ,style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 20),textAlign: TextAlign.center,),
        ),
      ],
    );
  }
}
