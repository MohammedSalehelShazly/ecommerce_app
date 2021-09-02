import 'dart:async';
import '../../shared/network/local/sharedPreferences.dart';
import 'package:flutter/cupertino.dart';

import '../../cubit/categories/categoriesStates.dart';
import '../../shared/components/staticVariables.dart';
import '../../models/CategoriesModels/oneCategoryModel.dart';
import '../../models/favoritesModels/addRemoveFavModels.dart';
import '../../models/favoritesModels/allFavoritesModel.dart';
import '../../shared/network/remote/favorite.dart';
import '../../models/CategoriesModels/categoriesModel.dart';
import '../../shared/network/remote/categories.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:carousel_slider/carousel_controller.dart';
class CategoriesCubit extends Cubit<CategoriesStates>{

  CategoriesCubit() : super(CategoriesInitState());
  static CategoriesCubit of(context)=> BlocProvider.of(context);


  CategoriesModel categoriesModel;
  CategoriesHelper _categoriesHelper = CategoriesHelper();

  getCategoriesModel(BuildContext context) async{
    emit(CategoriesLoadingState());
    try{
      categoriesModel = await _categoriesHelper.getCategories(context);
    }on Exception catch(e){
      print(e);
    }finally{
      emit(CategoriesGetState());
    }
  }

  bool showAllCat = false;
  reverseShowAllCat(){
    showAllCat = !showAllCat;
    emit(CatStatesReverseShowAllCat());
  }


  Map<int ,OneCategoryModel> allCategories ={};
  getOneCategoryProds(BuildContext context, int catID) async{
    emit(OneCategoryGetLoadingState());
    try{
      allCategories[catID] = await _categoriesHelper.getCategoryDetails(catID ,context);
    }on Exception catch(e){
      print(e);
    }finally{
      emit(OneCategoryGetState());
    }
  }

  oneCategoryClearState(int catID){
    allCategories.remove(catID);
    emit(OneCategoryClearState());
  }

  clearCategoriesModel(){
    categoriesModel = null;
    emit(OneCategoryClearState());
  }
  oneCategoryClearModel(){
    allCategories = {};
    emit(OneCategoryClearState());
  }


  CarouselController carouselController;
  int currentCatImg = 0;
  setCurrentCatImg(int _index){
    currentCatImg = _index;
    emit(SetCurrentCatImgState());
  }

  ScrollController imgViewScrollCtrl ;
  setCtrl(){
    imgViewScrollCtrl = ScrollController();
    emit(ScrollControllerState());
  }
  clearCtrl(){
    imgViewScrollCtrl.dispose();
    emit(ScrollControllerState());
  }




  /// search..


  GlobalKey<FormState> searchFormKey = GlobalKey<FormState>();

  TextEditingController searchController = TextEditingController();
  FocusNode searchFocusNode = FocusNode();
  setSearchController(bool set){
    if(set){
      searchController = TextEditingController();
      searchFocusNode = FocusNode();
    }
    else{
      searchController.dispose();
      searchFocusNode.dispose();
    }

    emit(SetSearchControllerState());
  }

  bool hasFocusSearch = true;
  setHasFocusSearch(bool val){
    hasFocusSearch = val;
    emit(SetSearchControllerState());
  }

  List<String> searchWords =[];
  getSearchWords() async{
    searchWords =[];
    searchWords = await sharedPreferencesHelper.getSearchWord();
    emit(GetSearchWordsState());
  }
  delSearchWords(String word) async{
    searchWords.remove(word);
    await sharedPreferencesHelper.setSearchWord(word, false);
    emit(GetSearchWordsState());
  }
  setSearchWords(String searchWord) async{
    if(!searchWords.contains(searchWord)){
      await sharedPreferencesHelper.setSearchWord(searchWord, true);
      await getSearchWords();
      emit(GetSearchWordsState());
    }
  }
  setSearchCtrlWithSearch(BuildContext context ,String word){
    searchController = TextEditingController(text: word);
    emit(SetSearchControllerState());
    getSearches(context ,word);
  }





