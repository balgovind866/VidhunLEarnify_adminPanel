import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_network/image_network.dart';
import 'package:side_sheet/side_sheet.dart';
import 'package:student_admin_panel/features/domain/entity/student_entites.dart';
import 'package:student_admin_panel/features/represantion/subject/add_subject.dart';


import '../../../../../core/widgets/side_bar_widget.dart';
import '../../../../constant/app_colors.dart';
import '../../../../constant/app_sized_box.dart';
import '../../../../constant/app_text.dart';
import '../../../../constant/app_text_style.dart';
import '../../../../constant/route_constants.dart';
import '../../teacher/bloc/teacher_cubit.dart';
import '../../teacher/bloc/teacher_state.dart';
import '../../teacher/widget/right_student_sheet.dart';
import '../blocStudent/student_bloc_cubit.dart';
import 'student_deshboad_details/deshboard.dart';


/// Here [admin] can add/update
/// information of students.

class StudentScreen extends StatefulWidget {
  const StudentScreen({Key? key}) : super(key: key);

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {

  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<StudentBlocCubit>(context).getStudentProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;

    return AdminScaffold(
      backgroundColor: AppColors.secondary.withOpacity(0.2),
      appBar: AppBar(
        backgroundColor: AppColors.black,
        title: Text(
          AppText.schoolManagement,
          style: AppTextStyles.h3.copyWith(color: AppColors.white),
        ),
      ),
      sideBar: SideBarWidget().sideBarMenus(context, RouteList.student),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
              child: GestureDetector(

                child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: myList(context).length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      crossAxisSpacing: 30,

                    ),
                    itemBuilder: (context, index) => myList(context)[index]),
              ),

            ),

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
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(AppText.studentText, style: AppTextStyles.h2),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.primary),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: GestureDetector(
                          onTap: () =>
                              SideSheet.right(
                                context: context, width: size.width * 0.3,
                                body: RightStudentSheet(size: size),
                              ),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              Icon(Icons.add),
                              Text('Add New Student'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            BlocBuilder<StudentBlocCubit, StudentBlocState>(
              builder: (context, state) {
                if (state is StudentLoaded) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      padding: EdgeInsets.all(16),
                      width: size.width,
                      height: size.height,
                      decoration: BoxDecoration(
                        color: Color(0xFF2A2D3E),
                        borderRadius: const BorderRadius.all(Radius.circular(
                            10)),
                      ),


                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Register Student",
                                  style: AppTextStyles.h2.copyWith(
                                      color: Colors.white),
                                ),
                              ),

                              Expanded(
                                child: TextField(
                                  style: TextStyle(color: Colors.white),
                                  onChanged: (value) {
                                    BlocProvider.of<StudentBlocCubit>(context)
                                        .searchStudentsByRollNumber(value);
                                  },
                                  decoration: InputDecoration(

                                    enabled: true,
                                    fillColor: Colors.blue,
                                    contentPadding:
                                    const EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 15),
                                    hintText: "Search",
                                    hintStyle: TextStyle(color: Colors.white),
                                    suffixIcon: const Icon(
                                      Icons.search, color: Colors.white,),
                                    // prefix: Icon(Icons.search),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      borderSide: BorderSide(
                                          color: Colors.white),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      borderSide: BorderSide(color: Colors
                                          .white), // Border color when not focused
                                    ),

                                  ),
                                ),
                              ),

                            ],
                          ),
                          SizedBox(height: 20,),

                          SizedBox(
                            width: double.infinity,
                            child: DataTable(
                                headingRowColor: MaterialStateColor
                                    .resolveWith((states) => Colors.blue[200]!),
                                headingTextStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                dataRowColor: MaterialStateColor.resolveWith((
                                    states) => Colors.blue[50]!),
                                columnSpacing: 16,
                                columns: [

                                  DataColumn(
                                    label: Text("File Name"),
                                  ),
                                  DataColumn(
                                    label: Text("Roll Number"),
                                  ),
                                  DataColumn(
                                    label: Text("Course"),
                                  ),
                                  DataColumn(
                                    label: Text("Gmail"),
                                  ),
                                  DataColumn(
                                    label: Text("Details"),
                                  ),
                                  DataColumn(
                                    label: Text("Remove"),
                                  ),

                                ],
                                rows: state.students!.map((e) {
                                  return DataRow(cells: [
                                    DataCell(Text(e.fullName.toString())),
                                    DataCell(Text(e.rollNumber.toString())),
                                    DataCell(Text(e.course.toString())),
                                    DataCell(Text(e.email.toString())),
                                    DataCell(
                                      ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty
                                              .resolveWith<Color>((states) {
                                            // Change button color when clicked
                                            if (states.contains(
                                                MaterialState.pressed)) {
                                              //  isButtonClicked = true;
                                              return Colors
                                                  .green; // Change to the desired color when clicked
                                            }
                                            return Colors
                                                .blue; // Default button color
                                          }),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pushReplacementNamed(RouteList
                                              .studentDeshbBoardDetail);

                                          // Call a function with the UID when the button is clicked
                                          // onViewButtonClicked(e.uid);
                                        },
                                        child: Text(
                                          'View',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    DataCell(IconButton(onPressed: () {},
                                      icon: Icon(
                                        Icons.delete, color: Colors.red,),)),

                                  ]);
                                }).toList()
                            ),
                          )


                        ],
                      ),

                    ),
                  );
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

List<Widget> myList(context){
    return  [
      GestureDetector(
        onTap: (){
          Navigator.push(context,MaterialPageRoute(builder: (context)=>AddSubject()));


        },
        child: Container(
          height: 10, // Set the desired height of the Container
          width: 10,
          decoration: BoxDecoration(
            color:AppColors.secondary.withOpacity(0.8),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Center(child: Text('Add Subject',style: AppTextStyles.h4.copyWith(color: Colors.white))),
        ),
      ),
      GestureDetector(
        onTap: (){

        },
        child: Container(
          height: 10, // Set the desired height of the Container
          width: 10,
          decoration: BoxDecoration(
            color:AppColors.secondary.withOpacity(0.8),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),

          child: Center(child: Text('Add Class',style: AppTextStyles.h4.copyWith(color: Colors.white))),
        ),
      ),
      Container(
        height: 10, // Set the desired height of the Container
        width: 10,
        decoration: BoxDecoration(
          color:AppColors.secondary.withOpacity(0.8),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),

        child: Center(child: Text('Add result',style: AppTextStyles.h4.copyWith(color: Colors.white))),
      ),
      Container(
        height: 10, // Set the desired height of the Container
        width: 10,
        decoration: BoxDecoration(
          color:AppColors.secondary.withOpacity(0.8),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),

        child: Center(child: Text('Add Course',style: AppTextStyles.h4.copyWith(color: Colors.white),)),
      ),
      Container(
        height: 10, // Set the desired height of the Container
        width: 10,
        decoration: BoxDecoration(
          color:AppColors.secondary.withOpacity(0.8),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),

        child: Center(child: Text('Add Notice',style: AppTextStyles.h4.copyWith(color: Colors.white))),
      ),

    ];
}




