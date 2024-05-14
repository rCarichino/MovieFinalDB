import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/resources/dimens.dart';
import '../../core/resources/images.dart';
import '../../core/resources/styles.dart';
import '../../core/routes/app_routes.dart';


class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      context.goNamed(Routes.root.name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ColoredBox(
        color: Theme.of(context).extension<CustomColors>()!.background!,
        child: Center(
          child: CircleAvatar(
            backgroundColor: Theme.of(context).hintColor,
            radius: Dimens.menu + Dimens.space6,
            child: CircleAvatar(
              backgroundImage: AssetImage(Images.icLogo),
              radius: Dimens.menu,
            ),
          ),
        ),
      ),
    );
  }
}
