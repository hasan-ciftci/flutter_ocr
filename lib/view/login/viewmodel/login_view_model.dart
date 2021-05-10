import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ocr/core/constants/enums.dart';
import 'package:flutter_ocr/view/login/model/user_model.dart';
import 'package:flutter_ocr/view/login/service/login_service.dart';
import 'package:mobx/mobx.dart';

part 'login_view_model.g.dart';

class LoginViewModel = _LoginViewModelBase with _$LoginViewModel;

abstract class _LoginViewModelBase with Store {
  GlobalKey<FormState> formState = GlobalKey();
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

  TextEditingController usernameController;
  TextEditingController passwordController;
  LoginService _loginService;

  void init() {
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    _loginService = LoginService();
  }

  @observable
  bool isLoading = false;

  @action
  Future<void> logInUser() async {
    isLoadingChange();
    try {
      final response = await _loginService.loginUser(User(
          username: usernameController.text.trim(),
          password: passwordController.text.trim()));
      if (response == false) {
        showSnackBar(
            status: SnackBarStatus.FAIL,
            message: "Şifre veya kullanıcı adı hatalı.");
      }
    } catch (e) {
      if (e is DioError) {
        print(e.message);
        showSnackBar(
            status: SnackBarStatus.FAIL,
            message: "İnternet bağlantısı sorunu oluştu.");
      } else {
        showSnackBar(status: SnackBarStatus.FAIL, message: "Bir sorun oluştu.");
      }
    }

    isLoadingChange();
  }

  showSnackBar({SnackBarStatus status, String message}) {
    ScaffoldMessenger.of(scaffoldState.currentContext).showSnackBar(
      SnackBar(
        elevation: 10,
        duration: Duration(milliseconds: 1500),
        backgroundColor:
            status == SnackBarStatus.SUCCESS ? Colors.green : Colors.red,
        content: Text(message),
      ),
    );
  }

  @action
  void isLoadingChange() {
    isLoading = !isLoading;
  }
}
