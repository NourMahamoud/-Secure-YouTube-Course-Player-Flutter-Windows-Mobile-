import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../ModelView/SplachScreenProvider.dart';
import '../utlis/ScreenSize.dart';

class Splachscreen extends StatelessWidget {
  const Splachscreen({super.key});
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3),(){
      SplacheScreenProvider().checkUser(context) ;

    }) ;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Center(child: Image(image:AssetImage('assets/images/logo.png'),height: ScreenSize.height(context) *0.8,)),
          Text('splash_text'.tr(),style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.black),)
        ],
      ) );
  }
}
