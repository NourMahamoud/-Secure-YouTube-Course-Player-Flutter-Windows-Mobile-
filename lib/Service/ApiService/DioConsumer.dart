import 'package:dio/dio.dart';
import 'package:Elmotakhasas/Model/User/UserModel.dart';

import 'ApiConsumer.dart';


class  DioConsumer extends ApiConsumer {
  final Dio dio = Dio();

  @override
  Future<Map<String, dynamic>> getCourseVideos({required String token, required int courseId}) async{
     try {
       final response = await dio.get('https://amressa.top/api/course_videos.php',options: Options(
           headers: {
             'Content-Type': 'application/json',
             'Accept': 'application/json',
             'Authorization': 'Bearer ${token}', }
       ),queryParameters:  {
       "course_id": courseId,
       },


       ) ;
       print(response.data);
       return response.data ;
     } on Exception catch (e) {
       print(e.toString());
       return {'error': e.toString()};
     }
  }

  @override
  Future<Map<String, dynamic>> getCourses({required String token, required String endPoint})async {
   try {
     final  response = await dio.get('https://amressa.top/api/my_courses.php',options: Options(
       headers: {
         'Content-Type': 'application/json',
         'Accept': 'application/json',
         'Authorization': 'Bearer ${token}', }
     )) ;
     print(response.data);

     return response.data ;
   }catch (e){
       return {'error': e.toString()} ;
   }
  }

  @override
  Future  postUser({required UserModel user, required String endPoint}) async {
    try {
      final response  = await dio.post(
          'https://amressa.top/api/login.php',
          data: {
            "user_name": user.phoneNumber,
            "password": user.password,
          },
        );
       if (response.statusCode == 200) {
         print('Dio Done');
         print(response);
         return response.data;
       }else {
         print("Dio Filed");
         return response.statusCode ;
       }
    }catch (e){
      print(e.toString());
      return e.toString() ;
    }

  }


}