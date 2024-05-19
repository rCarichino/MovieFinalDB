import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:moviedb/core/resources/dimens.dart';
import 'package:moviedb/core/resources/palette.dart';

class ContainerProfile extends StatelessWidget {
  final double? dimens;
  final Color palette;
  final Widget? child;

  const ContainerProfile(
      {super.key,
      required this.dimens,
      required this.palette,
      required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: dimens,
      decoration: BoxDecoration(color: palette, boxShadow: const [
        BoxShadow(
            color: Palette.shadowDark,
            blurStyle: BlurStyle.outer,
            blurRadius: 25)
      ]),
      child: child,
    );
  }
}
