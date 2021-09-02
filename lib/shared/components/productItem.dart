import 'package:cached_network_image/cached_network_image.dart';
import '../../shared/components/cart/addToCartIcon.dart';
import '../../shared/localization/language_constants.dart';
import 'package:flutter/material.dart';

import '../../modules/categoriesScreens/prouductScreen.dart';
import '../styles/responsive.dart';
import '../../models/CategoriesModels/oneCategoryModel.dart';
import '../../shared/components/discountCircle.dart';
import '../../shared/styles/colors.dart';
import 'cart/addToCartBtns.dart';
import 'favoriteIcon.dart';

class ProductItem extends StatelessWidget {

  BuildContext screenCtx;
  Product product;
  ProductItem(this.screenCtx ,this.product);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Card(
        elevation: 3,
        child: InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (_)=>ProductScreen(product)));
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.name.toString() ,textAlign: TextAlign.start,maxLines: 1,),
                      Row(
                        children: [
                          Text(getTranslated(context, 'EGP')),
                          SizedBox(width: 3,),
                          Text(product.price.toInt().toString(),
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            style: TextStyle(color: appClrs.mainColor,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.3
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          FavoriteIcon(
                            screenCtx,
                            isFav: product.in_favorites,
                            prodID: product.id,
                          ),
                          const SizedBox(width: 5,),
                          AddToCartIcon(screenCtx, product.in_cart, prodID: product.id)
                          //AddToCartBtn(screenCtx ,product.in_cart ,prodID: product.id,prodCartCount: 1,),
                        ],
                      )
                    ],
                  ),
                ),

                Stack(
                  alignment:Alignment.topLeft,
                  children: [
                    Container(
                      width: responsive.responsiveWidth(context, 0.3),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: CachedNetworkImageProvider(product.image),
                              fit: BoxFit.contain
                          )
                      ),
                    ),
                    if(product.discount !=0)
                      DiscountCircle(product.discount)
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
