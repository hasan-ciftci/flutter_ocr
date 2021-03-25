import 'package:flutter/material.dart';
import 'package:flutter_ocr/view/login/model/user_model.dart';
import 'package:flutter_ocr/view/login/service/login_service.dart';
import 'package:mobx/mobx.dart';

part 'login_view_model.g.dart';

class LoginViewModel = _LoginViewModelBase with _$LoginViewModel;

abstract class _LoginViewModelBase with Store {
  GlobalKey<FormState> formState = GlobalKey();

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
    await Future.delayed(Duration(seconds: 3));
    _loginService.loginUser(User(
        username: usernameController.text, password: passwordController.text));
    isLoadingChange();
  }

  @action
  void isLoadingChange() {
    isLoading = !isLoading;
  }
}
