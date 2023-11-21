import 'package:student_admin_panel/features/domain/entity/subject_entites.dart';

import '../../repository/firebase_repostory.dart';

class CreateSubjectUseCase {
  final StudentFirebaseRepository repository;

  CreateSubjectUseCase({required this.repository});

  Future<void> call(SubjectEntities Subject) {
    return repository.createSubject(Subject);
  }
}