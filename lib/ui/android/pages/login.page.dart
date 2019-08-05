import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_bloc/blocs/users.bloc.dart';
import 'package:shopping_bloc/models/authenticate-user.model.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formkey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var username = '';
  var password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formkey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Usuário",
                  labelStyle: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).primaryColor,
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Usuário inválido';
                  }
                  return null;
                },
                onSaved: (val) {
                  username = val;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Senha",
                  labelStyle: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).primaryColor,
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Senha inválido';
                  }
                  return null;
                },
                onSaved: (val) {
                  password = val;
                },
              ),
              FlatButton(
                child: Text("Entrar"),
                onPressed: () {
                  if (_formkey.currentState.validate()) {
                    _formkey.currentState.save();
                    authenticate(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void authenticate(BuildContext context) async {
    var bloc = Provider.of<UserBloc>(context);

    var user = await bloc.authenticate(
      new AuthenticateModel(
        username: username,
        password: password,
      ),
    );

    if (user != null) {
      Navigator.pop(context);
      return;
    }

    final snackbar = SnackBar(content: Text("Usuário ou senha inválidos"));
    _scaffoldKey.currentState.showSnackBar(snackbar);
  }
}
