import '../../cubit/cartCubit/cartCubit.dart';
import '../../cubit/categories/categoriesCubit.dart';
import '../../cubit/categories/categoriesStates.dart';
import '../../shared/styles/responsive.dart';
import '../../shared/localization/language_constants.dart';
import '../../models/CategoriesModels/categoriesModel.dart';
import '../../shared/components/categoryItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'loading/appProgress.dart';

class CategoriesGrid extends StatelessWidget {
  const CategoriesGrid();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoriesCubit ,CategoriesStates>(
        listener: (context ,catState){},
        builder: (context ,catState){

          return
            (CategoriesCubit.of(context).categoriesModel == null)
                ? Container(height: responsive.sHeight(context)*0.25,child: AppProgress(isList: false,listCount: 3,))
                :
            AnimatedContainer(
              duration: Duration(milliseconds: 700),
              margin: const EdgeInsets.all(15),
                  height: !CategoriesCubit.of(context).showAllCat || CategoriesCubit.of(context).categoriesModel == null
                      ? responsive.responsiveHigh(context, 0.25)
                      : responsive.responsiveHigh(context, 0.25) * ((CategoriesCubit.of(context).categoriesModel.data.data.length/3).ceil()),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextButton(
                          onPressed: ()=> CategoriesCubit.of(context).reverseShowAllCat(),
                          child: Text(
                              CategoriesCubit.of(context).showAllCat
                                  ? getTranslated(context, 'Show less')
                                  : getTranslated(context, 'Show all'))),

                      Expanded(
                        child: GridView.builder(
                          scrollDirection: Axis.vertical,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            childAspectRatio: 2/3,
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 5,
                            maxCrossAxisExtent: responsive.responsiveWidth(context, 0.3),
                            mainAxisExtent: responsive.responsiveHigh(context, 0.2)
                          ),
                          itemCount:
                              CategoriesCubit.of(context).categoriesModel.data.data.length ,
                          itemBuilder: (context ,index)=> CategoryItem(
                              catID: CategoriesCubit.of(context).categoriesModel.data.data[index].id,
                              catName: CategoriesCubit.of(context).categoriesModel.data.data[index].name,
                              image: CategoriesCubit.of(context).categoriesModel.data.data[index].image),
                        )
                      ),
                    ],
                  ),
                );
        });
  }
}
