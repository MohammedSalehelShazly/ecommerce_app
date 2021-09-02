import '../../cubit/addressCubit/addressCubit.dart';
import '../../cubit/addressCubit/addressStates.dart';
import '../../cubit/profileCubit/profileCubit.dart';
import '../../cubit/profileCubit/profileStates.dart';
import '../../modules/profile/addressScreen.dart';
import '../../shared/localization/language_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'addAddressBtn.dart';
import 'addressRow.dart';
import 'appDialog.dart';
import 'enums.dart';
import 'loading/appProgress.dart';

class AddressWidget extends StatelessWidget {

  updateAddress(BuildContext context ,addressFunction func){
    AddressCubit.get(context).setAddressCtrl();
    AddressCubit.get(context).setFirstBuildAddAddress(true);
    Navigator.push(context, MaterialPageRoute(builder: (_)=> AddressScreen(func)
    )).then((value){
      Future.delayed(Duration(milliseconds: 500),(){
        AddressCubit.get(context).disposeAddressCtrl();
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddressCubit ,AddressStates>(
      listener: (context ,state){},
      builder:(context ,state)=>

      state is AddressLoadingState
          ? AppProgress()
          :
      AddressCubit.get(context).getAddressModel.dataAddressModel == null
          ? InkWell(
          onTap: (){
            updateAddress(context, addressFunction.add);
          },
          child: AddAddressBtn())
          :
      InkWell(
          onTap: (){
            showCupertinoDialog(context: context, builder: (_)=> AppDialog(
              screenCtx: context,
              content: getTranslated(context, 'update the address to..'),
              doneActionTitle: getTranslated(context, 'the current location'),
              doneAction:(){
                updateAddress(context, addressFunction.updateWithCurrent);
                // get location .....and go to update
              },
              appearCancelBtn: false,
              customBtn: CupertinoButton(
                child: Text(getTranslated(context, 'the old location')),
                onPressed: (){
                  updateAddress(context, addressFunction.updateWithOld);
                },
              ),));
          },
          child: AddressRow(AddressCubit.get(context).getAddressModel)
      ),
    );
  }
}
