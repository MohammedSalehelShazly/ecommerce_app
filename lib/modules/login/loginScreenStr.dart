
import 'package:flutter/material.dart';
import '../../shared/styles/responsive.dart';

class LoginScreenStr extends StatelessWidget {

  Widget child;
  double bottomPadding;
  bool isRegister;

  LoginScreenStr({
    @required this.child,
    @required this.bottomPadding,
    this.isRegister = false
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.bottomCenter,
          // height: responsive.responsiveHigh(context, 1.2) -
          //     responsive.screenPadding(context),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                      'assets/images/e_commerce_BG.jpg'),
                  fit: BoxFit.fill)),

          child: Container(
            height: responsive.responsiveHigh(context, (isRegister ? 1.15 :1.0)) -
                responsive.screenPadding(context),

                child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(25, 0, 25, bottomPadding),
                  decoration: BoxDecoration(
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3),spreadRadius: 400)]
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Hero(
                        tag: 'logo',
                        child: Container(
                          height:
                              responsive.responsiveHigh(context, 0.15),
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/logo_ecommerce.png'),
                                  fit: BoxFit.contain)),
                        ),
                      ),
                      Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white),
                          padding: EdgeInsets.all(
                              responsive.responsiveWidth(context, 0.03)),
                          child: this.child,
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
