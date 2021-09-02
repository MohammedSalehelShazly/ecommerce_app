import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../cubit/loginCubit/loginCubit.dart';
import '../../cubit/cartCubit/cartCubit.dart';
import '../../cubit/categories/categoriesCubit.dart';
import '../../cubit/categories/categoriesStates.dart';
import '../../cubit/homeCubit/homeCubit.dart';
import '../../cubit/homeCubit/homeState.dart';
import '../../cubit/profileCubit/profileCubit.dart';
import '../../cubit/profileCubit/profileStates.dart';
import '../../shared/styles/responsive.dart';
import '../../shared/components/emptyScreen.dart';
import 'package:flutter/material.dart';

import '../../shared/components/homeAppBar.dart';
import '../../shared/components/productItem.dart';
import '../../shared/localization/language_constants.dart';
import '../../shared/components/loading/appProgress.dart';
import '../../shared/components/categoriesGrid.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(

      appBar: PreferredSize(
        preferredSize: Size.fromHeight(responsive.sHeight(context)*0.07),
        child: HomeAppBar(),
      ),

      body: BlocConsumer<HomeCubit ,HomeStates>(
          listener: (ctx ,state){},
          builder: (ctx ,state) {
            print('...............................${LoginCubit.get(context).emailLoginCtrl}');
            return
              HomeCubit.of(context).homeProdsModel == null || state is GetHomeDataLoadingState
                  ? Container(height: responsive.sHeight(context)*0.9,child: AppProgress(isList: true, listCount: 6,))
                  :
              ListView(
                controller: HomeCubit.of(context).homeScrollController,
                children: [

                  Container(
                    alignment: Alignment.topCenter,
                    height: responsive.sHeight(context)*0.3,
                    child: CarouselSlider(
                      items: HomeCubit.of(context).homeProdsModel.data.banners.map((banner) => Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(banner.image),
                            )
                        ),
                      ),).toList(),
                      //carouselController: CategoriesCubit.of(context).carouselController,
                      options: CarouselOptions(
                        enlargeCenterPage: true,
                        enableInfiniteScroll: true,
                        autoPlay: true,
                        scrollPhysics: BouncingScrollPhysics(),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        viewportFraction: 1
                          ),
                    ),
                  ),


                  CategoriesGrid(),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(getTranslated(context, 'Today Offers') ,style: TextStyle(fontWeight: FontWeight.bold),),
                  ),


                  HomeCubit.of(context).homeProdsModel.data.products.isEmpty
                      ? Center(child: EmptyScreen())
                      :

                  ListView.builder(
                    shrinkWrap: HomeCubit.of(context).homeProdsModel != null && !(state is GetHomeDataLoadingState),
                    controller: HomeCubit.of(context).homeScrollController,
                    itemCount: HomeCubit.of(context).homeProdsModel.data.products.length,
                    itemExtent: responsive.responsiveHigh(context, 0.17),
                    itemBuilder: (context ,index)=>
                        ProductItem(
                          context,
                          HomeCubit.of(context).homeProdsModel.data.products[index],
                        ),
                  ),


            ],
          );
        },
      ),

    ));
  }
}
