import '../../cubit/categories/categoriesCubit.dart';
import '../../cubit/categories/categoriesStates.dart';
import '../../shared/styles/responsive.dart';
import '../../shared/components/appTextField.dart';
import '../../shared/components/emptyScreen.dart';
import '../../shared/components/loading/appProgress.dart';
import '../../shared/components/productItem.dart';
import '../../shared/components/searchInitScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: BlocConsumer<CategoriesCubit ,CategoriesStates>(
      listener: (context ,state){},
      builder: (context ,state){

        CategoriesCubit.of(context).searchFocusNode.addListener(() {
          if(CategoriesCubit.of(context).searchFocusNode.hasFocus != CategoriesCubit.of(context).hasFocusSearch)
            CategoriesCubit.of(context).setHasFocusSearch(CategoriesCubit.of(context).searchFocusNode.hasFocus);
          //print('searchFocusNode.hasFocus ${CategoriesCubit.of(context).searchFocusNode.hasFocus}');
        });
        print('state $state');

        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(responsive.responsiveHigh(context, 0.075)),
            child: AppBar(
              title: Form(
                key: CategoriesCubit.of(context).searchFormKey,
                child: AppTextField(
                  controller: CategoriesCubit.of(context).searchController,
                  focusNode: CategoriesCubit.of(context).searchFocusNode,
                  autoFocus: true,
                  validator: (val){
                    if(val.trim().isNotEmpty)
                      return null;
                    else
                      return '';
                    },
                  textInputAction: TextInputAction.search,
                  onFieldSubmitted:(val) async{
                    if(CategoriesCubit.of(context).searchFormKey.currentState.validate()){
                      await CategoriesCubit.of(context).setSearchWords(val);
                      CategoriesCubit.of(context).searchFocusNode.unfocus();
                      await CategoriesCubit.of(context).getSearches(context, val);
                    }
                    },
                ),
              )
            ),
          ),
          body: AnimatedSwitcher(
            duration: Duration(milliseconds: 400),

            child:
                /// stat


            CategoriesCubit.of(context).hasFocusSearch
                ? SearchInitScreen()
                :
            state is OneCategoryGetLoadingState || state is SearchLoadingState || state is OneCategoryGetLoadingState || state is SetSearchControllerState || state is GetSearchWordsState
                ? AppProgress(isList: true,listCount: 6,)
                :

            CategoriesCubit.of(context).productModelSearch.isEmpty
                ? Center(child: EmptyScreen())

                : ListView.builder(
              itemCount: CategoriesCubit.of(context).productModelSearch.length,
              itemExtent: responsive.responsiveHigh(context, 0.17),
              itemBuilder: (context ,index)=>
                  ProductItem(
                    context,
                    CategoriesCubit.of(context)
                        .productModelSearch[index],
                  ),
            ),
          ),
        );
      },
    ));
  }
}
