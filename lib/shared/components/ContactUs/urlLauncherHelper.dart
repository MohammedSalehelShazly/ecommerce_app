import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../localization/language_constants.dart';

import 'package:url_launcher/url_launcher.dart';


enum UrlsLauncher{
  githubUrl,
  youtubeChannelUrl,
  linkedInUrl
}


class UrlLauncherHelper{

  BuildContext context;
  UrlLauncherHelper(this.context);

  final _phoneWhattsapp = '+201285284470';
  final _email = 'ma7madsalle7@gmail.com';
  final _facebookUsername = 'Mohammed.saleh.elshazly';
  final _githubUrl = 'https://github.com/MohammedSalehelShazly';
  final _youtubeChannelUrl = 'https://www.youtube.com/channel/UCjU0nmN3a8DrWkfdpo6RdXA';
  final _linkedInUrl = 'https://www.linkedin.com/in/mohammed-saleh-6162261a3/';

  String _enumToUrlStr(UrlsLauncher urlsLauncher){
    switch(urlsLauncher){
      case UrlsLauncher.githubUrl:
        return _githubUrl; break;
      case UrlsLauncher.youtubeChannelUrl:
        return _youtubeChannelUrl; break;
      case UrlsLauncher.linkedInUrl:
        return _linkedInUrl; break;
      default:
        return _linkedInUrl; break;
    }
  }

  _showSnackBar(String msg){
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg ,style: TextStyle(color: Colors.white),),
      backgroundColor: Color(0xff303030),
      duration: Duration(seconds: 2),
    ));
  }



  sendMail(){
    String encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }

    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: _email,
      query: encodeQueryParameters(<String, String>{
        'subject': getTranslated(context, 'Its about lifestyle app')
      }),
    );

    launch(emailLaunchUri.toString(),
      forceSafariVC: false,
      forceWebView: false,
    );
  }

  whattsapp() async{
    var whatsappUrl ="whatsapp://send?phone=$_phoneWhattsapp";
    await canLaunch(whatsappUrl) ? launch(whatsappUrl,
      forceSafariVC: false,
      forceWebView: false,
    )
        : _showSnackBar(getTranslated(context, 'whattsapp is not installed!'));
  }
  facebook() async{
    var facebookUrl ="https://fb.me/$_facebookUsername";
    await canLaunch(facebookUrl) ? launch(facebookUrl,
      forceSafariVC: false,
      forceWebView: false,
    )
        : _showSnackBar(getTranslated(context, 'facebook is not installed!'));
  }
  messenger() async{
    var messengerUrl ="https://m.me/$_facebookUsername";
    await canLaunch(messengerUrl) ? launch(messengerUrl,
      forceSafariVC: false,
      forceWebView: false,
    )
        : _showSnackBar(getTranslated(context, 'messenger is not installed!'));
  }

  website(UrlsLauncher urlsLauncher) async{
    await canLaunch( _enumToUrlStr(urlsLauncher) ) ? launch( _enumToUrlStr(urlsLauncher),
      forceSafariVC: false,
      forceWebView: false,
    )
        : _showSnackBar(getTranslated(context, 'some error are happened'));
  }

}