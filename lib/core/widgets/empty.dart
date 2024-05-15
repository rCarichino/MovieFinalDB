import 'package:flutter/material.dart';

import '../resources/images.dart';
class Empty extends StatelessWidget {
  final String? errorMessage;

  const Empty({super.key, this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          Images.icLauncher,
          width: 150,
        ),
        Text(
          errorMessage ?? "No data",
        ),
      ],
    );
  }
}
