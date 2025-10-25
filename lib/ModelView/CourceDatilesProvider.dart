import 'package:flutter/cupertino.dart';

import '../Model/CoursesModel/CoursesModel.dart';
import '../Model/CoursesModel/CourstLecture.dart';
import '../Model/Repositry/UserReospirty.dart';


class CourseDetilesProvider extends ChangeNotifier {
  UserRepository userRepository = UserRepository();
  final  CoursesModel coursesModel ;
 final  String token ;
 bool _showDetails = false ;

  bool get showDetails => _showDetails;

  set showDetails(bool value) {
    _showDetails = value;
    notifyListeners();
  }

  CourseDetilesProvider( this.token, this.coursesModel){
    getCourseVideos() ;
  }

  List <CourseLecture> videosCourse = [] ;
  void getCourseVideos() async{
    final response = await userRepository.getCourseVideos(token, coursesModel.courseId);
    response.fold((videos){
      print(videos);
      videosCourse = videos ;
      notifyListeners();
    }, (e){
      print(e);

    });

  }

}