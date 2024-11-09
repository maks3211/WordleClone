import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../providers/theme_provider.dart';
import '../utils/theme_preferences.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ustawienia"),
        centerTitle: true,
        elevation:0,  //cien
        actions: [
         /* IconButton(onPressed: (){
            Navigator.maybePop(context);
          }, icon: const Icon(Icons.arrow_back))*/
        ],
      ),
      body: Column(
        children: [
          Consumer<ThemeProvider>(
            builder:(_,notifier,__) {
              bool _isDarkMode = false;  //used for theme settings
              _isDarkMode = notifier.isDark;
              return SwitchListTile(title: const Text("Tryb Ciemny"), value: _isDarkMode, onChanged: (value){

                _isDarkMode = value;
            ThemePreferences.saveTheme(isDark: _isDarkMode);
            Provider.of<ThemeProvider>(context, listen: false).setTheme(dark: _isDarkMode);
            });
            },
          ),
          ListTile(
            leading: const Text('Zresetuj statystyki'),
            onTap: ()async{
              final prefs = await SharedPreferences.getInstance();
              prefs.remove('stats');
              //TODO RESETOWANIE STATYSTYK Z WYKRESÓW
              showDialog(context: context, builder: (context)=> const AlertDialog(
                title: Text("Zresetowano statystyki", textAlign: TextAlign.center,),));
            },
          )
        ],
      ),
    );
  }
}
