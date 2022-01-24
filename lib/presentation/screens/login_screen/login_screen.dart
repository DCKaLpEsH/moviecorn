import 'package:flutter/material.dart';
import 'package:moviecorn/common/constants/size_constants.dart';
import 'package:moviecorn/presentation/screens/home_screen/widgets/logo.dart';
import 'package:moviecorn/common/extensions/size_extensions.dart';

import 'login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(
            top: Sizes.dimen_32.h.toDouble(),
          ),
          child: Column(
            children: [
              Logo(
                height: Sizes.dimen_12.h.toDouble(),
              ),
              const Expanded(
                child: LoginForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
