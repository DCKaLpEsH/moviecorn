import 'package:flutter/material.dart';
import 'package:moviecorn/common/constants/size_constants.dart';
import 'package:moviecorn/common/extensions/size_extensions.dart';
import 'package:moviecorn/presentation/screens/home_screen/widgets/logo.dart';
import 'package:moviecorn/presentation/screens/navigation_drawer/navigation_expanded_list_item.dart';
import 'package:moviecorn/presentation/screens/navigation_drawer/navigation_list_item.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Sizes.dimen_300.w.toDouble(),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            color: Theme.of(context).primaryColor.withOpacity(0.7),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: Sizes.dimen_8.h.toDouble(),
                bottom: Sizes.dimen_18.h.toDouble(),
                left: Sizes.dimen_8.w.toDouble(),
                right: Sizes.dimen_8.w.toDouble(),
              ),
              child: Logo(
                height: Sizes.dimen_20.h.toDouble(),
              ),
            ),
            NavigationListItem(title: "Favourite Movies", onPressed: () {}),
            NavigationExpandedListItem(
              title: "Language",
              onPressed: () {},
              children: const [
                "English",
                "Hindi",
              ],
            ),
            NavigationListItem(title: "Feedback", onPressed: () {}),
            NavigationListItem(title: "About", onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
