import 'package:flutter/cupertino.dart';
import 'package:Elmotakhasas/Model/Repositry/UserReospirty.dart';
import 'package:Elmotakhasas/Model/User/UserModel.dart';

import '../Model/CoursesModel/CoursesModel.dart';

class HomeScreenProvider extends  ChangeNotifier{

  final UserModel user ;
  HomeScreenProvider(this.user){
    getCourses() ;

  }

  final UserRepository userRepository = UserRepository();
  List <CoursesModel> courses = [] ;
  void  getCourses() async{
    final response = await userRepository.getCourses(user.token!) ;
    response.fold((courses){
      print(courses);
      this.courses = courses ;
      notifyListeners();
    }, (e){
      print(e);
    }) ;




    }


}