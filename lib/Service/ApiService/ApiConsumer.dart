import '../../Model/User/UserModel.dart';

abstract class  ApiConsumer {
  Future  postUser ({required UserModel user,required String endPoint});
  Future <Map<String,dynamic>> getCourses({required String token,required String endPoint}) ;
  Future <Map<String,dynamic>> getCourseVideos({required String token, required int courseId}) ;

}