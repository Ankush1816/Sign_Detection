import 'package:flutter/material.dart';

class DumbHome extends StatefulWidget {
  const DumbHome({Key? key}) : super(key: key);

  @override
  State<DumbHome> createState() => _DumbHomeState();
}

class _DumbHomeState extends State<DumbHome> {
  @override
  Widget build(BuildContext context) {
    // final brews = Provider.of<List<Brew>>(context);
    // // print(brews!.docs);
    // if (brews != null) {
    //   brews.forEach((brew) {
    //     print(brew.name);
    //     print(brew.sugars);
    //     print(brew.strength);
    //   });
    // }

    return Text("Brew List");
  }
}
