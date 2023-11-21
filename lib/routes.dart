import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:student_admin_panel/features/represantion/teacher/page/teacher_screan.dart';

import 'constant/route_constants.dart';
import 'features/represantion/attandance/attandance_page.dart';
import 'features/represantion/dashboard_screan.dart';
import 'features/represantion/exam/exam_page.dart';
import 'features/represantion/parent/parent_page.dart';
import 'features/represantion/setting/setting_page.dart';
import 'features/represantion/student/student_page/student_deshboad_details/deshboard.dart';
import 'features/represantion/student/student_page/student_page.dart';




class NamedRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteList.dashBoard:
        return getPageRoute(const DashBoardScreen());
      case RouteList.exams:
        return getPageRoute(const ExamsScreen());
      case RouteList.settings:
        return getPageRoute(const SettingsScreen());
      case RouteList.parent:
        return getPageRoute(const ParentScreen());
      case RouteList.attendance:
        return getPageRoute(const AttendanceScreen());
      case RouteList.student:
        return getPageRoute(const StudentScreen());
      case RouteList.teacher:
        return getPageRoute(const TeacherScreen());
      case RouteList.studentDeshbBoardDetail:
        return getPageRoute(DashboardScreen());
      default:
        return MaterialPageRoute(builder: (_) => const DashBoardScreen());
    }
  }
}
PageRouteBuilder getPageRoute(Widget screen) {
  return PageRouteBuilder(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation) {
      return screen;
    },
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child

        ) {
      return Align(
        /// you can also change it
        child: SizeTransition(
          sizeFactor: animation,
          child: child,
        ),
      );
    },
    transitionDuration: const Duration(milliseconds: 500), /// you can change it
  );
}
