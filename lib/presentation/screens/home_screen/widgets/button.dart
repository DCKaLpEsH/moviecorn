import 'package:flutter/material.dart';
import 'package:moviecorn/common/constants/size_constants.dart';
import 'package:moviecorn/common/extensions/size_extensions.dart';
import 'package:moviecorn/common/extensions/string_extensions.dart';
import 'package:moviecorn/presentation/themes/app_colors.dart';

class Button extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final bool isEnabled;

  const Button({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeIn,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isEnabled
              ? [AppColors.royalBlue, AppColors.violet]
              : [Colors.grey, Colors.grey],
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(Sizes.dimen_20.w.toDouble()),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_16.w.toDouble()),
      margin: EdgeInsets.symmetric(vertical: Sizes.dimen_10.h.toDouble()),
      height: Sizes.dimen_16.h.toDouble(),
      child: TextButton(
        key: const ValueKey('main_button'),
        onPressed: isEnabled ? onPressed : null,
        child: Text(
          text.t(context),
          style: Theme.of(context).textTheme.button,
        ),
      ),
    );
  }
}
