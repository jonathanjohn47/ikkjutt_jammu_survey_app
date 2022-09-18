import 'package:flutter/material.dart';
import 'package:ikkjutt_jammu_survey_app/widgets/text_with_format.dart';

import '../core/app_colors.dart';

class StandardButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Color? color;
  final Color? textColor;
  final IconData? icon;
  final double? elevation;
  final double? radius;
  final double? textSize;

  const StandardButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.color,
      this.icon,
      this.elevation,
      this.radius,
      this.textColor = Colors.white,
      this.textSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return icon == null
        ? FloatingActionButton.extended(
            onPressed: () {
              onPressed();
            },
            heroTag: null,
            elevation: elevation ?? 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius ?? 8.0),
            ),
            label: TextWithFormat(
              text,
              color: textColor,
              fontSize: textSize,
            ),
            backgroundColor: color ?? AppColors.secondaryHeaderColor.shade600,
          )
        : FloatingActionButton.extended(
            onPressed: () {
              onPressed();
            },
            heroTag: null,
            elevation: elevation ?? 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius ?? 8.0),
            ),
            label: TextWithFormat(
              text,
              color: textColor,
              fontSize: textSize,
            ),
            icon: Icon(
              icon,
              color: textColor,
            ),
            backgroundColor: color ?? AppColors.secondaryHeaderColor.shade600,
          );
  }
}
