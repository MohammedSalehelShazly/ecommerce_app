import 'package:flutter/cupertino.dart';

import '../../cubit/cartCubit/cartStates.dart';
import '../../shared/components/staticVariables.dart';
import '../../models/cartsModels/addOrRemoveProdCartsModels.dart';
import '../../models/cartsModels/getCartsModel.dart';
import '../../shared/network/remote/cart.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';

class CartCubit extends Cubit<CartStates>{
  CartCubit() :super(InitCartStates());
  static CartCubit of(context)=> BlocProvider.of(context);

  Cart _cart = Cart();


  AllCartProdsModel allCartProdsModel;
  Future getCarts(BuildContext context)async{
    try{
      allCartProdsModel = null;
      emit(GetAllCartLoadingStates());

      allCartProdsModel = await _cart.getAllCarts(context);

      for(int i=0 ;i<allCartProdsModel.data.cart_items.length ;i++){
        if(!prodsInCartIDList.contains(allCartProdsModel.data.cart_items[i].product.id))
          prodsInCartIDList.add(allCartProdsModel.data.cart_items[i].product.id);
        prodsInCartIDList = prodsInCartIDList.toSet().toList();
      }
      print('allCartProdsModel' + allCartProdsModel.data.cart_items.toString());
      print('prodsInCartIDList ' + '$prodsInCartIDList');

      emit(ProdsInCartIDListState());

    }on Exception catch(e){
      print(e);
    }finally{
      emit(GetAllCartStates());
    }
  }



  AddOrRemoveProdCartsModels addOrRemoveProdCartsModels;
  List<int> prodsInCartIDList =[];
  addOrRemove(BuildContext context, int prodID) async{print('prodID $prodID');
    try{
      emit(AddOrRemoveLoadingState());

      addOrRemoveProdCartsModels = await _cart.addOrRemove(context, prodID);

      staticVars.showToast(context, addOrRemoveProdCartsModels.message);

      if(addOrRemoveProdCartsModels.status){
        prodsInCartIDList.contains(prodID)
            ? prodsInCartIDList.remove(prodID)
            : prodsInCartIDList.add(prodID);
        await getCarts(context);
      }



    }on Exception catch(e){
      print(e);
    }finally{
      emit(AddOrRemoveState());
    }
  }


}