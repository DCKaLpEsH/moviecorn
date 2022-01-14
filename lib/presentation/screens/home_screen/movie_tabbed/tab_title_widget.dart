import 'package:flutter/material.dart';
import 'package:moviecorn/common/constants/size_constants.dart';
import 'package:moviecorn/common/extensions/size_extensions.dart';
import 'package:moviecorn/presentation/themes/app_colors.dart';
import 'package:moviecorn/presentation/themes/theme_text.dart';

class TabTitleWidget extends StatelessWidget {
  const TabTitleWidget({
    Key? key,
    required this.title,
    required this.onTap,
    required this.isSelected,
  })  : assert(title != null, "title should not be null"),
        assert(onTap != null, "onTap should not be null"),
        assert(isSelected != null, "isSelected should not be null"),
        super(key: key);
  final String title;
  final Function() onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border(
            bottom: BorderSide(
              color: isSelected ? AppColors.royalBlue : Colors.transparent,
              width: Sizes.dimen_1.h.toDouble(),
            ),
          ),
        ),
        child: Text(
          title,
          style: isSelected
              ? Theme.of(context).textTheme.royalBlueSubtitle1
              : Theme.of(context).textTheme.subtitle1,
        ),
      ),
    );
  }
}
