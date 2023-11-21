
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

import '../../../constant/app_colors.dart';
import '../../../constant/app_sized_box.dart';
import '../../../constant/app_text.dart';
import '../../../constant/app_text_style.dart';
import '../../../constant/route_constants.dart';
import '../../../core/widgets/side_bar_widget.dart';
import 'slide_menu.dart';

class AddSubject extends StatefulWidget {
  const AddSubject({Key? key}) : super(key: key);

  @override
  State<AddSubject> createState() => _AddSubjectState();
}

class _AddSubjectState extends State<AddSubject> {
  @override
  Widget build(BuildContext context) {
    return AdminScaffold(


      backgroundColor: AppColors.secondary.withOpacity(0.2),
      appBar: AppBar(
        backgroundColor: AppColors.black,
        title: Text(
          'Subject Details',
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
                width: MediaQuery.of(context).size.width*.25,
                color: Colors.blue[200],
                child: SideMenu(),

              ),
              Expanded(
                flex: 5,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width*.4,
                  color: AppColors.secondary.withOpacity(0.6),
                ),
                
              ),


            ],
          )

      ),

    );
  }
}
