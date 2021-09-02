/*

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'connectionStates.dart';

class ConnectionCubit extends Cubit<ConnectionStates>{
  ConnectionCubit() :super(ConnectionLoading());
  ConnectionCubit of(context)=> BlocProvider.of(context);


  StreamSubscription streamSubscriptionConnection;

  getConnection() async{
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      streamSubscriptionConnection = emitConnected();
    } else if (connectivityResult == ConnectivityResult.none) {
      streamSubscriptionConnection = emitDisConnected();
    }
  }

  emitConnected()=>
      ConnectedState();

  emitDisConnected()=>
      DisConnectedState();



















}*/
