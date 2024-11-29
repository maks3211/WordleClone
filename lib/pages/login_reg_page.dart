import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle_app/helpers/secure_preferences_helper.dart';
import 'package:async_textformfield/async_textformfield.dart';
import 'package:wordle_app/providers/controller.dart';
import 'package:wordle_app/providers/user_provider.dart';
import '../components/input_box.dart';
import '../components/my_async_text_form.dart';
import '../constants/colors.dart';
import '../utils/login_storage.dart';
class LoginRegPage extends StatefulWidget {
  const LoginRegPage({super.key});

  @override
  _LoginRegPageState createState() => _LoginRegPageState();
}

class _LoginRegPageState extends State<LoginRegPage> {
  dynamic _loginValidationMsg ="";
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _isRegistering = false;

  final storage = LoginStorage();

  Future<bool> isValidUsernameRegister(String value) async {
    print("WALIDACJA REJESTRACJA");
    print(value);
    bool exists = await storage.loginExists(value);
    if (exists) {
      _loginValidationMsg = "Login zajęty";
      setState(() {});
      return false;
    } else {
      _loginValidationMsg = "";
      setState(() {});
      return true;
    }
  }

  // Funkcja walidacji dla logowania
  Future<bool> isValidUsernameLogin(String value) async {
    print("WALIDACJA LOGOWNANIE");
    print(value);
    bool exists = await storage.loginExists(value);
    if (!_isRegistering) {
      _loginValidationMsg = exists ? "" : "Login nie istnieje";
      setState(() {});
    }
    return exists;
  }


  Future<bool> isValidPasswordLogin(String username, String password) async
  {
    return await SecurePreferencesHelper().getLoginCredentials(username) == password;
  }

  // Funkcja walidacji dla hasła
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Hasło nie może być puste';
    }
    return null;
  }

  // Funkcja walidacji dla potwierdzenia hasła
  String? _validateConfirmPassword(String? value) {
  if(_isRegistering)
  {  if (value == null || value.isEmpty) {
      return 'Potwierdzenie hasła nie może być puste';
    }
    if (value != _passwordController.text) {
      return 'Hasła muszą się zgadzać';
    }
  }
    return null;
  }

  // Funkcja sprawdzająca formularz
  void _validateForm() async{
    String message ='';
    if (_formKey.currentState?.validate() ?? false) {
      String username = _usernameController.text;
      String password = _passwordController.text;
      if(_isRegistering)
        {
          await storage.addLogin(username);
          await SecurePreferencesHelper().saveLoginCredentials(username, password);
          message = "Dodano nowe konto";
        }
      else
        {
          String? pass = await SecurePreferencesHelper().getLoginCredentials(username);
          if(pass == password)
            {
              message = "Witaj, $username";
              Provider.of<UserProvider>(context, listen: false).setUserName(username);
              Provider.of<Controller>(context,listen: false).updateUserName(username);
              Navigator.of(context).pop();
            }
          else
            {
              print("Poprawne haslo dla $username to: $pass");
              message = "Błędne hasło";
            }
        }


      // Tutaj wykonaj logikę logowania lub rejestracji
    }
    else {
      print("Formularz zawiera błędy");
      message = "Błędne dane";
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Logowanie/Rejestracja"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey, // Przypisujemy klucz formularza
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                MyAsyncTextFormField(validator:  _isRegistering ? isValidUsernameRegister : isValidUsernameLogin,
                    validationDebounce:  Duration(milliseconds: 500),
                    controller: _usernameController,
                    hintText: 'Wprowadź login',
                    isValidatingMessage: 'Szukanie użytkownika',
                  valueIsEmptyMessage: 'Login nie może być pusty',
                  valueIsInvalidMessage:_loginValidationMsg ,
                ),
                InputBox(
                  text: "Hasło",
                  controller: _passwordController,
                  validator: _validatePassword,
                  password: true,  // Ustawienie pola hasła
                ),
                const SizedBox(height: 16),
                // Użycie AnimatedCrossFade do pokazywania/podmieniania pola potwierdzenia hasła
                AnimatedCrossFade(
                  duration: const Duration(milliseconds: 300),
                  firstChild: Container(),
                  secondChild: InputBox(
                    controller: _confirmPasswordController,
                    password: true,
                    text: 'Potwierdź hasło',
                    validator: _validateConfirmPassword,
                  ),
                  crossFadeState: _isRegistering
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: correctGreen, minimumSize: Size(150,60)),
                  onPressed:  _validateForm, // Sprawdzenie, czy przycisk jest aktywny
                  child: Text(_isRegistering ? "Zarejestruj" : "Zaloguj",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Przycisk do zmiany trybu: logowanie/rejestracja
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isRegistering = !_isRegistering;
                    });
                       _usernameController.text = '';
                  },
                  child: Text(
                    _isRegistering
                        ? 'Masz już konto? Zaloguj się'
                        : 'Nie masz konta? Zarejestruj się',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }



}