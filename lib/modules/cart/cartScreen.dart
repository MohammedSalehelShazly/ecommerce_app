import '../../cubit/cartCubit/cartCubit.dart';
import '../../cubit/cartCubit/cartStates.dart';
import '../../shared/styles/responsive.dart';
import '../../shared/components/loading/appProgress.dart';
import '../../shared/components/productItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: BlocConsumer<CartCubit ,CartStates>(
      listener: (context ,state){},
      builder:(context ,state)=> Scaffold(
        body:
        CartCubit.of(context).allCartProdsModel == null
            ? AppProgress(isList: true,listCount: 6,)
            :

        ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: CartCubit.of(context).prodsInCartIDList.length, //CartCubit.of(context).allCartProdsModel.data.cart_items.length,
          itemExtent: responsive.responsiveHigh(context, 0.17),
          itemBuilder: (context ,index)=>

          CartCubit.of(context).prodsInCartIDList.contains(CartCubit.of(context).allCartProdsModel.data.cart_items[index].product.id)
              ?
          ProductItem(
            context,
            CartCubit.of(context).allCartProdsModel.data.cart_items[index].product,
          )
           : SizedBox(),
        ),
      ),
    ));
  }
}






















