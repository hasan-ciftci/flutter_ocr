import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_ocr/core/components/rectangle_text_form_field.dart';
import 'package:flutter_ocr/core/constants/app_constants.dart';
import 'package:flutter_ocr/core/constants/color_constants.dart';
import 'package:flutter_ocr/core/constants/style_constants.dart';
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
    return Container(
      decoration: BoxDecoration(gradient: StyleConstants.kYellowLinearGradient),
      child: Scaffold(
          extendBodyBehindAppBar: false,
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          appBar: buildAppBar(
              appBarText: ApplicationConstants.COMPANY_NAME,
              appBarTextColor: ColorConstants.ISPARK_YELLOW,
              appBarColor: ColorConstants.ISPARK_BLACK),
          body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              double height = constraints.maxHeight;
              return Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: SingleChildScrollView(
                  reverse: true,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: height * .2),
                        buildTopic(),
                        SizedBox(height: height * .05),
                        buildLoginForm(),
                        SizedBox(height: height * .05),
                        Observer(
                          builder: (BuildContext context) {
                            return buildLoginButton();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          )),
    );
  }

  AppBar buildAppBar(
      {@required String appBarText,
      @required Color appBarTextColor,
      @required Color appBarColor}) {
    return AppBar(
      backgroundColor: appBarColor,
      centerTitle: true,
      title: Text(
        appBarText,
        style: TextStyle(color: appBarTextColor),
      ),
    );
  }

  Column buildLoginButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        loginViewModel.isLoading ? buildLoadingAnimation() : SizedBox(),
        CustomElevatedButton(
          buttonColor: loginViewModel.isLoading
              ? Colors.black12
              : ColorConstants.ISPARK_BLUE,
          onPressed: loginViewModel.isLoading
              ? null
              : () {
                  print(loginViewModel.isLoading);
                  loginViewModel.logInUser();
                },
          buttonText: 'Giriş Yap',
          buttonTextColor: ColorConstants.ISPARK_WHITE,
        ),
      ],
    );
  }

  Form buildLoginForm() {
    return Form(
      key: loginViewModel.formState,
      child: Column(
        children: [
          RectangleTextFormField(
            controller: loginViewModel.usernameController,
            isObscure: false,
            hintText: 'Kullanıcı Adı',
          ),
          SizedBox(
            height: 10,
          ),
          RectangleTextFormField(
            controller: loginViewModel.passwordController,
            isObscure: true,
            hintText: 'Parola',
          ),
        ],
      ),
    );
  }

  Center buildTopic() => Center(
          child: Text(
        "Kullanıcı Giriş Formu",
        style: TextStyle(
            color: ColorConstants.ISPARK_BLACK, fontWeight: FontWeight.bold),
        textScaleFactor: 1.4,
      ));

  Row buildLoadingAnimation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(
            backgroundColor: ColorConstants.ISPARK_BLUE,
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
