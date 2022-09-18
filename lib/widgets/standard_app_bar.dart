import 'package:flutter/material.dart';
import 'package:ikkjutt_jammu_survey_app/core/app_colors.dart';
import 'package:ikkjutt_jammu_survey_app/widgets/text_with_format.dart';

class StandardAppBar extends StatelessWidget {
  final String title;
  final List<Widget>? actions;

  const StandardAppBar({
    Key? key,
    required this.title,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: TextWithFormat(
        title,
        color: AppColors.secondaryHeaderColor.shade700,
        bold: true,
      ),
      actions: actions,
    );
  }
}
