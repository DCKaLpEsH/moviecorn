import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviecorn/common/constants/languages.dart';
import 'package:moviecorn/common/constants/route_constants.dart';
import 'package:moviecorn/common/constants/size_constants.dart';
import 'package:moviecorn/common/extensions/size_extensions.dart';
import 'package:moviecorn/common/screenutil/screen_utils.dart';
import 'package:moviecorn/di/get_it.dart';
import 'package:moviecorn/domain/usecases/get_preferred_language.dart';
import 'package:moviecorn/presentation/app_localizations.dart';
import 'package:moviecorn/presentation/bloc/language/language_bloc.dart';
import 'package:moviecorn/presentation/bloc/loading/loading_bloc.dart';
import 'package:moviecorn/presentation/bloc/login/login_bloc.dart';
import 'package:moviecorn/presentation/routes.dart';
import 'package:moviecorn/presentation/screens/loading/loading_screen.dart';
import 'package:moviecorn/presentation/themes/app_colors.dart';
import 'package:moviecorn/presentation/themes/custom_material_color.dart';
import 'package:moviecorn/presentation/themes/theme_text.dart';
import 'package:moviecorn/presentation/wiredash_app.dart';
import 'package:wiredash/wiredash.dart';

import 'fade_page_route_builder.dart';
import 'screens/home_screen/home_screen.dart';

class MovieApp extends StatefulWidget {
  const MovieApp({Key? key}) : super(key: key);

  @override
  State<MovieApp> createState() => _MovieAppState();
}

class _MovieAppState extends State<MovieApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  late LanguageBloc languageBloc;
  late LoginBloc loginBloc;
  late LoadingBloc loadingBloc;
  @override
  void initState() {
    super.initState();
    languageBloc = getItInstance<LanguageBloc>();
    languageBloc.add(
      LoadPreferredLanguageEvent(),
    );
    loginBloc = getItInstance<LoginBloc>();
    loadingBloc = getItInstance<LoadingBloc>();
  }

  @override
  void dispose() {
    languageBloc.close();
    loginBloc.close();
    loadingBloc.close();
    super.dispose();
  }

  // TODO : Fix buttons not showing text.
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init();
    return MultiBlocProvider(
      providers: [
        BlocProvider<LanguageBloc>.value(
          value: languageBloc,
        ),
        BlocProvider<LoginBloc>.value(
          value: loginBloc,
        ),
        BlocProvider<LoadingBloc>.value(
          value: loadingBloc,
        ),
      ],
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, state) {
          if (state is LanguageLoadedState) {
            return WiredashApp(
              navigatorKey: _navigatorKey,
              languageCode: state.locale.languageCode,
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                navigatorKey: _navigatorKey,
                theme: ThemeData(
                  appBarTheme: const AppBarTheme(
                    elevation: 0,
                    backgroundColor: AppColors.vulcan,
                  ),
                  primaryColor: AppColors.vulcan,
                  colorScheme:
                      ColorScheme.fromSwatch(accentColor: AppColors.royalBlue),
                  scaffoldBackgroundColor: AppColors.vulcan,
                  primarySwatch: createMaterialColor(AppColors.vulcan),
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                  textTheme: ThemeText.getTextTheme(),
                  iconTheme: const IconThemeData(
                    color: Colors.white,
                  ),
                ),
                supportedLocales:
                    Languages.languages.map((e) => Locale(e.code)).toList(),
                locale: state.locale,
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                // home: const HomeScreen(),
                builder: (context, child) {
                  return LoadingScreen(screen: child!);
                },
                initialRoute: RouteConstants.initial,
                onGenerateRoute: (RouteSettings settings) {
                  final routes = Routes.getRoutes(settings);
                  WidgetBuilder builder = routes[settings.name]!;
                  return FadePageRouteBuilder(
                    builder: builder,
                    settings: settings,
                  );
                },
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
