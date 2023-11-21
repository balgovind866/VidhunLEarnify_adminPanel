import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_admin_panel/features/represantion/student/blocStudent/student_bloc_cubit.dart';
import 'package:student_admin_panel/routes.dart';

import 'constant/app_themes.dart';
import 'constant/route_constants.dart';

import 'features/represantion/cubit/cubit/auth_cubit.dart';
import 'features/represantion/cubit/cubit/credencial/credencial_cubit.dart';
import 'features/represantion/dashboard_screan.dart';
import 'core/injector/injector_config.dart' as di;
import 'features/represantion/subject/subject_bloc/subject_cubit.dart';
import 'features/represantion/teacher/bloc/teacher_cubit.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyAJ0r4OOkUlL75PDtk5UG0NGpm4WHcoyAk",
        authDomain: "vidhunlearnify-aa623.firebaseapp.com",
        projectId: "vidhunlearnify-aa623",
        storageBucket: "vidhunlearnify-aa623.appspot.com",
        messagingSenderId: "651716442948",
        appId: "1:651716442948:web:796dbc2f8ba8666f117511",
        measurementId: "G-TDJL53CW43"
        )
  );
  await di.init();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<TeacherCubit>(
            create: (context) => di.sl<TeacherCubit>()),
        BlocProvider<StudentBlocCubit>(
            create: (context) => di.sl<StudentBlocCubit>()),

        BlocProvider<AuthCubit>(
          create: (_) => di.sl<AuthCubit>()..appStarted(),
        ),
        BlocProvider<CredentialCubit>(
          create: (_) => di.sl<CredentialCubit>(),

        ),
        BlocProvider<SubjectCubit>(create: (_)=>di.sl<SubjectCubit>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'School Management Web Panel',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      //routes:  RouteList.getAllRoutes(),
      onGenerateRoute: NamedRouter.generateRoute,
      initialRoute: RouteList.dashBoard,

      home: const DashBoardScreen(),
    );
  }
}


