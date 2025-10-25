
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
class SharedPreferenceHelper{
  static  SharedPreferences? _sharedPreferences;


 Future initSharedPreferences() async{
  _sharedPreferences = await SharedPreferences.getInstance();

}
Future <bool> saveString(String token, String key) async{
  return await _sharedPreferences!.setString(key, token);
}
Future <String?> getString(String key) async{
  return await _sharedPreferences!.getString(key);

}
Future  removeString(String key) async{
   _sharedPreferences!.remove(key);
}

}