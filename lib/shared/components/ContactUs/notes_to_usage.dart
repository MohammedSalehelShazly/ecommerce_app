
///
/// add in HomeCubit..
//   double rotateAngle = 90;
//   double rotateEndAngle = 90;
//
//   setEndRotateAngleVal(){
//     if(rotateAngle == 90 && rotateEndAngle == 90)
//       rotateAngle = 0;
//
//     if(rotateAngle>0){
//       rotateAngle = 0;
//       rotateEndAngle =90;
//     }
//     else if(rotateAngle<90){
//       rotateAngle = 90;
//       rotateEndAngle = 0;
//     }
//     else{
//       rotateAngle = 0;
//       rotateEndAngle =90;
//     }
//     emit(SetEndRotateAngleValState());
//   }
///
///
/// button to make animation
// Stack(
//    children: [
//
//      Align(
//        alignment: Alignment.topCenter,
//        child: Transform.translate(
//            offset: Offset(0,5),
//            child: ContactUsList(context)),
//      ),
//
//      Card(
//        child: BlocConsumer<HomeCubit ,HomeStates>(
//          listener: (context ,state){},
//          builder:(context ,state)=> AppListTile(
//            txt: getTranslated(context, 'Contact Us'),
//            onTap: (){
//              HomeCubit.of(context).setEndRotateAngleVal();
//            },
//            trailing: Icon(Icons.info_outline),
//          ),
//        ),
//      ),
//    ],
//  )
///
///
///