import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(child: buildTopic()),
            Expanded(child: buildLoginForm()),
            buildLoginButton(),
            Spacer(),
          ],
        ),
      ),
    );
  }

  ElevatedButton buildLoginButton() {
    return ElevatedButton(
      onPressed: () {},
      child: Text("Giriş"),
    );
  }

  Form buildLoginForm() {
    return Form(
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(hintText: "İsim"),
          ),
          TextFormField(
            decoration: InputDecoration(hintText: "Parola"),
          ),
        ],
      ),
    );
  }

  Center buildTopic() => Center(child: Text("Başlık"));
}
