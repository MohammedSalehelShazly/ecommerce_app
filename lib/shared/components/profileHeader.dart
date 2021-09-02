
import 'package:cached_network_image/cached_network_image.dart';
import '../../shared/components/addressWidget.dart';
import '../../shared/localization/language_constants.dart';
import 'package:flutter/cupertino.dart';

import '../../models/userModels/userModel.dart';
import 'loading/appProgress.dart';
import '../../shared/components/profHeadRowItem.dart';
import '../styles/responsive.dart';
import '../../shared/styles/colors.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {

  final User user;
  bool loading;
  ProfileHeader({
    @required this.user,
    @required this.loading
  });


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: responsive.responsiveHigh(context, 0.3),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: appClrs.gradientColors,
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
          ),
        ),


        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: responsive.responsiveHigh(context, 0.35), // 0.3 + (radius)
            margin: const EdgeInsets.only(top: 8,bottom: 3),
            child: Stack(children: [

              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: responsive.responsiveWidth(context, 0.9),
                  height: responsive.responsiveHigh(context, 0.3),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [BoxShadow(spreadRadius: 1,blurRadius: 20 ,color: Colors.black54)]
                  ),
                  child:
                  loading ? AppProgress()
                      :
                  Column(children: [
                    SizedBox(height: responsive.responsiveHigh(context, 0.05),),
                    Text('${user.data.name ??""}', style: TextStyle(fontWeight: FontWeight.w500 ,color: appClrs.mainColor),),
                    Text('${user.data.email ??""}' ,style: TextStyle(color: Theme.of(context).textTheme.subtitle1.color.withOpacity(0.5)),),
                    Text('${user.data.phone ??""}'),


                    /// address
                    Expanded(
                      flex: 2,
                        child: AddressWidget()),

                    Expanded(
                      flex: 3,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(child: ProfHeadRowItem(txt: getTranslated(context, 'points'), val: '${user.data.points}')),
                          Expanded(child: ProfHeadRowItem(txt: getTranslated(context, 'credit'), val: '${user.data.credit}')),
                      ],),
                    ),

                  ],),
                ),
              ),
              Align(
                    alignment: Alignment.topCenter,
                    child: Hero(
                      tag: 'userImg',
                      child: Container(
                      width: responsive.responsiveHigh(context, 0.1),
                      height: responsive.responsiveHigh(context, 0.1),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(image: CachedNetworkImageProvider(
                            user==null
                                ? 'https://student.valuxapps.com/storage/assets/defaults/user.jpg'
                                : user.data.image)),
                        color: Colors.grey[400]
                      ),),
                    ),
                  ),
            ],),
          ),
        )
      ],
    );
  }
}
