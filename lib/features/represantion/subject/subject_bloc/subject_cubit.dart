import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:student_admin_panel/features/domain/entity/subject_entites.dart';

import '../../../domain/usecases/subject/create_subject_usecase.dart';

part 'subject_state.dart';

class SubjectCubit extends Cubit<SubjectState> {

  final CreateSubjectUseCase createSubjectUseCase;

  SubjectCubit({required this.createSubjectUseCase}) : super(SubjectInitial());


  Future<void> createSubject({required SubjectEntities subject}) async {
    try {
      await createSubjectUseCase.call(subject);
    } on FirebaseException catch (_) {
      emit(SubjectFailure());
    } catch (_) {
      emit(SubjectFailure());
    }
  }




}