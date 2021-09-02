import '../../../shared/styles/colors.dart';
import 'package:flutter/material.dart';

class RemoveFromCartIcon extends StatelessWidget {
  Color clr;
  bool withBG;
  RemoveFromCartIcon({this.clr = Colors.white, this.withBG = true});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.all(0),
        decoration: BoxDecoration(
          shape: BoxShape.circle ,
          color: withBG ?appClrs.scaffoldBackgroundColorDark :Colors.transparent,),
        child: Icon(
          Icons.add_shopping_cart_outlined,
          color: clr,
        ),
      ),
    );
  }
}
