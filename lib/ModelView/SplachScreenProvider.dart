import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Elmotakhasas/Model/User/UserModel.dart';
import 'package:Elmotakhasas/View/loginScreen/LoginScreen.dart';
import '../Service/shared_preferences/keys.dart';
import '../Service/shared_preferences/shared_preferences.dart';
import '../View/HomeScreen/HomePage.dart';

class SplacheScreenProvider extends ChangeNotifier {
  SharedPreferenceHelper sharedPreferenceHelper = SharedPreferenceHelper();
  SplacheScreenProvider();
  void checkUser (context)async{
    print('check user') ;
    await sharedPreferenceHelper.initSharedPreferences();
    final phoneNumber = await sharedPreferenceHelper.getString(SharedKeys.phoneNumberkey)  ;
    final token = await sharedPreferenceHelper.getString(SharedKeys.tokenkey) ;
    print(token) ;
    if(token != null && phoneNumber != null){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>  HomeScreen(user: UserModel(token, phoneNumber: phoneNumber, password: '')))) ;
    }else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=> const LoginPage())) ;
    }

  }
}