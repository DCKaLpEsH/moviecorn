import 'package:flutter/material.dart';
import 'package:wiredash/wiredash.dart';

import 'package:moviecorn/presentation/themes/app_colors.dart';

class WiredashApp extends StatelessWidget {
  const WiredashApp({
    Key? key,
    required this.navigatorKey,
    required this.child,
    required this.languageCode,
  }) : super(key: key);
  final GlobalKey<NavigatorState> navigatorKey;
  final Widget child;
  final String languageCode;
  @override
  Widget build(BuildContext context) {
    return Wiredash(
      projectId: "moviecorn-zr30bo3",
      secret: "ElQhrI6jpw9YhRdBK905zBDCzS4lSCCU",
      navigatorKey: navigatorKey,
      child: child,
      theme: WiredashThemeData(
        brightness: Brightness.dark,
        primaryColor: AppColors.royalBlue,
        secondaryColor: AppColors.violet,
        primaryBackgroundColor: AppColors.vulcan,
        dividerColor: AppColors.vulcan,
      ),
      options: WiredashOptionsData(
        locale: Locale.fromSubtags(
          languageCode: languageCode,
        ),
      ),
    );
  }
}
