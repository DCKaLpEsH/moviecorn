import 'package:flutter/material.dart';
import 'package:moviecorn/common/constants/size_constants.dart';
import 'package:moviecorn/common/extensions/size_extensions.dart';
import 'package:moviecorn/presentation/screens/navigation_drawer/navigation_list_item.dart';
import 'package:moviecorn/presentation/themes/app_colors.dart';

class NavigationExpandedListItem extends StatelessWidget {
  const NavigationExpandedListItem({
    Key? key,
    required this.title,
    required this.onPressed,
    required this.children,
  }) : super(key: key);
  final String title;
  final Function() onPressed;
  final List<String> children;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 2,
              color: Theme.of(context).primaryColor.withOpacity(0.7),
            ),
          ],
        ),
        child: ExpansionTile(
          title: Text(
            title,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          iconColor: AppColors.royalBlue,
          childrenPadding: EdgeInsets.symmetric(
            horizontal: Sizes.dimen_24.w.toDouble(),
          ),
          children: [
            for (var i = 0; i < children.length; i++)
              NavigationListItem(
                title: children[i],
                onPressed: () {},
              )
          ],
          collapsedIconColor: AppColors.royalBlue,
        ),
      ),
    );
  }
}
