import 'package:flutter_localizations/flutter_localizations.dart';

import 'cubit/addressCubit/addressCubit.dart';
import 'cubit/cartCubit/cartCubit.dart';
import 'cubit/categories/categoriesCubit.dart';
import 'cubit/favoritesCubit/favoritesCubit.dart';
import 'cubit/homeCubit/homeCubit.dart';
import 'cubit/loginCubit/verifyCubit/verifyCubit.dart';
import 'cubit/profileCubit/profileCubit.dart';
import 'cubit/loginCubit/loginCubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home.dart';
import 'shared/components/restartWidget.dart';
import 'shared/localization/demo_localization.dart';
import 'shared/localization/language_constants.dart';
import 'shared/styles/colors.dart';
import 'cubit/profileCubit/updateProfileCubit.dart';


void main() async{
  runApp(
      RestartWidget(
      child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context)=> LoginCubit()..getIsLoginStored()),
            BlocProvider(create: (context)=> ProfileCubit()),
            BlocProvider(create: (context)=> AddressCubit()),
            BlocProvider(create: (context)=> UpdateProfileCubit()),
            BlocProvider(create: (context)=> VerifyCubit()),
            BlocProvider(create: (context)=> CategoriesCubit()..getCategoriesModel(context)..getAllFavorites(context) ),
            BlocProvider(create: (context)=> HomeCubit()..getLang()..getHomeData(context)),
            BlocProvider(create: (context)=> FavoritesCubit()),
            BlocProvider(create: (context)=> CartCubit()..getCarts(context)),
          ],
          child: MyApp()),
    )
  );
}

class MyApp extends StatefulWidget {

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(newLocale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  // localization =>
  Locale _locale;
  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }
  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        this._locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      // localization =>
      locale: _locale,
      supportedLocales: [
        Locale("ar", ""),
        Locale("en", ""),
      ],
      localizationsDelegates: [
        DemoLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },

      home: Home(),
      debugShowCheckedModeBanner: false,
      theme: appClrs.appThem(),
      themeMode: ThemeMode.light,


    );
  }
}

