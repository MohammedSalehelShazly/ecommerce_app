import 'urlLauncherHelper.dart';
import 'package:flutter/material.dart';

import 'ContactUsItem.dart';

class ContactUsList extends StatelessWidget {
  BuildContext sContext;
  ContactUsList(this.sContext);

  UrlLauncherHelper urlLauncherHelper()=> UrlLauncherHelper(sContext);

  Map<String ,Function> circleContent ()=>{
    'assets/images/gif_logo_facebook.gif' : ()=>urlLauncherHelper().facebook(),
    'assets/images/gif_logo_github.gif' : ()=>urlLauncherHelper().website(UrlsLauncher.githubUrl),
    'assets/images/gif_logo_gmail.gif' : ()=>urlLauncherHelper().sendMail(),
    'assets/images/gif_logo_linkedin.gif' : ()=>urlLauncherHelper().website(UrlsLauncher.linkedInUrl),
    'assets/images/gif_logo_whatsapp.gif' : ()=>urlLauncherHelper().whattsapp(),
    'assets/images/gif_logo_youtube.gif' : ()=>urlLauncherHelper().website(UrlsLauncher.youtubeChannelUrl),
  };

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List<ContactUsItem>.generate(circleContent().length, (index) =>

            ContactUsItem(
              length: circleContent().length,
              img: circleContent().keys.toList()[index],
              function: circleContent().values.toList()[index],
              rotateDirection: (index+1) <=(circleContent().length/2)
                  ? RotateDirection.toRight
                  : RotateDirection.toLeft,
            )
        )
      ),
    );
  }
}
