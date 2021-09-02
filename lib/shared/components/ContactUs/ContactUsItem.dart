import 'dart:math';

import '../../../cubit/homeCubit/homeCubit.dart';
import '../../../cubit/homeCubit/homeState.dart';
import '../../styles/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum RotateDirection{
  toLeft,
  toRight
}

class ContactUsItem extends StatelessWidget {
  String img;
  RotateDirection rotateDirection;
  int length;
  Function function;

  ContactUsItem({
    @required this.img,
    @required this.rotateDirection ,
    @required this.length,
    @required this.function
  });

  double angleSign() => (rotateDirection == RotateDirection.toLeft ? 1 : -1);

  double convertToRadian(double degreeAngle) =>
      (angleSign() * degreeAngle * (pi / 180));

  double opacityValue(double _angle) =>
      1 - ((_angle.sign == -1 ? _angle * -1 : _angle) / (pi / 180) / 90);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) => Container(
              height: responsive.responsiveWidth(context, .4),
              child: TweenAnimationBuilder<double>(
                duration: Duration(seconds: 1),
                tween: Tween(
                    begin: convertToRadian(HomeCubit.of(context).rotateAngle),
                    end: convertToRadian(HomeCubit.of(context).rotateEndAngle)),
                builder: (context, _value, _child) => Transform.rotate(
                    angle: _value,
                    child:
                        Opacity(opacity: opacityValue(_value), child: _child)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                        child: VerticalDivider(
                      thickness: 2,
                    )),
                    InkWell(
                      onTap: function,
                      borderRadius: BorderRadius.circular(30),
                      child: CircleAvatar(
                        radius: responsive.sWidth(context)/length/3,
                        backgroundImage: AssetImage(img),
                      ),
                    )
                  ],
                ),
              ),
            ));
  }
}
