import 'dart:developer';
import 'package:brew_for_crew/models/user.dart';
import 'package:brew_for_crew/screens/authenticate/authenticate.dart';
import 'package:brew_for_crew/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Anom_User?>(context);
    log(user.toString());

    //return either home or authenticatewidget

    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
