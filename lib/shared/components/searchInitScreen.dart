import '../../cubit/categories/categoriesCubit.dart';
import '../../cubit/categories/categoriesStates.dart';
import '../../shared/components/appListTile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/styles/responsive.dart';
import '../../shared/localization/language_constants.dart';
import '../../shared/styles/colors.dart';
import 'package:flutter/material.dart';

class SearchInitScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoriesCubit ,CategoriesStates>(
      listener: (context ,state){},
      builder:(context ,state)=>

          CategoriesCubit.of(context).searchWords.length == 0
              ?
          Container(
            width: responsive.sWidth(context),
            height: responsive.sHeight(context),
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            SizedBox(height: responsive.responsiveHigh(context, 0.05),),

            Text(
              getTranslated(context, 'Enter a few words to search in products'),
              style: TextStyle(fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: responsive.responsiveHigh(context, 0.01),),

            CircleAvatar(
              backgroundColor: appClrs.mainColor,
              radius: responsive.textScale(context)*45,
              child: Icon(Icons.search ,color: Colors.white,size: responsive.textScale(context)*73),
            ),

          ],
        ),
      )

              :
          ListView.builder(
            itemCount: CategoriesCubit.of(context).searchWords.length,
              itemExtent: responsive.countryListTileHigh(context),
              //reverse: true,
              itemBuilder: (context, index) => AppListTile(
                txt: CategoriesCubit.of(context).searchWords.reversed.toList()[index],
                trailing: IconButton(
                  icon: Icon(Icons.cancel_outlined),
                  onPressed: () async{
                    await CategoriesCubit.of(context).delSearchWords(CategoriesCubit.of(context).searchWords.reversed.toList()[index]);
                  },
                ),
                leading: Icon(Icons.search),
                onTap: (){
                  CategoriesCubit.of(context).searchFocusNode.unfocus();
                  CategoriesCubit.of(context).setSearchCtrlWithSearch(context ,CategoriesCubit.of(context).searchWords.reversed.toList()[index]);
                },
              )),
    );
  }
}