import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviecorn/common/constants/route_constants.dart';
import 'package:moviecorn/common/constants/size_constants.dart';
import 'package:moviecorn/common/constants/transalations_constants.dart';
import 'package:moviecorn/common/extensions/size_extensions.dart';
import 'package:moviecorn/common/extensions/string_extensions.dart';
import 'package:moviecorn/presentation/bloc/login/login_bloc.dart';
import 'package:moviecorn/presentation/screens/home_screen/widgets/button.dart';

import '../../routes.dart';
import 'label_field_widget.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late TextEditingController _userNameController, _passwordController;
  bool enableSignIn = false;
  @override
  void initState() {
    super.initState();
    _userNameController = TextEditingController();
    _passwordController = TextEditingController();
    _userNameController.addListener(() {
      setState(() {
        enableSignIn = _userNameController.text.isNotEmpty &&
            _passwordController.text.isNotEmpty;
      });
    });
    _passwordController.addListener(() {
      setState(() {
        enableSignIn = _userNameController.text.isNotEmpty &&
            _passwordController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Sizes.dimen_32.w.toDouble(),
          vertical: Sizes.dimen_24.h.toDouble(),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Sizes.dimen_32.w.toDouble(),
                vertical: Sizes.dimen_24.h.toDouble(),
              ),
              child: Text(
                TranslationsConstants.loginToMovieApp.t(context),
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            LabelFieldWidget(
              label: TranslationsConstants.username.t(context),
              hintText: TranslationsConstants.enterTMDbUsername.t(context),
              controller: _userNameController,
            ),
            LabelFieldWidget(
              label: TranslationsConstants.password.t(context),
              hintText: TranslationsConstants.username.t(context),
              controller: _passwordController,
              // isPasswordField: true,
            ),
            BlocConsumer<LoginBloc, LoginState>(
              buildWhen: (previous, current) => current is LoginError,
              listener: (context, state) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  RouteConstants.home,
                  (route) => false,
                );
              },
              listenWhen: (previous, current) => current is LoginSuccess,
              builder: (context, state) {
                if (state is LoginError) {
                  return Text(state.message.t(context),
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            color: Colors.orange,
                          ));
                }
                // return const Text("WRONG");
                return const SizedBox.shrink();
              },
            ),
            Button(
              text: TranslationsConstants.signIn,
              onPressed: enableSignIn
                  ? () {
                      BlocProvider.of<LoginBloc>(context).add(LoginInitialEvent(
                        username: _userNameController.text,
                        password: _passwordController.text,
                      ));
                    }
                  : () {},
              isEnabled: enableSignIn,
            ),
          ],
        ),
      ),
    );
  }
}
