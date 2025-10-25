import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../Model/CoursesModel/CoursesModel.dart';
import '../ModelView/CourceDatilesProvider.dart';
import 'package:provider/provider.dart';
import '../utlis/ScreenSize.dart';
import 'ShowCourse.dart';
import 'Windows/ShowVideoOnWindows.dart';
class CouresdeltilesScreen extends StatelessWidget {
   CouresdeltilesScreen({super.key, required this.coursesModel, required this.token});
  final  CoursesModel coursesModel ;
  final String token ;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (_)=>CourseDetilesProvider( token, coursesModel) ,
      child: Couresdeltiles(),
    );
  }
}

class Couresdeltiles extends StatelessWidget {
   Couresdeltiles({super.key});

  @override
  Widget build(BuildContext context) {
    final courseDetilesProvider = Provider.of<CourseDetilesProvider>(context) ;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(courseDetilesProvider.coursesModel.courseName),
      ),
      body: SafeArea(child: Container(
        height: ScreenSize.height(context),
        width: ScreenSize.width(context),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
            SizedBox(height: 20,) ,
              Card(
                color: Colors.white,
                child: ListTile(
                  title: Text(courseDetilesProvider.coursesModel.courseName,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.right,),
                  leading: Icon(Icons.arrow_drop_down),
                  onTap: (){
                    courseDetilesProvider.showDetails = !courseDetilesProvider.showDetails ;
                  },
                ),
              ),
              Container(

                width: ScreenSize.width(context),
                child: Visibility(
                  visible: courseDetilesProvider.showDetails,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text('course_details'.tr(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.right,),
                    Text(courseDetilesProvider.coursesModel.courseDescription,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  ],
                )),
              ) ,
                Text('videos'.tr(),style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),textAlign: TextAlign.right,) ,
                SizedBox(height: 20,),
                Container(
                  height: ScreenSize.height(context) *0.7,
                  child: ListView.separated(itemBuilder: (context,index){
                    return Container(

                      decoration: BoxDecoration(
                        color: Color(0xfff6f8fb),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      height: 70,
                      child: ListTile(
                        title: Text(courseDetilesProvider.videosCourse[index].name,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
                        leading: Image.network('${courseDetilesProvider.videosCourse[index].lecture_photo_url}',height: 120,fit: BoxFit.fill,),
                        onTap: ()async{
                          if (Platform.isWindows) {
                          Navigator.of(context).push(MaterialPageRoute(builder: (_)=>YoutubePlayerWindows(videoId: courseDetilesProvider.videosCourse[index].youtube_id,)));
                        } else {
                           Navigator.of(context).push(MaterialPageRoute(builder: (_)=> VideoPlayerScreen(videoId: courseDetilesProvider.videosCourse[index].youtube_id,)) );
                      }
                        },

                    ));
                  }, separatorBuilder: (context, index){
                    return SizedBox(height: 10,) ;
                  }, itemCount: courseDetilesProvider.videosCourse.length),
                )




              ],
            ),
          ),
        )
      ),)
    );
  }
}
