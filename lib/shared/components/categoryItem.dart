import 'package:cached_network_image/cached_network_image.dart';
import '../../shared/styles/responsive.dart';
import '../../modules/categoriesScreens/productsInCatScreen.dart';
import '../../shared/styles/colors.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {

  int catID;
  String image;
  String catName;
  CategoryItem({
    @required this.catID,
    @required this.catName,
    @required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (_)=>OneCategoryScreen(catID:catID ,catName:catName,)));
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              width: responsive.responsiveWidth(context, 0.3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: appClrs.mainColor.withOpacity(0.3),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(image),
                  fit: BoxFit.fill
                )
              ),
            ),
          ),
          SizedBox(height: 5,),
          Expanded(flex: 1,child: Text(catName.toString() ,textAlign: TextAlign.center,maxLines: 1,))
        ],
      ),
    );
  }
}
