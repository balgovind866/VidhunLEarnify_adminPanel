

import 'package:flutter/foundation.dart';
import 'package:student_admin_panel/features/domain/entity/student_entites.dart';

import '../../domain/entity/teacher_entities.dart';
import '../../domain/repository/firebase_repostory.dart';
import '../data_sources/remote_data/remote_data_sources.dart';

class TeacherFirebaseRepositoryImpl extends TeacherFirebaseRepository {

  final RemoteDataSource remoteDataSource;

  TeacherFirebaseRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> createTeacher(TeacherEntity teacher) async => remoteDataSource.createTeacher(teacher);

  @override
  Stream<List<TeacherEntity>> getSingleOtherTeacher(String otherUid) {
    // TODO: implement getSingleOtherTeacher
    throw UnimplementedError();
  }

  @override
  Stream<List<TeacherEntity>> getSingleTeacher(String uid) {
    // TODO: implement getSingleTeacher
    throw UnimplementedError();
  }

  @override
  Stream<List<TeacherEntity>> getTeachers() =>remoteDataSource.getTeachers();


  @override
  Future<void> updateTeacher(TeacherEntity teacher) {
    // TODO: implement updateTeacher
    throw UnimplementedError();
  }

  @override
  Future<String> uploadImageToStorage(Uint8List filePath, String storagePath) => remoteDataSource.uploadImageToStorage(filePath, storagePath);

}

class StudentFirebaseRepositoryImpl extends StudentFirebaseRepository{

  final StudentRemoteDateSource RemoteDateSource;

  StudentFirebaseRepositoryImpl({required this.RemoteDateSource});
  @override
  Future<void> createStudent(StudentEntity student) async=>RemoteDateSource.createStudent(student);

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