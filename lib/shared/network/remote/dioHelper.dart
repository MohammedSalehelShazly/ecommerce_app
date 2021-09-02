import 'package:dio/dio.dart';
import '../../../cubit/loginCubit/loginCubit.dart';
import '../../../shared/localization/language_constants.dart';
import 'package:flutter/cupertino.dart';

class DioHelper{

  Dio _dio = Dio();

  Future<Response> post(BuildContext context ,{
    @required String path,
    Map<String ,dynamic> body,
    bool withToken = true,
  }) async{

    Locale appLang = await getLocale();
    Response post = await _dio.post(path,
      options: Options(headers: {
        if(withToken)
          'Authorization' : LoginCubit.get(context).token,
        'lang' : appLang.languageCode,
        'Content-Type' : 'application/json'
      }),
      queryParameters: body ??{}
    );
    return post;
  }


  Future<Response> get(BuildContext context ,{
    @required String path,
    Map<String ,dynamic> body,
    bool withHeaders = true
  }) async{

    print('......token +${LoginCubit.get(context).token}');

    Locale appLang = await getLocale();
    Response get = await _dio.get(path,
        options: withHeaders
          ? Options(headers: {
          'Authorization' : LoginCubit.get(context).token,
          'lang' : appLang.languageCode,
          'Content-Type' : 'application/json'
        }) : null,
        queryParameters: body ??{}
    );
    return get;
  }

  Future<Response> put(BuildContext context ,{
    @required String path,
    @required Map<String ,dynamic> body,
  }) async{
    Locale appLang = await getLocale();
    Response get = await _dio.put(path,
        options: Options(headers: {
          'Authorization' : LoginCubit.get(context).token,
          'lang' : appLang.languageCode,
          'Content-Type' : 'application/json'
        }),
        queryParameters: body ??{}
    );
    return get;
  }


  Future<Response> delete(BuildContext context ,{
    @required String path,
    Map<String ,dynamic> body,
  }) async{
    Locale appLang = await getLocale();
    Response get = await _dio.delete(path,
        options: Options(headers: {
          'Authorization' : LoginCubit.get(context).token,
          'lang' : appLang.languageCode,
          'Content-Type' : 'application/json'
        }),
        queryParameters: body ??{}
    );
    return get;
  }

}