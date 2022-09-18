import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ikkjutt_jammu_survey_app/core/app_colors.dart';
import 'package:ikkjutt_jammu_survey_app/features/add_new_member/screens/add_new_member_screen.dart';
import 'package:ikkjutt_jammu_survey_app/features/new_survey/screens/new_survey_screen.dart';
import 'package:ikkjutt_jammu_survey_app/widgets/standard_app_bar.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../widgets/standard_divider.dart';

class AdminDashboard extends StatelessWidget {
  AdminDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //set statusbar color
    Future.delayed(Duration(milliseconds: 1), () {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: AppColors.secondaryHeaderColor.shade700,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
      ));
    });
    return ColoredBox(
      color: Colors.white,
      child: Scaffold(
        backgroundColor:
            AppColors.secondaryHeaderColor.shade50.withOpacity(0.3),
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: StandardAppBar(
              title: 'Admin Dashboard',
            )),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: gridItems.length,
            itemBuilder: (context, index) {
              return gridItems[index];
            },
          ),
        ),
        drawer: Drawer(
          child: Column(
            children: [
              DrawerHeader(
                  child: Image.asset(
                'assets/images/logo.jpeg',
                fit: BoxFit.cover,
              )),
              StandardDivider(),
              Expanded(
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(MdiIcons.home),
                      title: Text('Home'),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: Icon(MdiIcons.badgeAccount),
                      title: Text('All Surveys'),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: Icon(MdiIcons.accountMultiple),
                      title: Text('All Members'),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              StandardDivider(),
              ListTile(
                leading: Icon(MdiIcons.logout),
                title: Text('Logout'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> gridItems = [
    GestureDetector(
      onTap: () {
        Get.to(() => AddNewMemberScreen());
      },
      child: Card(
        child: Center(
          child: SizedBox(
            height: 100,
            child: Column(
              children: [
                Expanded(child: Icon(Icons.person_add)),
                Expanded(child: Text('Add New Member')),
              ],
            ),
          ),
        ),
      ),
    ),
    GestureDetector(
      onTap: () {
        Get.to(() => NewSurveyScreen());
      },
      child: Card(
        child: Center(
          child: SizedBox(
            height: 100,
            child: Column(
              children: [
                Expanded(child: Icon(MdiIcons.checkboxBlankBadge)),
                Expanded(child: Text('New Survey')),
              ],
            ),
          ),
        ),
      ),
    ),
    GestureDetector(
      onTap: () {},
      child: Card(
        child: Center(
          child: SizedBox(
            height: 100,
            child: Column(
              children: [
                Expanded(child: Icon(MdiIcons.starBoxMultiple)),
                Expanded(child: Text('New Event')),
              ],
            ),
          ),
        ),
      ),
    )
  ];
}
