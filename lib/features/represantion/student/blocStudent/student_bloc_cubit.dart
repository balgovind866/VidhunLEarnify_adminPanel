import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:student_admin_panel/features/data/modal/student_model.dart';
import 'package:student_admin_panel/features/data/modal/teacher_model.dart';

import '../../../domain/entity/student_entites.dart';
import '../../../domain/usecases/student_firebase_usecase/create_student_usecase.dart';

part 'student_bloc_state.dart';

class StudentBlocCubit extends Cubit<StudentBlocState> {

  final CreateStudentUseCase createStudentUseCase;
  StudentBlocCubit({required this.createStudentUseCase

  }) : super(StudentBlocInitial());

  Future<void> createStudent({required StudentEntity student} )async {
    try{
      await  createStudentUseCase.call(student);
    } on FirebaseException catch(_){
      emit(StudentFailure ());
    }catch (_) {
      emit(StudentFailure());
    }
  }



}
