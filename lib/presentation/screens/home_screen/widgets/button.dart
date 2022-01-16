import 'package:flutter/material.dart';
import 'package:moviecorn/common/constants/size_constants.dart';
import 'package:moviecorn/common/extensions/size_extensions.dart';
import 'package:moviecorn/common/extensions/string_extensions.dart';
import 'package:moviecorn/presentation/themes/app_colors.dart';

class Button extends StatelessWidget {
  const Button({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);
  final String title;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              AppColors.royalBlue,
              AppColors.violet,
            ],
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(
              Sizes.dimen_20.w.toDouble(),
            ),
          ),
        ),
        padding: EdgeInsets.all(Sizes.dimen_16.w.toDouble()),
        margin: EdgeInsets.all(Sizes.dimen_12.h.toDouble()),
        height: Sizes.dimen_16.h.toDouble(),
        child: Text(
          title.t(context),
          style: Theme.of(context).textTheme.button,
        ),
      ),
    );
  }
}
