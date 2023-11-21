


import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:flutter_svg/svg.dart';
import 'package:student_admin_panel/constant/app_colors.dart';
import 'package:student_admin_panel/features/represantion/subject/slide_menu.dart';

import '../../../../../constant/app_sized_box.dart';
import '../../../../../constant/app_text.dart';
import '../../../../../constant/app_text_style.dart';
import '../../../../../constant/route_constants.dart';
import '../../../../../core/widgets/side_bar_widget.dart';

class DashboardScreen extends StatelessWidget {
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
          sideBar: SideBarWidget().sideBarMenus(context, RouteList.dashBoard),

      body: SingleChildScrollView(

        padding: EdgeInsets.all(defaultPadding),
        child: Row(
          children: [
           Container(

               height: MediaQuery.of(context).size.height,
               width: MediaQuery.of(context).size.width*.2,
               color: AppColors.secondary,
               child: SideMenu(),

           ),
            Expanded(
              flex: 5,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width*.4,
                color: Colors.blue,
              ),
            ),


              ],
            )

        ),

    );
  }
}


