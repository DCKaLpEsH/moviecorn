import 'package:flutter/material.dart';
import 'package:moviecorn/common/constants/size_constants.dart';
import 'package:moviecorn/common/extensions/size_extensions.dart';
import 'package:moviecorn/presentation/themes/app_colors.dart';

class MovieDetailAppBar extends StatelessWidget {
  const MovieDetailAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: Sizes.dimen_12.h.toDouble(),
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.favorite_outline_outlined,
            color: Colors.white,
            size: Sizes.dimen_12.h.toDouble(),
          ),
        ),
      ],
    );
  }
}
