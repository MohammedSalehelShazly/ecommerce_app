import 'package:flutter/material.dart';

import '../../shared/components/staticVariables.dart';
import '../../models/userModels/getAddressModel.dart';
import '../../models/userModels/postAddressModel.dart';
import '../../shared/network/local/sharedPreferences.dart';
import '../../shared/network/remote/address.dart';
import '../../shared/network/remote/getLocation.dart';

import'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';


import 'addressStates.dart';

class AddressCubit extends Cubit<AddressStates>{

  AddressCubit() :super(AddressInitState());
  static AddressCubit get(context)=> BlocProvider.of<AddressCubit>(context);





  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();

  TextEditingController addressNameCtrl;
  TextEditingController addressCityCtrl;
  TextEditingController addressRegionCtrl;
  TextEditingController addressDetailsCtrl;
  TextEditingController addressNotesCtrl;
  String _lat;
  String _long;

  setAddressCtrl(){
    addressNameCtrl = TextEditingController();
    addressCityCtrl = TextEditingController();
    addressRegionCtrl = TextEditingController();
    addressDetailsCtrl = TextEditingController();
    addressNotesCtrl = TextEditingController();
    emit(SetAddressCtrlState());
  }
  disposeAddressCtrl(){
    addressNameCtrl.dispose();
    addressCityCtrl.dispose();
    addressRegionCtrl.dispose();
    addressDetailsCtrl.dispose();
    addressNotesCtrl.dispose();
    emit(SetAddressCtrlState());
  }


  SharedPreferencesHelper _sharedPreferencesHelper = SharedPreferencesHelper();
  savedAddressID(int addressID)async{
    await _sharedPreferencesHelper.setAddressID(addressID);
  }
  Future<int> _getAddressID()async{ // default is (-1) => empty
    int addressID;
    addressID = await _sharedPreferencesHelper.getAddressID();
    return addressID;
  }


  GetLocation getLocation = GetLocation();
  Address address = Address();
  bool firstBuildAddAddress = true;
  setFirstBuildAddAddress(bool val){
    firstBuildAddAddress = val;
    emit(SetFirstBuildAddAddressState());
  }

  getAddressDetails(BuildContext context) async{
    setFirstBuildAddAddress(false);
    emit(UserLocationLoadingState());

    try{
      Placemark placeMark = await getLocation.getPlace();
      Position position = await getLocation.determinePosition();

      addressCityCtrl = TextEditingController(text: placeMark.country+' ,'+placeMark.administrativeArea);
      addressRegionCtrl = TextEditingController(text: placeMark.subAdministrativeArea);
      addressDetailsCtrl = TextEditingController(text: placeMark.street);

      // when addressFunction.updateWithCurrent...
      // its fill controller with current location but not fill this two ctrl..
      if(getAddressModel !=null && getAddressModel.dataAddressModel!=null){
        addressNameCtrl = TextEditingController(text: getAddressModel.dataAddressModel.name);
        addressNotesCtrl = TextEditingController(text: getAddressModel.dataAddressModel.notes);
      }


      _lat = position.latitude.toString();
      _long = position.longitude.toString();

      //postAddress(context);
    }on Exception catch(e){
      print(e);
    }finally{
      emit(GetUserLocationState());
    }

  }

  PostAddressModel postAddressModel;
  postAddress(BuildContext context) async{
    emit(AddressLoadingState());
    try{
      postAddressModel = await address.postAddress(
        context: context,
        name: addressNameCtrl.text,
        city: addressCityCtrl.text,
        region: addressRegionCtrl.text,
        details: addressDetailsCtrl.text,
        notes: addressNotesCtrl.text,
        latitude: _lat,
        longitude: _long,
      );

      if(postAddressModel.status){
        savedAddressID(postAddressModel.id);
        await getAddress(context);
        Navigator.pop(context);
      }
      staticVars.showToast(context, postAddressModel.message);
    }on Exception catch(e){
      print(e);
    }finally{
      emit(PostAddressState());
    }
  }



  GetAddressModel getAddressModel;
  getAddress(BuildContext context) async{
    emit(AddressLoadingState());
    int addressID = await _getAddressID();
    try{
      getAddressModel = await address.getAddress(context);
      if(getAddressModel.status && addressID == -1){
        print('addressID $addressID');
        await savedAddressID( getAddressModel.dataAddressModel==null ?-1 :getAddressModel.dataAddressModel.id);
      }
    }on Exception catch(e){
      print(e);
    }finally{
      emit(GetUserAddressState());
    }
  }



  fillCtrlWithOld(){
    if(getAddressModel.dataAddressModel == null){
      addressNameCtrl = TextEditingController(text: TextEditingValue.empty.text);
      addressCityCtrl = TextEditingController(text: TextEditingValue.empty.text);
      addressRegionCtrl = TextEditingController(text: TextEditingValue.empty.text);
      addressDetailsCtrl = TextEditingController(text: TextEditingValue.empty.text);
      addressNotesCtrl = TextEditingController(text: TextEditingValue.empty.text);
      _lat = '';
      _long = '';
    }
    else{
      addressNameCtrl = TextEditingController(text: getAddressModel.dataAddressModel.name);
      addressCityCtrl = TextEditingController(text: getAddressModel.dataAddressModel.city);
      addressRegionCtrl = TextEditingController(text: getAddressModel.dataAddressModel.region);
      addressDetailsCtrl = TextEditingController(text: getAddressModel.dataAddressModel.details);
      addressNotesCtrl = TextEditingController(text: getAddressModel.dataAddressModel.notes);
      _lat = getAddressModel.dataAddressModel.latitude;
      _long = getAddressModel.dataAddressModel.longitude;
    }
    emit(SetAddressCtrlState());
  }


  updateAddress(BuildContext context) async{
    emit(AddressLoadingState());
    try{
      int addressID = await _getAddressID();
      Map<String,dynamic> update = await address.updateAddress(
        context: context,
        addressID: '$addressID',
        name: addressNameCtrl.text,
        city: addressCityCtrl.text,
        region: addressRegionCtrl.text,
        details: addressDetailsCtrl.text,
        notes: addressNotesCtrl.text,
        latitude: _lat,
        longitude: _long,
      );
      if(update['status']){
        await getAddress(context);
        Navigator.pop(context);
        Navigator.pop(context);
      }
      staticVars.showToast(context, update['message']);
    }on Exception catch(e){
      print(e);
    }finally{
      emit(UpdateAddressState());
    }
  }



  deleteAddress(BuildContext context) async{
    emit(DeleteAddressLoadingState());
    try{
      int addressID = await _getAddressID();
      Map<String ,dynamic> delete = await address.deleteAddress(addressID ,context);

      if(delete['status']){
        savedAddressID(-1);
        await getAddress(context);
        Navigator.pop(context);
        Navigator.pop(context);
      }

      staticVars.showToast(context, delete['message']);
    }on Exception catch(e){
      print(e);
    }finally{
      emit(UpdateAddressState());
    }

  }
















}
