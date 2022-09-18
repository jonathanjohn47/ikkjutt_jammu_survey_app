import 'package:flutter/material.dart';

class StandardDivider extends StatelessWidget {
  const StandardDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Divider(
        color: Theme.of(context).secondaryHeaderColor,
        thickness: 2,
      ),
    );
  }
}
