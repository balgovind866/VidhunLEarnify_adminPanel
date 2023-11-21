import 'dart:typed_data';


import 'package:student_admin_panel/features/domain/entity/subject_entites.dart';

import '../../../domain/entity/student_entites.dart';
import '../../../domain/entity/teacher_entities.dart';

abstract class RemoteDataSource {

  // Teacher Features
  Stream<List<TeacherEntity>> getTeachers();
  Stream<List<TeacherEntity>> getSingleTeacher(String uid);
  Stream<List<TeacherEntity>> getSingleOtherTeacher(String otherUid);
  Future<void> createTeacher(TeacherEntity teacher);
  Future<void> updateTeacher(TeacherEntity teacher);

  // Upload Teacher Image
  Future<String> uploadImageToStorage(Uint8List filePath, String storagePath);
}

abstract class StudentRemoteDateSource {

  // Student Features
  Stream<List<StudentEntity>> getStudents();
  Stream<List<StudentEntity>> getSingleStudent(String uid);
  Stream<List<StudentEntity>> getSingleOtherStudent(String otherUid);
  Future<void> createStudent(StudentEntity student);

  //for subject
  Future<void>createSubject(SubjectEntities Subject);
  Stream<List<SubjectEntities>>getSubject();


  Future<void> updateStudent(StudentEntity student);

  // Upload Student Image
  Future<String> uploadImageToStorage(Uint8List filePath, String storagePath);


  Future<void> forgotPassword(String email);


  Future<bool> isSignIn();
  Future<void> signIn(StudentEntity student);
  Future<void> signUp(StudentEntity student);

  Future<void> signOut();

  Future<String> getCurrentUId();


}