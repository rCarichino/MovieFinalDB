import 'package:flutter/material.dart';

import '../resources/dimens.dart';
import '../resources/styles.dart';

class Button extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final double? width;
  final Color? color;
  final Color? titleColor;
  final double? fontSize;
  final Color? splashColor;

  const Button({
    super.key,
    required this.title,
    required this.onPressed,
    this.width,
    this.color,
    this.titleColor,
    this.fontSize,
    this.splashColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          BoxConstraints(minWidth: width ?? double.infinity),
      margin: EdgeInsets.symmetric(vertical: Dimens.space8),
      height: Dimens.buttonH,
      decoration: BoxDecorations(context).button.copyWith(
            color: color ?? Theme.of(context).extension<CustomColors>()!.pink,
          ),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor:
              color ?? Theme.of(context).extension<CustomColors>()!.pink,
          foregroundColor:
              Theme.of(context).extension<CustomColors>()!.buttonText,
          padding: EdgeInsets.symmetric(horizontal: Dimens.space24),
          shape: const BeveledRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(Dimens.cornerRadius),
            ),
          ),
        ),
        child: Text(
          title.toUpperCase(),
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Theme.of(context).extension<CustomColors>()!.background,
              ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
