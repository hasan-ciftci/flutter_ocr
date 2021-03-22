import 'package:flutter/material.dart';
import 'package:flutter_ocr/core/components/rectangle_text_form_field.dart';
import 'package:flutter_ocr/core/init/constants/app_constants.dart';
import 'package:flutter_ocr/core/init/constants/color_constants.dart';
import 'package:flutter_ocr/core/init/constants/navigation_root_name_constants.dart';
import 'package:flutter_ocr/core/init/navigation/navigation_service.dart';

import '../../../core/components/custom_elevated_button.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: false,
        resizeToAvoidBottomInset: false,
        backgroundColor: ColorConstants.ISPARK_YELLOW,
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
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: height * .2),
                      buildTopic(),
                      SizedBox(height: height * .05),
                      buildLoginForm(),
                      SizedBox(height: height * .05),
                      buildLoginButton(),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
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

  CustomElevatedButton buildLoginButton() {
    return CustomElevatedButton(
      buttonColor: ColorConstants.ISPARK_BLUE,
      onPressed: () {
        NavigationService.instance
            .navigateToPage(path: NavigationConstants.HOME_VIEW);
      },
      buttonText: 'Giriş Yap',
      buttonTextColor: ColorConstants.ISPARK_WHITE,
    );
  }

  Form buildLoginForm() {
    return Form(
      child: Column(
        children: [
          RectangleTextFormField(
            isObscure: false,
            hintText: 'Kullanıcı Adı',
          ),
          SizedBox(
            height: 10,
          ),
          RectangleTextFormField(
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
}
