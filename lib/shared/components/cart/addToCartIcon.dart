import 'package:flutter/material.dart';

import 'package:like_button/like_button.dart';

import '../../../shared/styles/responsive.dart';
import '../../../cubit/cartCubit/cartCubit.dart';
import '../../../cubit/cartCubit/cartStates.dart';
import '../../../shared/styles/colors.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class AddToCartIcon extends StatelessWidget {
  Color clr;
  bool withBG;
  bool isInCart;
  int prodID;
  BuildContext screenContext;
  AddToCartIcon(this.screenContext ,this.isInCart ,{@required this.prodID ,this.clr = Colors.white, this.withBG = true});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit ,CartStates>(
      listener:(context ,state){},
      builder:(context ,state)=> Container(
        padding: EdgeInsets.all(withBG ? 8 :0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle ,
          color: withBG ?appClrs.scaffoldBackgroundColorDark :Colors.transparent,),
        child:
        LikeButton(
          size: responsive.textScale(context)*22,
          circleColor: CircleColor(start: appClrs.mainColor.withOpacity(0.8), end: appClrs.mainColor),
          onTap: (val) async{
            CartCubit.of(context).addOrRemove(screenContext, prodID);
            return true;
          },
          bubblesColor: BubblesColor(
            dotPrimaryColor: appClrs.mainColor.withOpacity(0.8),
            dotSecondaryColor: appClrs.mainColor,
          ),
          likeBuilder: (bool isLiked) {
            return Icon(
              CartCubit.of(context).prodsInCartIDList.contains(prodID)
                  ? Icons.shopping_cart :Icons.shopping_cart_outlined,
              color: CartCubit.of(context).prodsInCartIDList.contains(prodID)
                  ? appClrs.mainColor :clr,
              //size: buttonSize,
            );
          },
        )


      ),
    );
  }
}
