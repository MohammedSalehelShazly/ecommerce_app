import '../../cubit/categories/categoriesCubit.dart';
import '../../cubit/categories/categoriesStates.dart';
import '../../shared/styles/responsive.dart';
import '../../shared/components/loading/appProgress.dart';
import '../../shared/components/emptyScreen.dart';
import '../../shared/components/productItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OneCategoryScreen extends StatelessWidget {

  int catID;
  String catName;
  OneCategoryScreen({
    @required this.catID,
    @required this.catName,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: BlocConsumer<CategoriesCubit ,CategoriesStates>(
        listener: (context ,state){},
        builder:(context ,state){

          /// get product again after add to favorites
          if(CategoriesCubit.of(context).allCategories[catID] == null){
            CategoriesCubit.of(context).getOneCategoryProds(context, catID);
          }

          return Scaffold(
            appBar: AppBar(
              title: Text(catName.toString()),
              centerTitle: true,
            ),
            body: RefreshIndicator(
              onRefresh: () async{
                await CategoriesCubit.of(context).oneCategoryClearState(catID);
              },
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 400),

                child: CategoriesCubit.of(context).allCategories[catID] == null ||
                    state is OneCategoryGetLoadingState

                    ? AppProgress(isList: true,listCount: 6,)
                    :
                CategoriesCubit.of(context).allCategories[catID].data.data.isEmpty
                    ? Center(child: EmptyScreen())
                    : ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: CategoriesCubit.of(context).allCategories[catID].data.data.length,
                      itemExtent: responsive.responsiveHigh(context, 0.17),
                      itemBuilder: (context ,index)=>
                          ProductItem(
                            context,
                            CategoriesCubit.of(context)
                                .allCategories[catID].data.data[index],
                          ),
                    ),
              ),
            )
          );
        }));
  }
}



