  Future<void> getAllProducts(BuildContext context) async{
    emit(GetAllLoadingState());
    for(int i=0 ;i<categoriesModel.data.data.length ;i++){
      if(!allCategories.containsKey(categoriesModel.data.data[i].id)){
        await getOneCategoryProds(context ,categoriesModel.data.data[i].id);
      }
    }
    emit(GetAllCatsState());
  }


  List<Product> productModelSearch =[];
  getSearches(BuildContext context, String searchWord) async{
    emit(SearchLoadingState());
    try{
      await getAllProducts(context);
      productModelSearch =[];

      for(int i=0 ;i<allCategories.length ;i++){
        for(int prodIndex=0 ;prodIndex<allCategories.values.toList()[i].data.data.length ;prodIndex++){
          if( allCategories.values.toList()[i].data.data[prodIndex].name.toLowerCase().contains(searchWord.toLowerCase())
              || allCategories.values.toList()[i].data.data[prodIndex].description.toLowerCase().contains(searchWord.toLowerCase())
              || allCategories.values.toList()[i].data.data[prodIndex].price.toString().toLowerCase().contains(searchWord.toLowerCase())
              || allCategories.values.toList()[i].data.data[prodIndex].old_price.toString().toLowerCase().contains(searchWord.toLowerCase())
              || allCategories.values.toList()[i].data.data[prodIndex].discount.toString().toLowerCase().contains(searchWord.toLowerCase())
          ){
            productModelSearch.add(allCategories.values.toList()[i].data.data[prodIndex]);
          }
        }
      }
      print('end search');

    }on Exception catch(e){
      print(e);
    }finally{
      emit(SearchGetState());
    }
  }

  clearSearch(){
    productModelSearch = [];
    emit(SearchGetState());
  }


  Future<Product> getProduct(BuildContext context ,int prodID) async{
    Product product = await _categoriesHelper.getProduct(prodID ,context);
    return product;
  }
  




  /// favorites

  Map<int ,Product> isFavProdList = {};
  setIsFavList(BuildContext context ,AllFavoritesModel _allFavoritesModel) async{
    for(int i=0 ;i<_allFavoritesModel.products.length;i++){
      isFavProdList[_allFavoritesModel.products[i].id] = null;
    }
    emit(AddToIsFavListState());
  }


  Favorite _favorite = Favorite();

  AddRemoveFavModels addRemoveFavModels;
  Future addRemoveFav(BuildContext context ,int prodID) async{
    try{
       bool isExists = isFavProdList.containsKey(prodID);

       isExists
           ? isFavProdList.remove(prodID)
           : isFavProdList[prodID] = null;

      emit(AddToIsFavListState());

      addRemoveFavModels = null;
      addRemoveFavModels = await _favorite.addRemoveFav(prodID, context);

      if(!addRemoveFavModels.status) {
        isExists
            ? isFavProdList[prodID] = null
            : isFavProdList.remove(prodID);
        emit(AddToIsFavListState());
      }

      // staticVars.showToast(context, addRemoveFavModels.message);

    }on Exception catch(e){
      print(e);
      return false;
    }finally{
      emit(FavAddRemoveStates());
    }
  }


  AllFavoritesModel allFavoritesModel;
  getAllFavorites(BuildContext context) async{
    try{
      allFavoritesModel = await _favorite.getAllFav(context);

      if(allFavoritesModel.products.isNotEmpty)
        setIsFavList(context ,allFavoritesModel);

    }on Exception catch(e){
      print(e);
    }finally{
      emit(FavAddRemoveStates());
    }
  }



  Future getFavProd(BuildContext context) async{
    for(int i=0 ;i<isFavProdList.length ;i++){
      if(isFavProdList.values.toList()[i] == null){
         Product product = await getProduct(context, isFavProdList.keys.toList()[i]);
         isFavProdList.update(isFavProdList.keys.toList()[i], (value) => product);
         emit(GetFavProductState());
      }
    }
  }


  
  
  
}