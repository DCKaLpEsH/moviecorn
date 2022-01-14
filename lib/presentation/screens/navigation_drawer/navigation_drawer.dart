import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviecorn/common/constants/languages.dart';
import 'package:moviecorn/common/constants/size_constants.dart';
import 'package:moviecorn/common/constants/transalations_constants.dart';
import 'package:moviecorn/common/extensions/size_extensions.dart';
import 'package:moviecorn/common/extensions/string_extensions.dart';
import 'package:moviecorn/presentation/app_localizations.dart';
import 'package:moviecorn/presentation/bloc/language/language_bloc.dart';
import 'package:moviecorn/presentation/screens/home_screen/widgets/app_dialog.dart';
import 'package:moviecorn/presentation/screens/home_screen/widgets/logo.dart';
import 'package:moviecorn/presentation/screens/navigation_drawer/navigation_expanded_list_item.dart';
import 'package:moviecorn/presentation/screens/navigation_drawer/navigation_list_item.dart';
import 'package:moviecorn/presentation/themes/app_colors.dart';
import 'package:wiredash/wiredash.dart';

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
            NavigationListItem(
                title: TranslationsConstants.favouriteMovies.t(context),
                onPressed: () {}),
            NavigationExpandedListItem(
              title: TranslationsConstants.language.t(context),
              children: Languages.languages.map((e) => e.value).toList(),
              onPressed: (index) {
                BlocProvider.of<LanguageBloc>(context).add(
                  ToggleLanguageEvent(
                    language: Languages.languages[index],
                  ),
                );
              },
            ),
            NavigationListItem(
              title: TranslationsConstants.feedback.t(context),
              onPressed: () {
                Navigator.of(context).pop();
                Wiredash.of(context)!.show();
              },
            ),
            NavigationListItem(
              title: TranslationsConstants.about.t(context),
              onPressed: () {
                Navigator.of(context).pop();
                _showDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AppDialog(
            title: TranslationsConstants.about,
            description: TranslationsConstants.aboutDescription,
            buttonText: TranslationsConstants.okay,
            image: Image.asset(
              "assets/pngs/tmdb_logo.png",
              height: Sizes.dimen_32.h.toDouble(),
            ),
          );
        });
  }
}
