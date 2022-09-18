import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({Key? key, this.thickness, this.color}) : super(key: key);
  final double? thickness;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Divider(
        color: color ?? Theme.of(context).secondaryHeaderColor,
        thickness: thickness ?? 2,
      ),
    );
  }
}
