import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Model/User/UserModel.dart';
import '../../ModelView/HomeScreenProvider.dart';
import '../../utlis/ScreenSize.dart';
import '../CouresDeltiles.dart';
import 'CustomButtomSheet.dart';

class HomeScreen extends StatelessWidget {
  final  UserModel user  ;
   HomeScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeScreenProvider(user),
      child:  Homepage(),
    );
  }
}

class Homepage extends StatelessWidget {
  const Homepage({super.key});


  @override
  Widget build(BuildContext context) {
    final homeScreenProvider = Provider.of<HomeScreenProvider>(context) ;
    return Scaffold(
      backgroundColor: Colors.white,
      body:SafeArea(
        child: Container(
          child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
              ),
                child: ListTile(
                  trailing: IconButton(onPressed: (){
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return Custombuttomsheet () ;
                      },
                    );
                  }, icon: Icon(Icons.settings,color: Colors.blueAccent,)),
                  title: Text(homeScreenProvider.user.phoneNumber),
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/images/person.jpg'),
                  ),
                ),
              ) ,

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('your_courses'.tr(),style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.blueAccent),),
            ) ,
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                height: ScreenSize.height(context)*0.8,
                child: ListView.separated(itemBuilder: (context,index){
                    return Container(
                      decoration: BoxDecoration(
                        color: Color(0xfff6f8fb),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      height: 100,
                      child: ListTile(
                        title: Text( homeScreenProvider.courses[index].courseName,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                        trailing: Image.network(homeScreenProvider.courses[index].courseImage,height: 100,fit: BoxFit.cover,),
                        onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (_)=> CouresdeltilesScreen(coursesModel: homeScreenProvider.courses[index],token: homeScreenProvider.user.token!))) ;
                        },
                      ),
                    ) ;
                }, separatorBuilder: (context,index){
                  return SizedBox(height: 20,) ;
                }, itemCount: homeScreenProvider.courses.length),
              ) ,
        
            ],
          ),
        ),),
      ) ,

    );
  }
}









