import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviecorn/common/constants/size_constants.dart';
import 'package:moviecorn/common/extensions/size_extensions.dart';
import 'package:moviecorn/common/screenutil/screen_utils.dart';
import 'package:moviecorn/presentation/themes/app_colors.dart';
import 'package:moviecorn/presentation/themes/custom_material_color.dart';
import 'package:moviecorn/presentation/themes/theme_text.dart';

import 'screens/home_screen/home_screen.dart';

class MovieApp extends StatelessWidget {
  const MovieApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init();
    return MaterialApp(
      theme: ThemeData(
        primaryColor: AppColors.vulcan,
        colorScheme: ColorScheme.fromSwatch(accentColor: AppColors.royalBlue),
        scaffoldBackgroundColor: AppColors.vulcan,
        primarySwatch: createMaterialColor(AppColors.royalBlue),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: ThemeText.getTextTheme(),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
