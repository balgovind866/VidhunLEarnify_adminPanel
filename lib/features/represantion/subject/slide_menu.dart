import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:student_admin_panel/constant/app_colors.dart';
import 'package:student_admin_panel/constant/app_text.dart';
import 'package:student_admin_panel/constant/app_text_style.dart';
import 'package:student_admin_panel/features/data/modal/subject_model.dart';
import 'package:student_admin_panel/features/domain/entity/subject_entites.dart';
import 'package:student_admin_panel/features/represantion/subject/subject_bloc/subject_cubit.dart';

import '../../../core/widgets/common_text_field.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  final _subjectController = TextEditingController();
  final _subjectcodeController = TextEditingController();
  final _branchController = TextEditingController();


  TimeOfDay _selectedTime = TimeOfDay.now();
  TimeOfDay _selectedTimeEnd = TimeOfDay.now();


  List<bool> _daysSelected = List.generate(7, (_) => false);


  void saveSelectedDays() {
    // Saving selected days to your database or API
    for (int i = 0; i < _daysSelected.length; i++) {
      bool isSelected = _daysSelected[i];
      String dayName = _dayName(i); // Get the name of the day (Mon to Sun)

      // Save 'dayName' and 'isSelected' to your database or API
      // Perform your save operation here
    }
  }
  @override
  void initState() {

    saveSelectedDays();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: ListView(
          children: [

            SizedBox(
              height: 20,
            ),
            Text('Subject Name',style: AppTextStyles.h4.copyWith(color: Colors.black,fontWeight: FontWeight.bold),),
            SizedBox(
              height: 10,
            ),
            Container(


              decoration: BoxDecoration(
                color: Colors.white,

              ),

              child: CommonTextField(
                controller: _subjectController,
                label:'Subject Name',
                hint: AppText.enterTeacherDesignation,
                validator: (value) {
                  if (value!.length < 3) {
                    return AppText.designationError;
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text('Subject Code',style: AppTextStyles.h4.copyWith(color: Colors.black,fontWeight: FontWeight.bold),),
            SizedBox(
              height: 10,
            ),

            SizedBox(
              height: 10,
            ),
            Container(


              decoration: BoxDecoration(
                color: Colors.white,

              ),

              child: CommonTextField(
                controller: _subjectcodeController,
                label:'Subject Name',
                hint: AppText.enterTeacherDesignation,
                validator: (value) {
                  if (value!.length < 3) {
                    return AppText.designationError;
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text('Branch',style: AppTextStyles.h4.copyWith(color: Colors.black,fontWeight: FontWeight.bold),),

            SizedBox(
              height: 10,
            ),
            Container(


              decoration: BoxDecoration(
                color: Colors.white,

              ),

              child: CommonTextField(
                controller: _branchController,
                label:'Branch',
                hint: AppText.enterTeacherDesignation,
                validator: (value) {
                  if (value!.length < 3) {
                    return AppText.designationError;
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Wrap(
              children: List<Widget>.generate(
                7,
                    (index) => Padding(
                  padding: EdgeInsets.all(4),
                  child: FilterChip(
                    selectedColor: Colors.green.shade200,
                    label: Text(_dayName(index)),
                    onSelected: (bool selected) {
                      setState(() {
                        _daysSelected[index] = selected;
                      });
                    },
                    selected: _daysSelected[index],
                  ),
                ),
              ),
            ),

            SizedBox(height: 16),
            Text(' Starting time',style: AppTextStyles.h4.copyWith(color: Colors.black,fontWeight: FontWeight.bold),),
            ListTile(
              title: Text('Time: ${_selectedTime.format(context)}',style: AppTextStyles.h4.copyWith(color: Colors.black,fontWeight: FontWeight.bold),),
              trailing: Icon(Icons.edit,color: Colors.white,),
              onTap: () async {
                TimeOfDay? newTime = await showTimePicker(
                  context: context,
                  initialTime: _selectedTime,
                );
                if (newTime != null) {
                  setState(() {
                    _selectedTime = newTime;
                  });
                }
              },
            ),
            Text(' Ending time',style: AppTextStyles.h4.copyWith(color: Colors.black,fontWeight: FontWeight.bold)),
            ListTile(
              title: Text('Time: ${_selectedTimeEnd.format(context)}',style: AppTextStyles.h4.copyWith(color: Colors.black,fontWeight: FontWeight.bold)),
              trailing: Icon(Icons.edit,color: Colors.white,),
              onTap: () async {
                TimeOfDay? newTime = await showTimePicker(
                  context: context,
                  initialTime: _selectedTimeEnd,
                );
                if (newTime != null) {
                  setState(() {
                    _selectedTimeEnd = newTime;
                  });
                }
              },
            ),

            SizedBox(height: 16),

            Container(
              color: Colors.white,
              width: size.width,
              height: size.height * 0.05,
              child: ElevatedButton(
                onPressed: () {
                  _createSubject(context);
                },
                child: const Text(AppText.saveButton),
              ),
            ),
          ],
        ),

      ),
    );
  }



  void _createSubject(context) {
    BlocProvider.of<SubjectCubit>(context).createSubject(
        subject: SubjectModel(
            subjectName:_subjectController.text.toString() ,
            subjectCode:_subjectcodeController.text.toString(),
            branch: _branchController.text.toString(),
            startTime: _selectedTime,
            endTime:_selectedTimeEnd,
            daysSelected:_daysSelected
        )).then((value) {
      Fluttertoast.showToast(msg: "Added Successfully");
    }
    ).catchError((e){
      Fluttertoast.showToast(msg: "Error");
    });
  }
}

String _dayName(int index) {
  switch (index) {
    case 0:
      return 'Mon';
    case 1:
      return 'Tue';
    case 2:
      return 'Wed';
    case 3:
      return 'Thu';
    case 4:
      return 'Fri';
    case 5:
      return 'Sat';
    case 6:
      return 'Sun';
    default:
      return '';
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        colorFilter: ColorFilter.mode(Colors.white54, BlendMode.srcIn),
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }



}

