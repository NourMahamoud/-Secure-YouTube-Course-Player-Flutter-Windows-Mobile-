import 'package:dartz/dartz.dart';

import '../../Service/ApiService/DioConsumer.dart';
import '../../Service/ApiService/EndPonits.dart';
import '../CoursesModel/CoursesModel.dart';
import '../CoursesModel/CourstLecture.dart';
import '../User/UserModel.dart';

class UserRepository {
  final DioConsumer dioConsumer = DioConsumer();

  Future<Either<UserModel, String>> signIn(String phoneNumber, String password) async {
    try {
      final response = await dioConsumer.postUser(
        user: UserModel(
          null, // token initially null
          phoneNumber: phoneNumber.trim(),
          password: password,
        ),
        endPoint: ApiConstants.login,
      );

      print("Response from server: $response");

      if (response['token'] != null) {
        final user = UserModel(
          response['token'],
          phoneNumber: phoneNumber,
          password: password,
        );
        return Left(user);
      } else {
        return Right("Invalid credentials or no token returned");
      }
    } catch (e) {
      return Right(e.toString());
    }
  }


  Future<Either<List<CoursesModel>, String>> getCourses(String token) async {
      final response = await dioConsumer.getCourses(token: token, endPoint:'/my_courses.php') ;
      if (response['courses'] != null) {
        final courses = (response['courses'] as List)
            .map((course) => CoursesModel.fromJson(course))
            .toList();
        print(courses);
        return Left(courses);
      } else {
        print(response);
        return Right("No courses found");
      }
  }

  Future <Either<List<CourseLecture>,String>> getCourseVideos(String token,int courseId) async{
    final response = await dioConsumer.getCourseVideos(token: token, courseId: courseId) ;

    try {
      if (response['videos'] != null) {
        final videos = (response['videos'] as List)
            .map((video) => CourseLecture.fromJson(video))
            .toList();
        print(videos);
        return Left(videos);
      } else {
        print(response);
        return Right("No videos found");
      }
    } on Exception catch (e) {
      return Right(e.toString());
    }
  }

}
