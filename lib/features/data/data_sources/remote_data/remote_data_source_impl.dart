
import 'dart:math';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:student_admin_panel/features/data/data_sources/remote_data/remote_data_sources.dart';
import 'package:student_admin_panel/features/domain/entity/student_entites.dart';
import 'package:student_admin_panel/features/domain/entity/teacher_entities.dart';

import '../../modal/student_model.dart';
import '../../modal/teacher_model.dart';







class RemoteDataSourceImpl extends RemoteDataSource {

  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;

  RemoteDataSourceImpl({
    required this.firebaseStorage,
    required this.firebaseFirestore
  });

  @override
  Future<void> createTeacher(TeacherEntity teacher) async {
    final userCollection = firebaseFirestore.collection("teachers");

    final addTeacher = Teacher(
      teacherName: teacher.teacherName,
      teacherEmail: teacher.teacherEmail,
      teacherPassword: teacher.teacherPassword,
      teacherDesignation: teacher.teacherDesignation,
      teacherDepartment: teacher.teacherDepartment,
      teacherPhoneNumber: teacher.teacherPhoneNumber,
      teacherGender: teacher.teacherGender,
      teacherBloodGroup: teacher.teacherBloodGroup,
      teacherAddress: teacher.teacherAddress,
      teacherAbout: teacher.teacherAbout,
      teacherImage: teacher.teacherImage,
    ).toJson();

    userCollection.add(addTeacher);
  }

  @override
  Stream<List<TeacherEntity>> getSingleOtherTeacher(String otherUid) {
    throw UnimplementedError();
  }

  @override
  Stream<List<TeacherEntity>> getSingleTeacher(String uid) {
    throw UnimplementedError();
  }
  @override
  Stream<List<TeacherEntity>> getTeachers() {
    final teacherCollection = firebaseFirestore.collection("teachers");

    // Snapshot of the teachers collection
    return teacherCollection.snapshots().map((event) => event.docs.map((e) => Teacher.fromSnapshot(e)).toList());
  }

  @override
  Future<void> updateTeacher(TeacherEntity teacher) {
    throw UnimplementedError();
  }

  @override
  Future<String> uploadImageToStorage(Uint8List filePath, String storagePath) async {
    const chars ='AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random rnd = Random();
    String randomStr = String.fromCharCodes(Iterable.generate(
        8, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));

    Reference ref = firebaseStorage.ref().child(storagePath).child(randomStr);

    UploadTask uploadTask = ref.putData(
      filePath,
      SettableMetadata(contentType: 'image/png'),
    );
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }

}

class StudentRemoteDataSourceImpl extends StudentRemoteDateSource {

  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;

  StudentRemoteDataSourceImpl({required this.firebaseFirestore, required this.firebaseStorage});
  @override
  Future<void> createStudent(StudentEntity student) async {
    final userCollection = firebaseFirestore.collection("StudentProfile");

    final addStudentProfile = StudentModel(
      password: student.password,
      fullName: student.fullName,
      age:student.age,
      email: student.email,
      profileImageUrl: student.profileImageUrl,
      rollNumber: student.rollNumber,
      course: student.course,
    ).toJson();
    // TODO: implement createStudent
    userCollection.add(addStudentProfile);
  }

  @override
  Stream<List<StudentEntity>> getSingleOtherStudent(String otherUid) {
    // TODO: implement getSingleOtherStudent
    throw UnimplementedError();
  }

  @override
  Stream<List<StudentEntity>> getSingleStudent(String uid) {
    // TODO: implement getSingleStudent
    throw UnimplementedError();
  }

  @override
  Stream<List<StudentEntity>> getStudents() {
    // TODO: implement getStudents
    throw UnimplementedError();
  }

  @override
  Future<void> updateStudent(StudentEntity student) {
    // TODO: implement updateStudent
    throw UnimplementedError();
  }

  @override
  Future<String> uploadImageToStorage(Uint8List filePath, String storagePath) {
    // TODO: implement uploadImageToStorage
    throw UnimplementedError();
  }

}