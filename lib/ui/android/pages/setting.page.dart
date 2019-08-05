import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_bloc/blocs/theme.bloc.dart';
import 'package:shopping_bloc/settings.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeBloc = Provider.of<ThemeBloc>(context);

    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 60,
          ),
          Text(
            "Tema atual ${Settings.theme}",
            textAlign: TextAlign.center,
          ),
          FlatButton(
            child: Text("Light"),
            onPressed: () {
              save("light");
              themeBloc.change("light");
            },
          ),
          FlatButton(
            child: Text("Dark"),
            onPressed: () {
              save("dark");
              themeBloc.change("dark");
            },
          ),
          FlatButton(
            child: Text("Dark-Yellow"),
            onPressed: () {
              save("dark-yellow");
              themeBloc.change("dark-yellow");
            },
          ),
        ],
      ),
    );
  }

  void save(String theme) async {
    var prefes = await SharedPreferences.getInstance();
    await prefes.setString('theme', theme);
  }
}
