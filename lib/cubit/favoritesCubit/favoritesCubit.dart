import 'package:bloc/bloc.dart';
import '../../cubit/loginCubit/loginCubit.dart';
import '../../shared/components/staticVariables.dart';
import '../../models/favoritesModels/addRemoveFavModels.dart';
import '../../models/favoritesModels/allFavoritesModel.dart';
import '../../shared/network/remote/favorite.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'favoritesStates.dart';

class FavoritesCubit extends Cubit<FavoriteStates>{

  FavoritesCubit() :super (FavoriteInitStates());
  static FavoritesCubit of(context)=> BlocProvider.of(context);










}