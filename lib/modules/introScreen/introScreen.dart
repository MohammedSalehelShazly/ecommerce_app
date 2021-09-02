
import '../../shared/localization/language_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../cubit/loginCubit/loginCubit.dart';
import '../../cubit/loginCubit/loginStates.dart';
import '../../shared/styles/responsive.dart';
import '../../modules/introScreen/oneIntroScreen.dart';
import '../../modules/login/loginScreen.dart';
import '../../shared/components/appButton.dart';
import '../../shared/styles/colors.dart';


class IntroScreen extends StatelessWidget {

  static Map<String ,String> img_desc (context)=>{
    'assets/images/shopping.svg' : getTranslated(context, 'Browse the products to find all that is exciting, whatever you want you will find it here'),
    'assets/images/shopping_2.svg' : getTranslated(context, 'Follow daily discounts and create lists of your favorite products'),
    'assets/images/payments.svg' : getTranslated(context, 'Choose everything you want and pay safely and easily')
  };

  List<OneIntroScreen> screens(BuildContext context)=> [
    OneIntroScreen(sContext: context ,img: img_desc(context).keys.toList()[0], txt: img_desc(context).values.toList()[0]),
    OneIntroScreen(sContext: context ,img: img_desc(context).keys.toList()[1], txt: img_desc(context).values.toList()[1]),
    OneIntroScreen(sContext: context ,img: img_desc(context).keys.toList()[2], txt: img_desc(context).values.toList()[2])
  ];


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<LoginCubit ,LoginStates>(
        listener:(context ,state){},
        builder:(context ,state)=> Scaffold(body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CarouselSlider(
                items: screens(context),
                carouselController: LoginCubit.get(context).carouselController,
                options: CarouselOptions(
                    enlargeCenterPage: true,
                    aspectRatio: 2/3,
                    enableInfiniteScroll: false,
                    scrollPhysics: BouncingScrollPhysics(),
                    onPageChanged: (index, reason) {
                      LoginCubit.get(context).setCurrentIndexOfIntroScreen(index);
                    }),
              ),
              Container(
                height: responsive.sHeight(context)*0.08,
                child: Stack(
                  children: [
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        children: List.generate(img_desc(context).keys.toList().length, (index) => GestureDetector(
                            onTap: () => LoginCubit.get(context).carouselController.animateToPage(index),
                            child: Container(
                              width: 12.0,
                              height: 12.0,
                              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: (appClrs.mainColor)
                                      .withOpacity(LoginCubit.get(context).currentIndexOfIntroScreen == index ? 1.0 : 0.4)),
                            ),
                          )),
                      ),
                    ),

                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: AppButton(
                          content: Text( LoginCubit.get(context).currentIndexOfIntroScreen==img_desc(context).length-1
                              ? getTranslated(context, 'GO').toString()
                              : getTranslated(context, 'SKIP').toString(),
                            style: TextStyle(letterSpacing: 1.5, color: Colors.white.withOpacity(1)),
                          ),
                          width: responsive.sWidth(context)*0.2,
                          height: responsive.responsiveHigh(context, 0.05),
                          clr: appClrs.mainColor,
                          onPressed: () async{
                            await LoginCubit.get(context).setLoginCtrl();
                            Navigator.pushReplacement(context,
                                CupertinoPageRoute(builder: (_) => LoginScreen()));
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
        ]),),
      ),
    );
  }
}
