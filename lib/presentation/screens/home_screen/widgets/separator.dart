import 'package:flutter/material.dart';

import 'package:moviecorn/common/constants/size_constants.dart';
import 'package:moviecorn/common/extensions/size_extensions.dart';
import 'package:moviecorn/presentation/themes/app_colors.dart';

class Separator extends StatelessWidget {
  const Separator({
    Key? key,
    required this.height,
  }) : super(key: key);
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: Sizes.dimen_80.w.toDouble(),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(
            Sizes.dimen_1.h.toDouble(),
          ),
        ),
        gradient: const LinearGradient(
          colors: [
            AppColors.violet,
            AppColors.royalBlue,
          ],
        ),
      ),
    );
  }
}
