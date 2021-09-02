import 'package:flutter/material.dart';

import '../../shared/localization/language_constants.dart';
import '../../shared/styles/colors.dart';
import '../../cubit/addressCubit/addressCubit.dart';
import '../../cubit/categories/categoriesCubit.dart';
import '../../cubit/categories/categoriesStates.dart';
import '../../cubit/profileCubit/profileCubit.dart';
import '../../cubit/profileCubit/profileStates.dart';
import '../../shared/styles/responsive.dart';
import '../../modules/categoriesScreens/searchScreen.dart';
import '../../modules/profile/profileScreen.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(getTranslated(context, 'LifeStyle') ,style: TextStyle(fontFamily: appClrs.secondFontFamily ,fontWeight: FontWeight.w600 ,fontSize: 25 ,letterSpacing: 1.3),),

      actions: [
        BlocConsumer<ProfileCubit, ProfileStates>(
          listener: (context, state) {},
          builder: (context, state) {
            if(ProfileCubit.get(context).user == null){
              ProfileCubit.get(context).getUserProfile(context: context,);
            }
            if(AddressCubit.get(context).getAddressModel == null){
              AddressCubit.get(context).getAddress(context);
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> ProfileScreen())),
                child: Hero(
                  tag: 'userImg',
                  child: CircleAvatar(
                      radius: responsive.sHeight(context)*0.025,
                      backgroundImage: ProfileCubit.get(context).user !=
                          null
                          ? CachedNetworkImageProvider(
                          ProfileCubit.get(context).user.data.image)
                          : null),
                ),
              ),
            );
          },
        ),

        BlocConsumer<CategoriesCubit ,CategoriesStates>(
        listener: (context ,state){},
          builder:(context ,state)=> IconButton(
            onPressed:() async{
              await CategoriesCubit.of(context).setSearchController(true);
              await CategoriesCubit.of(context).getSearchWords();
              Navigator.push(context, MaterialPageRoute(builder: (_)=> SearchScreen())).then((value){
                Future.delayed(Duration(milliseconds: 700),(){
                  CategoriesCubit.of(context).setSearchController(false);
                  CategoriesCubit.of(context).clearSearch();
                });
              });
            },
            icon: Icon(Icons.search_outlined),
          ),
        )

      ],
    );
  }
}
