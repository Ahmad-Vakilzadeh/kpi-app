import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SavedPiepsScreen extends StatelessWidget {
  const SavedPiepsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Saved Files"),
        //create with prefrences or Json file Json fiels is a little easier for the later project
      ),
    );
  }
}
