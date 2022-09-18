import 'package:flutter/material.dart';
import 'package:ikkjutt_jammu_survey_app/core/app_colors.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'login_page_admin.dart';
import 'login_page_member.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          bottomNavigationBar: ColoredBox(
            color: Theme.of(context).primaryColor,
            child: TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.person,
                      color: AppColors.secondaryHeaderColor.shade700),
                ),
                Tab(
                  icon: Icon(
                    MdiIcons.briefcase,
                    color: AppColors.secondaryHeaderColor.shade700,
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              LoginPageMember(),
              LoginPageAdmin(),
            ],
          ),
        ));
  }
}
