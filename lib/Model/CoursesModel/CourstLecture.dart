class CourseLecture {
  final int id_video ;
  final String name  ;
  final String  lecture_photo_url ;

  CourseLecture(this.id_video, this.name, this.lecture_photo_url,
      this.youtube_id);

  final  String  youtube_id ;

  factory CourseLecture.fromJson(Map<String, dynamic> json) {
    print(json);
    return CourseLecture(
      json['id_video'],
      json['name'],
      json['lecture_photo_url'],
      json['youtube_id'],
    );
  }

}