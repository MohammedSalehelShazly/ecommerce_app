
import '../../cubit/categories/categoriesCubit.dart';
import '../../cubit/categories/categoriesStates.dart';
import '../../cubit/favoritesCubit/favoritesCubit.dart';
import '../../cubit/favoritesCubit/favoritesStates.dart';
import '../../shared/styles/responsive.dart';
import '../../models/favoritesModels/allFavoritesModel.dart';
import '../../shared/components/loading/appProgress.dart';
import '../../shared/components/productItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<CategoriesCubit ,CategoriesStates>(
        listener: (context ,state){},
        builder:(context ,state) {

          if(CategoriesCubit.of(context).isFavProdList.containsValue(null))
            CategoriesCubit.of(context).getFavProd(context);

          return Scaffold(
            body: AnimatedSwitcher(
              duration: Duration(milliseconds: 400),

              child: CategoriesCubit.of(context).isFavProdList.isEmpty
                  ? AppProgress(isList: true,listCount: 6,)
                  :
              ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: CategoriesCubit.of(context).isFavProdList.length,
                itemExtent: responsive.responsiveHigh(context, 0.17),
                itemBuilder: (context ,index)=>

                CategoriesCubit.of(context).isFavProdList.values.toList()[index] == null
                    ? AppProgress(isList: true,listCount: 1,)
                    :
                ProductItem(
                  context,
                  CategoriesCubit.of(context).isFavProdList.values.toList()[index],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
