import 'package:flutter/material.dart';

import '../../styles/responsive.dart';
import '../cart/addToCartIcon.dart';
import '../cart/removeFromCartIcon.dart';
import '../../styles/colors.dart';


class AddToCartBtn extends StatelessWidget {

  final int prodID;
  final int prodCartCount;
  bool isInCart;
  BuildContext screenContext;

  AddToCartBtn(this.screenContext ,this.isInCart,{
    @required this.prodID,
    @required this.prodCartCount,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(seconds: 2),
      width: responsive.responsiveWidth(context, prodCartCount==0 ? 0.10 :0.3),
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: appClrs.mainColor,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: prodCartCount==0 ?MainAxisSize.min :MainAxisSize.max,
        children: [

            AnimatedSwitcher(
                duration: Duration(seconds: 1),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return ScaleTransition(scale: animation, child: child);
                },
                child:prodCartCount!=0
                    ? AddToCartIcon(screenContext ,isInCart ,withBG: false ,prodID: prodID,)
                    : SizedBox()
            ),

            AnimatedSwitcher(
            duration: Duration(seconds: 1),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return ScaleTransition(scale: animation, child: child);
                },
                child:prodCartCount!=0
                    ? Text('$prodCartCount' ,style: TextStyle(fontSize: 20 ,fontFamily: appClrs.secondFontFamily ,color: Colors.white ,fontWeight: FontWeight.w600),)
                    : SizedBox()
            ),

          RemoveFromCartIcon(withBG: false,)


        ],
      ),
    );
  }
}
