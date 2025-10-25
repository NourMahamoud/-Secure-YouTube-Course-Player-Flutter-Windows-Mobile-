import 'package:flutter/cupertino.dart';

import '../Model/CoursesModel/CoursesModel.dart';
import '../Model/Repositry/UserReospirty.dart';
import '../Model/User/UserModel.dart';

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