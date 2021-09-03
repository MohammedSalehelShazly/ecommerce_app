import 'package:shared_preferences/shared_preferences.dart';

SharedPreferencesHelper sharedPreferencesHelper = SharedPreferencesHelper();

class SharedPreferencesHelper{

  Future<String> getToken() async{
    String token;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ??'';
    print('token $token');
    return token;
  }

  setToken(String token) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }


  Future<void> setAddressID(int addressID) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('addressID', addressID);
  }
  Future<int> getAddressID() async{
    int addressID;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    addressID = prefs.getInt('addressID') ??-1;
    return addressID;
  }


  Future<void> setSearchWord(String searchWord ,bool add) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> searchWords = await getSearchWord();
    add
        ? searchWords.add(searchWord)
        : searchWords.remove(searchWord);
    prefs.setStringList('searchWords', searchWords);
  }

  Future<List<String>> getSearchWord() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> searchWords = prefs.getStringList('searchWords') ??[];
    return searchWords;
  }

  Future clearAll() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }




}