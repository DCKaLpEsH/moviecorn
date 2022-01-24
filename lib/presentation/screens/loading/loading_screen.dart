import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:moviecorn/common/constants/size_constants.dart';
import 'package:moviecorn/common/extensions/size_extensions.dart';
import 'package:moviecorn/presentation/bloc/loading/loading_bloc.dart';
import 'package:moviecorn/presentation/screens/loading/loading_circle.dart';
import 'package:moviecorn/presentation/themes/app_colors.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({
    Key? key,
    required this.screen,
  }) : super(key: key);

  final Widget screen;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoadingBloc, LoadingState>(
      builder: (context, state) {
        return Stack(
          children: [
            screen,
            if (state is LoadingStartedState) ...[
              Container(
                decoration: BoxDecoration(
                  color: AppColors.vulcan.withOpacity(0.8),
                ),
                child: Center(
                  child: LoadingCircle(
                    size: Sizes.dimen_200.w.toDouble(),
                  ),
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
