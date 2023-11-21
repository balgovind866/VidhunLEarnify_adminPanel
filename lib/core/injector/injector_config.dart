import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:student_admin_panel/features/domain/usecases/student_firebase_usecase/GetStudentUseCAse.dart';
import 'package:student_admin_panel/features/domain/usecases/student_firebase_usecase/create_student_usecase.dart';
import 'package:student_admin_panel/features/domain/usecases/teacher_firebase_ucecase/GetTeacherUseCase.dart';

import '../../features/data/data_sources/remote_data/remote_data_source_impl.dart';
import '../../features/data/data_sources/remote_data/remote_data_sources.dart';
import '../../features/data/repositoty/firebase_repositry.dart';
import '../../features/domain/repository/firebase_repostory.dart';
import '../../features/domain/usecases/student_firebase_usecase/get_current_uid_usecase.dart';
import '../../features/domain/usecases/student_firebase_usecase/is_sign_in_user_usecase.dart';
import '../../features/domain/usecases/student_firebase_usecase/sign_in_usecase.dart';
import '../../features/domain/usecases/student_firebase_usecase/sign_out_usecase.dart';
import '../../features/domain/usecases/student_firebase_usecase/sign_up_usecase.dart';
import '../../features/domain/usecases/subject/create_subject_usecase.dart';
import '../../features/domain/usecases/teacher_firebase_ucecase/create_teacher_usecase.dart';
import '../../features/domain/usecases/upload_teacher_image_usecase.dart';

import '../../features/represantion/cubit/cubit/auth_cubit.dart';
import '../../features/represantion/cubit/cubit/credencial/credencial_cubit.dart';
import '../../features/represantion/student/blocStudent/student_bloc_cubit.dart';
import '../../features/represantion/subject/subject_bloc/subject_cubit.dart';
import '../../features/represantion/teacher/bloc/teacher_cubit.dart';


/// [Dependency Injection] a way of making a class
/// independent of its own dependencies.

final sl = GetIt.instance;

Future<void> init() async {


  ///  [registerFactory] method is used to register a
  ///  factory function that will be used to create
  ///  an instance of a specific type whenever it is requested.

  /// Cubits
  sl.registerFactory(() => TeacherCubit(
    createTeacherUseCase: sl.call(),
    uploadTeacherImageUseCase: sl.call(),
    getTeacherUseCase: sl.call(),


  ));

  sl.registerFactory(() => StudentBlocCubit(
      createStudentUseCase: sl.call(),
           getStudentUseCase: sl.call()
  ));

  sl.registerFactory<AuthCubit>(() => AuthCubit(
    isSignInUseCase: sl.call(),
    signOutUseCase: sl.call(),
    getCurrentUIDUseCase: sl.call(),
  ));

  sl.registerFactory<CredentialCubit>(() => CredentialCubit(

        createStudentUseCase: sl.call(),
          signInUseCase: sl.call(),
          signUpUseCase: sl.call(),
         ));
  sl.registerFactory<SubjectCubit>(() => SubjectCubit(createSubjectUseCase:sl.call()));



  sl.registerLazySingleton<IsSignInUseCase>(() => IsSignInUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetCurrentUIDUseCase>(() => GetCurrentUIDUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignOutUseCase>(() => SignOutUseCase(repository: sl.call()));

  sl.registerLazySingleton<SignInUseCase>(() => SignInUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignUpUseCase>(() => SignUpUseCase(repository: sl.call()));

  ///  [registerLazySingleton] which registers a singleton object that will be
  ///  lazily initialized the first time it is requested,
  ///  and will return the same instance on subsequent requests.


  /// UseCases
  sl.registerLazySingleton(() => CreateTeacherUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => UploadImageToStorageUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => GetTeacherUseCase(repository: sl.call()));

  sl.registerLazySingleton(() => CreateStudentUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => GetStudentUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => CreateSubjectUseCase(repository: sl.call()));




  /// Repository
  sl.registerLazySingleton<TeacherFirebaseRepository>(() => TeacherFirebaseRepositoryImpl(remoteDataSource: sl.call()));

  sl.registerLazySingleton<StudentFirebaseRepository>(() => StudentFirebaseRepositoryImpl( RemoteDateSource: sl.call(),));



  /// Remote Data Source
  sl.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl(firebaseFirestore: sl.call(), firebaseStorage: sl.call()));
  sl.registerLazySingleton<StudentRemoteDateSource>(() =>StudentRemoteDataSourceImpl(firebaseFirestore: sl.call(), firebaseStorage: sl.call(), auth: sl.call()));

  /// Firebase
  final firebaseFirestore = FirebaseFirestore.instance;
  final firebaseStorage = FirebaseStorage.instance;
  final firebaseAuth=FirebaseAuth.instance;

  sl.registerLazySingleton(() => firebaseFirestore);
  sl.registerLazySingleton(() => firebaseStorage);
  sl.registerLazySingleton(() => firebaseAuth);
}