import 'package:flutter/material.dart';
import 'package:moviecorn/common/constants/size_constants.dart';
import 'package:moviecorn/common/constants/transalations_constants.dart';
import 'package:moviecorn/common/extensions/size_extensions.dart';
import 'package:moviecorn/common/extensions/string_extensions.dart';
import 'package:moviecorn/presentation/screens/home_screen/widgets/button.dart';
import 'package:moviecorn/presentation/themes/app_colors.dart';

class AppDialog extends StatelessWidget {
  const AppDialog({
    Key? key,
    required this.title,
    required this.description,
    required this.buttonText,
    this.image,
  }) : super(key: key);
  final String title;
  final String description;
  final String buttonText;
  final Widget? image;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.vulcan,
      elevation: Sizes.dimen_32,
      insetPadding: EdgeInsets.all(
        Sizes.dimen_32.w.toDouble(),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          Sizes.dimen_8.w.toDouble(),
        ),
      ),
      child: Container(
        padding: EdgeInsets.only(
          top: Sizes.dimen_4.h.toDouble(),
          left: Sizes.dimen_16.w.toDouble(),
          right: Sizes.dimen_16.w.toDouble(),
        ),
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.vulcan,
              blurRadius: Sizes.dimen_16,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title.t(context),
              style: Theme.of(context).textTheme.headline5,
            ),
            Padding(
              padding: EdgeInsets.all(
                Sizes.dimen_6.h.toDouble(),
              ),
              child: Text(
                description.t(context),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
            if (image != null) ...[
              image!,
            ],
            Button(
              text: buttonText,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
