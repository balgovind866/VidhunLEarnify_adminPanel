import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';


import '../../../../core/widgets/side_bar_widget.dart';
import '../../../constant/app_colors.dart';
import '../../../constant/app_text.dart';
import '../../../constant/app_text_style.dart';
import '../../../constant/route_constants.dart';


/// [ExamsScreen] represents, different classes
/// exams with [DateTime] and numbers.
/// Admin can also check exams results of different
/// classes here.

class ExamsScreen extends StatelessWidget {
  const ExamsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: AppColors.secondary.withOpacity(0.2),
      appBar: AppBar(
        backgroundColor: AppColors.black,
        title: Text(
          AppText.schoolManagement,
          style: AppTextStyles.h3.copyWith(color: AppColors.white),
        ),
      ),
      sideBar: SideBarWidget().sideBarMenus(context, RouteList.exams),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: const Text(
            'Exams',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 36,
            ),
          ),
        ),
      ),
    );
  }
}