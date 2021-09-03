import 'package:ecommerce/shared/styles/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../cubit/categories/categoriesCubit.dart';
import '../../cubit/categories/categoriesStates.dart';
import '../../cubit/favoritesCubit/favoritesStates.dart';
import '../../shared/components/appDialog.dart';
import '../../shared/components/loading/appProgress.dart';
import '../../shared/localization/language_constants.dart';
import '../../shared/styles/colors.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_button/like_button.dart';

class FavoriteIcon extends StatelessWidget {
  BuildContext screenCtx;
  bool isFav;
  bool withBG;
  int prodID;
  FavoriteIcon(this.screenCtx,{
    @required this.isFav,
    @required this.prodID,
    this.withBG =true,
  });
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoriesCubit ,CategoriesStates>(
      listener: (context ,state){},
      builder:(context ,state)=> Container(
        padding: EdgeInsets.all(8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle ,
          color: withBG ?appClrs.scaffoldBackgroundColorDark :Colors.transparent,),
          child:
          state is FavAddRemoveLoadingStates
              ? AppProgress()
              :
          LikeButton(
            size: responsive.textScale(context)*22,
            circleColor: CircleColor(start: appClrs.mainColor.withOpacity(0.8), end: appClrs.mainColor),
            onTap: (val) async{
              CategoriesCubit.of(context).addRemoveFav(context, prodID);
              return true;
            },
            bubblesColor: BubblesColor(
              dotPrimaryColor: Colors.red.withOpacity(0.8),
              dotSecondaryColor: Colors.red,
            ),
            likeBuilder: (bool isLiked) {
              return Icon(
                CategoriesCubit.of(context).isFavProdList.containsKey(prodID)
                    ? Icons.favorite :Icons.favorite_outline,
                color: CategoriesCubit.of(context).isFavProdList.containsKey(prodID)
                    ? Colors.red : Colors.white,
                //size: buttonSize,
              );
            },
          )

          //Icon(Icons.favorite, color: Colors.white ),


      ),
    );
  }
}