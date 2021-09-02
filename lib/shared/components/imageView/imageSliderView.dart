import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../cubit/categories/categoriesCubit.dart';
import '../../../cubit/categories/categoriesStates.dart';
import '../../components/imageView/imagesViewing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// plugins..
// flutter pub add photo_view && flutter pub add carousel_slider

/// add in class cubit..
// CarouselController carouselController;
//   int currentCatImg = 0;
//   setCurrentCatImg(int _index){
//     currentCatImg = _index;
//     emit(SetCurrentCatImgState());
//   }

// ScrollController imgViewScrollCtrl ;
//   setCtrl(){
//     imgViewScrollCtrl = ScrollController();
//     emit(ScrollControllerState());
//   }
//   clearCtrl(){
//     imgViewScrollCtrl.dispose();
//     emit(ScrollControllerState());
//   }

/// usage..
/// ImageSlider( product.images ),


class ImageSlider extends StatelessWidget {
  List<dynamic> images;
  ImageSlider(this.images);
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: BlocConsumer<CategoriesCubit ,CategoriesStates>(
        listener: (context ,state){},
        builder: (context ,state)=>  WillPopScope(
          onWillPop: ()async{
            await CategoriesCubit.of(context).setCurrentCatImg(0);
            return true;
          },
          child: InkWell(onTap: (){
            CategoriesCubit.of(context).setCtrl();
            Navigator.push(context, MaterialPageRoute(builder: (_)=> ImagesViewing(  images  ))).then((value){
              CategoriesCubit.of(context).clearCtrl();
            });
          },
              child: Hero(
                tag: images[CategoriesCubit.of(context).currentCatImg],
                child: CarouselSlider(
                  items: images.map((e) => Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(e),
                        )
                    ),
                  ),).toList(),
                  carouselController: CategoriesCubit.of(context).carouselController,
                  options: CarouselOptions(
                      initialPage: CategoriesCubit.of(context).currentCatImg,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: true,
                      autoPlay: true,
                      scrollPhysics: BouncingScrollPhysics(),
                      onPageChanged: (index, reason) {
                        CategoriesCubit.of(context).setCurrentCatImg(index);
                      }),
                ),
              )
          ),
        )));
  }
}
