

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_network/image_network.dart';
import 'package:side_sheet/side_sheet.dart';

import '../../../../constant/app_colors.dart';
import '../../../../constant/app_text.dart';
import '../../../../constant/app_text_style.dart';
import '../../../../constant/route_constants.dart';
import '../../../../core/widgets/side_bar_widget.dart';
import '../../../domain/entity/teacher_entities.dart';

import '../bloc/teacher_cubit.dart';
import '../bloc/teacher_state.dart';
import '../widget/right_teacher_sheet.dart';

/// Here [admin] can add/update
/// information of teachers.

class TeacherScreen extends StatefulWidget {
  const TeacherScreen({Key? key}) : super(key: key);

  @override
  State<TeacherScreen> createState() => _TeacherScreenState();
}

class _TeacherScreenState extends State<TeacherScreen> {
  @override
  void initState() {
    BlocProvider.of<TeacherCubit>(context).getTeacher();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {


    final size = MediaQuery.of(context).size;
    return AdminScaffold(
      backgroundColor: AppColors.secondary.withOpacity(0.2),
      appBar: AppBar(
        backgroundColor: AppColors.black,
        title: Text(
          AppText.schoolManagement,
          style: AppTextStyles.h3.copyWith(color: AppColors.white),
        ),
      ),
      sideBar: SideBarWidget().sideBarMenus(context, RouteList.teacher),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 18),
              child: Container(
                width: size.width * 0.8,
                height: size.height * 0.13,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withOpacity(0.5),
                      blurRadius: 5,
                      spreadRadius: 1,
                      offset: const Offset(0,0),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(AppText.teacherText, style: AppTextStyles.h2),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.primary),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: GestureDetector(
                          onTap: () => SideSheet.right(context: context, width: size.width * 0.3,
                           body: RightTeacherSheet(size: size),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              Icon(Icons.add),
                              Text(AppText.addTeacher),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),



            BlocBuilder<TeacherCubit, TeacherState>(
              builder: (context, state) {
                if (state is TeacherLoaded) {

                  return Container(
                    width: size.width,
                    height: size.height,


                    child: GridView.builder(
                      itemCount: state.teachers.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 16.0,
                        crossAxisSpacing: 16.0,
                      ),
                      itemBuilder: (context, index) {
                        final List<TeacherEntity> teacherData = state.teachers;





                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          elevation: 5,
                          margin: EdgeInsets.all(8),
                          child: Padding(
                            padding: EdgeInsets.all(12),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 70,
                                  child: ImageNetwork(
                                    image: teacherData[index].teacherImage.toString() ,
                                    height: 150,
                                    width: 150,
                                    duration: 1500,
                                    curve: Curves.easeIn,
                                    onPointer: true,
                                    debugPrint: false,
                                    fullScreen: false,
                                    fitAndroidIos: BoxFit.cover,
                                    fitWeb: BoxFitWeb.cover,
                                    borderRadius: BorderRadius.circular(70),
                                    onLoading: const CircularProgressIndicator(
                                      color: Colors.indigoAccent,
                                    ),
                                    onError: const Icon(
                                      Icons.error,
                                      color: Colors.red,
                                    ),
                                    onTap: () {
                                      debugPrint("©gabriel_patrick_souza");
                                    },
                                  )
                                  /*Image.network(
                                    teacherData[index].teacherImage.toString(),
                                    loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      } else {
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value: loadingProgress.expectedTotalBytes != null
                                                ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                                                : null,
                                          ),
                                        );
                                      }
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      return Text('Error loading image');
                                    },
                                  ),*/
                            ),

                                SizedBox(height: 12),
                                Text(
                                  'Teacher Name :- ${teacherData[index].teacherName}',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Subject: Mathematics',
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Experience: 5 years',
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Qualification: M.Sc in Mathematics',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ) ;
                } else if (state is TeacherLoading) {
                  // Loading indicator while data is being fetched
                  return CircularProgressIndicator();
                } else if (state is TeacherFailure) {
                  // Handle error state if necessary
                  return Text('Failed to load teacher data');
                } else {
                  // Handle other states if needed
                  return Center(
                    child: Text('Unknown state'),
                  );
                }
              },
            ),
            ],
        ),
      ),
    );
  }
}
/*Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white.withOpacity(0.8),


                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: GestureDetector(

                                onTap: () {
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [


                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(routineSnapshot['teacherName'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                                        SizedBox(height: 10,),

                                      ],
                                    ),
                                    SizedBox(width: 20,),

                                    IconButton(
                                      icon: Icon(Icons.delete,size: 30,),
                                      onPressed: () {
                                        FirebaseFirestore.instance
                                            .collection('daily_routines')
                                            .doc(routineSnapshot.id)
                                            .delete();
                                      },
                                    ),
                                  ],
                                )

                              /*ListTile(

                                  shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                              side: BorderSide(
                              color: Colors.green,
                              width: 2.0,
                              ),
                                  ),
                                title: Text(routineSnapshot['name'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),

                                subtitle: Row(
                                  children: [
                                    Icon(Icons.access_time_filled),
                                    SizedBox(width: 3,),
                                    Text('$timeString-$timeStringEnd'),
                                  ],
                                ),

                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [

                                    IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () {
                                        FirebaseFirestore.instance
                                            .collection('daily_routines')
                                            .doc(routineSnapshot.id)
                                            .delete();
                                      },
                                    ),
                                  ],
                                ),
                              ),*/
                            ),
                          ),

                        );*/

