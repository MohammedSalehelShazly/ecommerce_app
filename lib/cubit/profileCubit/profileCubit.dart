
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import '../../cubit/loginCubit/loginCubit.dart';
import '../../models/userModels/complaintsModel.dart';
import '../../models/userModels/getAddressModel.dart';
import '../../models/userModels/postAddressModel.dart';
import '../../models/userModels/updateProfileModel.dart';
import '../../shared/components/appDialog.dart';
import '../../shared/localization/language_constants.dart';
import '../../shared/network/local/sharedPreferences.dart';
import '../../shared/network/remote/address.dart';
import '../../shared/network/remote/getLocation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import '../../cubit/loginCubit/loginStates.dart';
import '../../cubit/profileCubit/profileStates.dart';
import '../../shared/components/staticVariables.dart';
import '../../models/userModels/userModel.dart';
import '../../shared/network/remote/userProfileHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileStates>{

  ProfileCubit() : super(InitialProfileState());
  static ProfileCubit get(context) => BlocProvider.of(context);

  User user;

  UserProfileHelper _userProfileHelper = UserProfileHelper();
  getUserProfile({@required BuildContext context}) async{
    emit(LoadingProfileState());
    try{
      user = await _userProfileHelper.getUserProfile(context);

      if(user.status){
        emit(GetProfileState());
      }else{ //    وده صعب يحصل لأن التوكن المفروض انه متخزن صح
        staticVars.showToast(context, user.message??'');
      }
    }on DioError catch(e){
      if(e.type != DioErrorType.response){
        staticVars.showToast(context, e.toString());
        print(e);
        print(e.type);
      }
    }
  }


  GlobalKey<FormState> complaintsMsgForm = GlobalKey<FormState>();
  TextEditingController complaintsMsgCtrl;
  setComplaintsMsgCtrl(){
    complaintsMsgCtrl = TextEditingController();
    emit(ComplaintsMsgCtrlState());
  }
  disposeComplaintsMsgCtrl(){
    complaintsMsgCtrl.dispose();
    emit(ComplaintsMsgCtrlState());
  }

  ComplaintsModel complaintsModel;
  addComplaints(BuildContext context) async{
    emit(ComplaintsMsgLoadingState());
    try{
      complaintsModel = await _userProfileHelper.addComplaints(context ,user ,complaintsMsgCtrl.text);
      if(complaintsModel.status){
        showCupertinoDialog(context: context, builder: (_)=>
            AppDialog(
              screenCtx: context,
              content: complaintsModel.message
                  + '\n' + getTranslated(context, 'Complaint number:') +' '
                  + '${complaintsModel.id}',
              doneActionTitle: getTranslated(context, 'OK'),
              doneAction: (){
                Navigator.pop(context);
                Future.delayed(Duration(milliseconds: 500),(){
                  Navigator.pop(context);
                });
              },
              appearCancelBtn: false,
            ));
      }

      else
        staticVars.showToast(context, complaintsModel.message);

    }on Exception catch(e){
      print(e);
    }finally{
      emit(ComplaintsMsgState());
    }
  }








}