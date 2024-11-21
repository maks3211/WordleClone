import 'package:flutter/material.dart';
import 'package:wordle_app/constants/colors.dart';

import '../components/framed_text.dart';
import '../components/input_box.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LOGOWANIE"),
        centerTitle: true,
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 35, 0, 0),
            child: Center(
              child: FramedText(
                text: "WIGWAM",
                borderColors: const [correctGreen, containsYellow, lightThemeDarkShade,correctGreen,containsYellow,lightThemeDarkShade], // Różne kolory dla każdej litery
              ),
            ),
          ),
          InputBox(text: "Login",controller: loginController,),
          InputBox(text:"Hasło", password: true,controller: passwordController,),
           Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white12, minimumSize: Size(200,60)),
                onPressed: () {
                  print("guzik klik");
                  String login = loginController.text;
                  String password = passwordController.text;

                  // Przykładowe operacje, np. wyświetlenie danych w konsoli
                  print("Login: $login");
                  print("Hasło: $password");
                },
                child: Text("Zaloguj",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}


