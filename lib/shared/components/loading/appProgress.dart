import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';

import '../../styles/responsive.dart';
import 'loadingItemInGrid.dart';
import 'loadingItemInList.dart';


/// *****=notes=*****
/// isList ? return progress as a listView
///        :   ~        ~     ~   GridView
/// when select GridView... must listCount >= 12 to fill screen
///  ~     ~    listView...  ~      ~      >=  5 to   ~     ~



class AppProgress extends StatelessWidget {

  int listCount = 0;
  bool isList;
  AppProgress({
    this.listCount = 0 ,
    this.isList =true
  });

  SliverGridDelegate sliverGridDelegate (context)=> SliverGridDelegateWithMaxCrossAxisExtent(
    childAspectRatio: 2/3,
    mainAxisSpacing: 5,
    crossAxisSpacing: 5,
    maxCrossAxisExtent: responsive.responsiveWidth(context, 0.4),
  );

  @override
  Widget build(BuildContext context) {
    return listCount==0
        ? Center(child : CupertinoActivityIndicator())
        : Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        child: isList
            ? ListView.builder(
          itemCount: listCount,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(10),
            child: LoadingItemInList()
          ),
        )
            :
        GridView.builder(
          gridDelegate: sliverGridDelegate(context),
          itemCount: listCount,
          itemBuilder: (context ,index)=> LoadingItemInGrid(),
        )


    );
  }
}


