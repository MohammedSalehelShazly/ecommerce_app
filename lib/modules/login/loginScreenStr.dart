
import 'package:flutter/material.dart';
import '../../shared/styles/responsive.dart';

class LoginScreenStr extends StatelessWidget {

  Widget child;
  double bottomPadding;

  LoginScreenStr({
    @required this.child,
    @required this.bottomPadding,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: responsive.responsiveHigh(context, 1) -responsive.screenPadding(context),
                foregroundDecoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                ),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            'assets/images/e_commerce_BG.jpg'),
                        fit: BoxFit.fill)),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(25, 0, 25, bottomPadding),
              child: Column(
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
    ));
  }
}
