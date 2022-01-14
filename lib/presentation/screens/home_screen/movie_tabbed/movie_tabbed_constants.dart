import 'package:moviecorn/common/constants/transalations_constants.dart';
import 'package:moviecorn/presentation/screens/home_screen/movie_tabbed/tab.dart';

class MovieTabbedConstants {
  static const List<Tab> movieTabs = [
    Tab(index: 0, title: TranslationsConstants.popular),
    Tab(index: 1, title: TranslationsConstants.soon),
    Tab(index: 2, title: TranslationsConstants.now),
  ];
}
