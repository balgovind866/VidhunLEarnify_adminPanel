import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_admin_panel/features/data/modal/student_model.dart';
import 'package:student_admin_panel/features/represantion/teacher/widget/select_gender.dart';



import '../../../../constant/app_colors.dart';
import '../../../../constant/app_sized_box.dart';
import '../../../../constant/app_text.dart';
import '../../../../constant/app_text_style.dart';
import '../../../../core/widgets/common_text_field.dart';
import '../../cubit/cubit/credencial/credencial_cubit.dart';
import '../bloc/teacher_cubit.dart';



typedef GenderCallback = void Function(String? gender);
typedef BloodGroupCallback = void Function(String? group);


class RightStudentSheet extends StatefulWidget {
  const RightStudentSheet({
    Key? key,
    required Size size,
  })  : _size = size,
        super(key: key);

  final Size _size;

  @override
  State<RightStudentSheet> createState() => _RightStudentSheetState();
}

class _RightStudentSheetState extends State<RightStudentSheet> {
  late TextEditingController _fullnameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _ageController;
  late TextEditingController _rollNumberController;
  late TextEditingController _courseController;
  late TextEditingController _genderController;
  late TextEditingController _bloodGroupController;
  late TextEditingController _addressController;
  late TextEditingController _aboutController;

  final _formKey = GlobalKey<FormState>();
  Uint8List? _image;
  String? _imageName;
  String? selectedGender;
  String? bloodGroup;

  bool loading =false;
  Future<void> selectImage() async {
    try {
      final pickedFile =
      await ImagePicker.platform.getImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        _image = await XFile(pickedFile.path).readAsBytes();
        _imageName = pickedFile.name;
        setState(() {});
      } else {
        Fluttertoast.showToast(msg: "Image not selected");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Exception");
    }
  }

  @override
  void initState() {
    super.initState();
    loading=false;

    _fullnameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _ageController = TextEditingController();
    _rollNumberController = TextEditingController();
    _courseController= TextEditingController();
    _genderController = TextEditingController();
    _bloodGroupController = TextEditingController();
    _addressController = TextEditingController();
    _aboutController = TextEditingController();
  }

  @override
  void dispose() {
    _fullnameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _ageController.dispose();
    _rollNumberController.dispose();
    _courseController.dispose();
    _genderController.dispose();
    _bloodGroupController.dispose();
    _addressController.dispose();
    _aboutController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppText.createTeacher,
              style: AppTextStyles.bodyLg.copyWith(
                  color: AppColors.black, fontWeight: FontWeight.bold),
            ),
            AppSizedBoxes.kSizedBoxHeight4,
            const Divider(
              color: AppColors.black,
            ),
            AppSizedBoxes.kSizedBoxHeight14,
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Name
                  CommonTextField(
                    controller: _fullnameController,
                    label: AppText.labelName,
                    hint: AppText.enterTeacherName,
                    validator: (value) {
                      if (value!.length < 3) {
                        return AppText.nameError;
                      }
                      return null;
                    },
                  ),
                  AppSizedBoxes.kSizedBoxHeight14,

                  /// Email
                  CommonTextField(
                    controller: _emailController,
                    label: AppText.labelEmail,
                    hint: AppText.enterTeacherEmail,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isNotEmpty) {
                        if (!_checkValidEmail(value.toString())) {
                          return AppText.emailError;
                        }
                      } else {
                        return AppText.emailError;
                      }
                      return null;
                    },
                  ),
                  AppSizedBoxes.kSizedBoxHeight14,

                  /// Password
                  CommonTextField(
                    controller: _passwordController,
                    label: AppText.labelPassword,
                    hint: AppText.enterTeacherPassword,
                    obsecure: true,
                    validator: (value) {
                      if (value!.length < 5) {
                        return AppText.passwordError;
                      }
                      return null;
                    },
                  ),
                  AppSizedBoxes.kSizedBoxHeight14,

                  /// rollnumber
                  CommonTextField(
                    controller: _rollNumberController,
                    label:'Roll Number',
                    hint: AppText.enterTeacherDesignation,
                    validator: (value) {
                      if (value!.length < 3) {
                        return AppText.designationError;
                      }
                      return null;
                    },
                  ),
                  AppSizedBoxes.kSizedBoxHeight14,

                  /// Department
                  CommonTextField(
                    controller: _ageController,
                    label: 'age',
                    hint: AppText.enterTeacherDepartment,
                    validator: (value) {
                      if (value!.length < 1 ) {
                        return AppText.departmentError;
                      }
                      return null;
                    },
                  ),
                  AppSizedBoxes.kSizedBoxHeight14,

                  /// Phone Number
                  CommonTextField(
                    controller: _courseController,
                    label: 'Register course',
                    hint: AppText.enterTeacherPhoneNumber,
                    validator: (value) {
                      if (value!.length < 3) {
                        return AppText.phoneError;
                      }
                      return null;
                    },
                  ),
                  AppSizedBoxes.kSizedBoxHeight14,

                  /// Gender
                  SelectGender(
                    genderCallback: (gender) {
                      selectedGender = gender;
                      print(selectedGender);
                    },
                  ),
                  AppSizedBoxes.kSizedBoxHeight14,








                  /// Image
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 1, color: AppColors.black.withOpacity(0.5)),
                    ),
                    child: Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            selectImage();
                          },
                          child: const Text(AppText.selectImage),
                        ),
                        AppSizedBoxes.kSizedBoxWidth6,
                        Text(
                          '$_imageName',
                          style: AppTextStyles.bodySm
                              .copyWith(overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                  ),
                  AppSizedBoxes.kSizedBoxHeight14,

                  /// Save Teacher
                  SizedBox(
                    width: widget._size.width,
                    height: widget._size.height * 0.05,
                    child: ElevatedButton(
                      onPressed: () {
                        _createStudentProfile(context);
                      },
                      child: Text(AppText.saveButton),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _uploadImage(context, Uint8List? image) {


    if (_formKey.currentState!.validate() )

    {



      _formKey.currentState!.save();

      BlocProvider.of<TeacherCubit>(context).uploadTeacherImageUseCase(image!, "image").then((url)
      {
      //  _createStudentProfile(context, url);
      }
      );

    } else {
      Fluttertoast.showToast(msg: "Please fill all filled");
    }
  }

  void _createStudentProfile(context) {
    setState(() {
      loading = true;
    });
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<CredentialCubit>(context).signUpSubmit(

          student: StudentModel(
            password: _passwordController.text.toString(),
            fullName: _fullnameController.text.toString(),
            age: int.parse(_ageController.text.toString()),
            rollNumber: _rollNumberController.text.toString(),
            course: _courseController.text.toString(),
            email: _emailController.text.toString(),
            profileImageUrl: ' ',
          )
      ).then((value) {
        setState(() {
          loading = false;
        });

        Fluttertoast.showToast(msg: "Added Successfully");
        //Navigator.pop(context);
      }).catchError((e) {
        setState(() {
          loading = false;
        });
        Fluttertoast.showToast(msg: "Error");
      });
    }else {
      Fluttertoast.showToast(msg: "Please fill all filled");
    }
  }

  bool _checkValidEmail(String email) {
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }
}