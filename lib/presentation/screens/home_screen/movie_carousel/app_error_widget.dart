import 'package:flutter/material.dart';
import 'package:wiredash/wiredash.dart';

import 'package:moviecorn/common/constants/transalations_constants.dart';
import 'package:moviecorn/common/extensions/string_extensions.dart';
import 'package:moviecorn/domain/entities/app_error.dart';
import 'package:moviecorn/presentation/bloc/movie_carousel/movie_caruosel_bloc.dart';
import 'package:moviecorn/presentation/screens/home_screen/widgets/button.dart';

class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget({
    Key? key,
    required this.appErrorType,
    required this.onPressed,
  }) : super(key: key);
  final AppErrorType appErrorType;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          appErrorType == AppErrorType.api
              ? TranslationsConstants.somethingWentWrong.t(context)
              : TranslationsConstants.checkNetwork.t(context),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        ButtonBar(
          children: [
            Button(
              text: TranslationsConstants.retry,
              onPressed: onPressed,
            ),
            Button(
              text: TranslationsConstants.feedback,
              onPressed: () => Wiredash.of(context)!.show(),
            ),
          ],
        )
      ],
    );
  }
}
