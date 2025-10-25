class  CoursesModel {
  final String courseName ;
  final String courseDescription ;
  final String ? coursePrice ;
  final String ? courseDuration ;
  final String courseImage ;
  final int courseId;


  CoursesModel(this.courseName, this.courseDescription, this.coursePrice, this.courseDuration, this.courseImage, this.courseId,);


  factory CoursesModel.fromJson(Map<String, dynamic> json) {
    print(json);
    return CoursesModel(
      json['name'],
      json['description'],
      json['course_price'],
      json['course_duration'],
      json['photo_url'],
      json['id_course'],
    ) ;
  }

}