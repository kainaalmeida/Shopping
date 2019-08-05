import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_bloc/blocs/users.bloc.dart';
import 'package:shopping_bloc/ui/shared/widgets/account/authenticate-user-card.widget.dart';
import 'package:shopping_bloc/ui/shared/widgets/account/unauthenticate-user-card.widget.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<UserBloc>(context);

    return Scaffold(
      body:
          bloc.user == null ? UnAuthenticateUserCard() : AuthenticateUserCard(),
    );
  }
}
