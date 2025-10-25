import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../Service/shared_preferences/shared_preferences.dart';
import '../../utlis/ScreenSize.dart';
import '../loginScreen/LoginScreen.dart';

class Custombuttomsheet extends StatelessWidget {
  const Custombuttomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),

      height: ScreenSize.height(context)*0.3,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
      ),
      child: Column(
        spacing: 10,
        children: [
          SizedBox(height: 20,),
        Card(
        elevation: 10,
        color: Colors.white,
        child: ListTile(
          title:Text('logout'.tr()),
          leading: Icon(Icons.logout),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: (){
            SharedPreferenceHelper().initSharedPreferences();
            SharedPreferenceHelper().removeString('token');
            SharedPreferenceHelper().removeString('phoneNumber');
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_)=> LoginPage()), (route) => false,);

          },
        ),

      ),
          Card(
            elevation: 10,
            color: Colors.white,
            child: ListTile(
              title: Text('change_language'.tr()),
              onTap: (){
                if (context.locale.languageCode == 'ar') {
                  context.setLocale(const Locale('ru', 'RU'));
                } else {
                  context.setLocale(const Locale('ar', 'EG'));
                }
                SharedPreferenceHelper().initSharedPreferences();
                SharedPreferenceHelper().saveString(context.locale.languageCode, 'lang');

              },
              leading: Icon(Icons.translate),
              trailing: Icon(Icons.arrow_forward_ios),
            ),


          ),

        ],
      ),
    );
  }
}
