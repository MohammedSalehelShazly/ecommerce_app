import 'package:flutter/material.dart';

import '../../cubit/cartCubit/cartCubit.dart';
import '../../cubit/cartCubit/cartStates.dart';
import '../../cubit/categories/categoriesCubit.dart';
import '../../cubit/categories/categoriesStates.dart';

import 'package:badges/badges.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBadge extends StatelessWidget {

  Icon child;
  AppBadge({@required this.child});


  bool hasBadge()=>
    child.icon == Icons.favorite_outline || child.icon == Icons.shopping_cart_outlined;

  int badgeCount(BuildContext context)=>
      child.icon == Icons.favorite_outline && CategoriesCubit.of(context).isFavProdList !=null
          ? CategoriesCubit.of(context).isFavProdList.length
          :
      child.icon == Icons.shopping_cart_outlined && CartCubit.of(context).allCartProdsModel!=null
          ? CartCubit.of(context).allCartProdsModel.data.cart_items.length
          : 0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit ,CartStates>(
      listener: (context ,state){},
      builder:(context ,state)=> BlocConsumer<CategoriesCubit ,CategoriesStates>(
        listener: (context ,state){},
        builder:(context ,state)=> Directionality(
          textDirection: TextDirection.rtl,
          child: Badge(
            child: child,
            showBadge: hasBadge() && badgeCount(context) != 0,
            animationType: BadgeAnimationType.scale,
            padding: const EdgeInsets.all(5),
            badgeContent: Text(
              badgeCount(context).toString(),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
              textAlign: TextAlign.start,
            ),
            position: BadgePosition.bottomStart(),
          ),
        ),
      ),
    );
  }
}
