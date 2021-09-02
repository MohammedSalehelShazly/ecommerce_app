import 'package:cached_network_image/cached_network_image.dart';
import '../../../cubit/categories/categoriesCubit.dart';
import '../../../cubit/categories/categoriesStates.dart';
import '../../../shared/styles/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:photo_view/photo_view_gallery.dart';
import 'package:photo_view/photo_view.dart';




/// usage
/// Navigator.push(context, MaterialPageRoute(builder: (_)=> ImagesViewing(  List<String>  )));
/// hero tag is first image at imagesList
///
class ImagesViewing extends StatelessWidget {

  List<dynamic> images;
  ImagesViewing(this.images);

  bool pushPage = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: BlocConsumer<CategoriesCubit ,CategoriesStates>(
            listener: (context ,state){},
            builder: (context ,state)=> NotificationListener(
              onNotification: (t) {
                print(CategoriesCubit.of(context).imgViewScrollCtrl.offset);
                if(CategoriesCubit.of(context).imgViewScrollCtrl.offset >= 60  && pushPage==true){
                  Navigator.of(context).pop();
                  pushPage = false; // to pop just one time
                }
                return null ;
              },
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                controller: CategoriesCubit.of(context).imgViewScrollCtrl,
                child: Container(
                  height: responsive.responsiveHigh(context, 1.0)-responsive.screenPadding(context),
                    child: Stack(
                      children: [
                        PhotoViewGallery.builder(
                          scrollPhysics: const BouncingScrollPhysics(),
                          pageController: PageController(initialPage: CategoriesCubit.of(context).currentCatImg),
                          builder: (BuildContext context, int index) {
                            return PhotoViewGalleryPageOptions(
                              imageProvider: CachedNetworkImageProvider(images[index]),
                              initialScale: PhotoViewComputedScale.contained * 1,
                              heroAttributes: PhotoViewHeroAttributes(tag: images[CategoriesCubit.of(context).currentCatImg] ),
                            );
                          },
                          itemCount: images.length,
                          loadingBuilder: (context, event) => Center(
                            child: Container(
                              width: 20.0,
                              height: 20.0,
                              child: CircularProgressIndicator(
                                value: event == null
                                    ? 0
                                    : event.cumulativeBytesLoaded / event.expectedTotalBytes,
                              ),
                            ),
                          ),
                          onPageChanged: (index){
                            CategoriesCubit.of(context).setCurrentCatImg(index);
                          },
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              padding: EdgeInsets.all(8),
                              icon: Icon(Icons.arrow_back ,color: Colors.white),
                              onPressed: (){
                                Navigator.pop(context);
                              },
                            ),
                            IconButton(
                              padding: EdgeInsets.all(8),
                              icon: Icon(Icons.share ,color: Colors.white),
                              onPressed: (){

                              },
                            ),
                          ],
                        ),

                        /*Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(images.length ,(index)=> Padding(
                              padding: EdgeInsets.symmetric(vertical: 5 ,horizontal: 5),
                              child: CircleAvatar(
                                radius: 6,
                                backgroundColor: CategoriesCubit.of(context).currentCatImg == index
                                    ? Colors.white
                                    : Colors.white70,
                              ),
                            ))
                        ))*/
                      ],
                    )
                ),
              ),
            ),
          )
      ),
    );
  }
}
