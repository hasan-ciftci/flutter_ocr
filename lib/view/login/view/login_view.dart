import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_ocr/core/components/custom_text_form_field.dart';
import 'package:flutter_ocr/core/constants/color_constants.dart';
import 'package:flutter_ocr/view/login/viewmodel/login_view_model.dart';

import '../../../core/components/custom_elevated_button.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  LoginViewModel loginViewModel;

  @override
  void initState() {
    super.initState();
    loginViewModel = LoginViewModel();
    loginViewModel.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: loginViewModel.scaffoldState,
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            double verticalPadding = constraints.maxHeight * .10;
            double horizontalPadding = constraints.maxWidth * .04;
            return Container(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: verticalPadding, horizontal: horizontalPadding),
                child: Container(
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      spreadRadius: 1,
                      offset: Offset(0.0, 0.0),
                      color: Colors.black12,
                    ),
                  ]),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: horizontalPadding,
                        vertical: horizontalPadding),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        buildTopic(),
                        buildLoginForm(),
                        Observer(
                          builder: (BuildContext context) {
                            return buildLoginButton();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }

  Column buildLoginButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomElevatedButton(
          buttonColor: loginViewModel.isLoading
              ? Colors.black12
              : ColorConstants.ISPARK_YELLOW,
          onPressed: loginViewModel.isLoading
              ? null
              : () {
                  print(loginViewModel.isLoading);
                  loginViewModel.logInUser();
                },
          buttonText: loginViewModel.isLoading
              ? buildLoadingAnimation()
              : Text("Giriş Yap"),
          buttonTextColor: ColorConstants.ISPARK_BLACK,
        ),
      ],
    );
  }

  Form buildLoginForm() {
    return Form(
      key: loginViewModel.formState,
      child: Column(
        children: [
          CustomTextFormField(
            controller: loginViewModel.usernameController,
            isObscure: false,
            hintText: 'Kullanıcı Adı',
            labelText: 'Kullanıcı Adı',
          ),
          SizedBox(
            height: 10,
          ),
          CustomTextFormField(
            controller: loginViewModel.passwordController,
            isObscure: true,
            hintText: 'Parola',
            labelText: 'Parola',
          ),
        ],
      ),
    );
  }

  Flexible buildTopic() => Flexible(
      child: Image.asset('assets/images/logo.png'
          ''));

  Row buildLoadingAnimation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(
            backgroundColor: ColorConstants.ISPARK_WHITE,
            valueColor:
                AlwaysStoppedAnimation<Color>(ColorConstants.ISPARK_YELLOW),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          "Yükleniyor",
          style: TextStyle(color: ColorConstants.ISPARK_BLUE),
        ),
      ],
    );
  }
}
