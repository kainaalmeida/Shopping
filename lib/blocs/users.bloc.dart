import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_bloc/models/authenticate-user.model.dart';
import 'package:shopping_bloc/models/create-user.model.dart';
import 'package:shopping_bloc/models/user.model.dart';
import 'package:shopping_bloc/repositories/account.repository.dart';
import 'package:shopping_bloc/settings.dart';

class UserBloc extends ChangeNotifier {
  var user = new UserModel();

  UserBloc() {
    user = null;
    loaduser();
  }

  Future<UserModel> authenticate(AuthenticateModel model) async {
    try {
      var prefs = await SharedPreferences.getInstance();
      var repository = new AccountRepository();

      var result = await repository.authenticate(model);

      user = result;
      await prefs.setString('user', jsonEncode(user));

      return result;
    } catch (ex) {
      user = null;
      return null;
    }
  }

  Future<UserModel> create(CreateUserModel model) async {
    try {
      var repository = new AccountRepository();
      var result = await repository.create(model);
      return result;
    } catch (ex) {
      user = null;
      return null;
    }
  }

  logOut() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString(('users'), null);
    user = null;
    notifyListeners();
  }

  Future loaduser() async {
    var prefs = await SharedPreferences.getInstance();
    var userData = prefs.getString('user');

    if (userData != null) {
      var result = UserModel.fromJson(jsonDecode(userData));
      Settings.user = result;
      user = result;
    }
  }
}
