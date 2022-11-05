import 'package:brew_for_crew/models/user.dart';
import 'package:brew_for_crew/screens/wrapper.dart';
import 'package:brew_for_crew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StreamProvider<Anom_User?>.value(
          value: AuthService().user,
          initialData: null,
          catchError: (_, __) => null,
          child: Wrapper()),
    );
  }
}
