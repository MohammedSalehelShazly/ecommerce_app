import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/categories/categoriesCubit.dart';
import '../../cubit/categories/categoriesStates.dart';
import '../../shared/styles/responsive.dart';
import '../../models/CategoriesModels/oneCategoryModel.dart';
import '../../shared/components/cart/addToCartIcon.dart';
import '../../shared/components/discountRectangle.dart';
import '../../shared/components/descriptionProd.dart';
import '../../shared/components/favoriteIcon.dart';
import '../../shared/components/imageView/imageSliderView.dart';
import '../../shared/components/priceTxt.dart';

class ProductScreen extends StatelessWidget {
  Product product;
  ProductScreen(this.product);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: BlocConsumer<CategoriesCubit ,CategoriesStates>(
      listener: (context ,state){},
      builder: (context ,state)=>  WillPopScope(
        onWillPop: ()async{
          await CategoriesCubit.of(context).setCurrentCatImg(0);
          return true;
        },
        child: Scaffold(

          appBar: AppBar(title: Text(product.name),),

          body: ListView(children: [

            Container(
              // because aspect ratio of CarouselOptions is--> 16:9
              height: responsive.sWidth(context) *(9/16),
              child: Stack(
                children: [
                  ImageSlider(product.images),

                  Align(
                    alignment: Alignment.bottomRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [

                        Container(
                          //width: responsive.sWidth(context)*0.2,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              FavoriteIcon(
                                context,
                                isFav: product.in_favorites,
                                prodID: product.id,
                              ),
                              //Icon(Icons.add_shopping_cart_outlined),
                              SizedBox(height: 5,),
                              //Icon(Icons.add_shopping_cart_outlined),
                              AddToCartIcon(context ,product.in_cart ,prodID: product.id,),
                            ],
                          ),
                        ),
                        const SizedBox()
                      ],
                    ),
                  )
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(product.name ,style: TextStyle(
                fontSize: responsive.textScale(context)*16,
                fontWeight: FontWeight.w700
              ),),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(8,10,8,0),
                child: PriceTxt(price: product.price, isOldPrice: false)
            ),

            if(product.price != product.old_price)
              Padding(
                padding: const EdgeInsets.fromLTRB(8,3,8,8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PriceTxt(price: product.old_price, isOldPrice: true),

                      DiscountRectangle(product.discount),
                  ],
                )
              ),

            Divider(indent: 20,endIndent: 20,thickness: 3,),

            DescriptionProd(product.description),
            Divider(indent: 20,endIndent: 20,thickness: 2,),



          ],),
        ),
      ),
    ));
  }
}
