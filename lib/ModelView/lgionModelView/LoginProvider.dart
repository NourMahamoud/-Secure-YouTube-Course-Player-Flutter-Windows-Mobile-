import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import '../../Model/Repositry/UserReospirty.dart';
import '../../Service/shared_preferences/keys.dart';
import '../../Service/shared_preferences/shared_preferences.dart';
import '../../View/HomeScreen/HomePage.dart';
import '../../utlis/CusromSnackBar/CustomSnackBar.dart';
import 'package:flutter/material.dart';

class SignInProvider extends ChangeNotifier {
  final SharedPreferenceHelper sharedPreferenceHelper = SharedPreferenceHelper() ;
  final UserRepository function = UserRepository();
  final formKey = GlobalKey<FormState>();
  late final TextEditingController emailController ;
  late final TextEditingController passwordController ;
  bool isObscure = true;
  SignInProvider() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void togglePasswordVisibility()  {
    isObscure = !isObscure;
    notifyListeners();
  }
  void changeLang(String lang,context){
    Locale newLocale;
    if (lang == 'ar') {
      newLocale = const Locale('ar', 'EG');
      notifyListeners() ;
    } else {
      newLocale = const Locale('ru', 'RU');
      notifyListeners() ;
    }
    EasyLocalization.of(context)!.setLocale(newLocale);
    sharedPreferenceHelper.saveString(context.locale.languageCode,'lang' ) ;
  }

  void signIn(String phoneNumber, String password, BuildContext context)async {
    if (formKey.currentState!.validate()){
       final response = await function.signIn(phoneNumber, password) ;
       response.fold((user)async{
           await sharedPreferenceHelper.saveString(user.token!, SharedKeys.tokenkey) ;
            await sharedPreferenceHelper.saveString(user.phoneNumber, SharedKeys.phoneNumberkey) ;
         CustomSnackBar.showSuccess(context, 'Login Successfully') ;
         Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>  HomeScreen(user: user))) ;

       }, (error){
         CustomSnackBar.showError(context, error) ;
       }) ;
      //  function.signIn(login.emailController.text, login.passwordController.text, context) ;
    }
  }
}