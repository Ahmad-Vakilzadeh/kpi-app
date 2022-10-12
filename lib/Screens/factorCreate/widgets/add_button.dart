import 'package:flutter/material.dart';

import '../../../constants.dart';

class AddButton extends StatelessWidget {
  AddButton({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final TextEditingController controller;

  late bool ifComplete = controller.value.text.isNotEmpty;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 25,
      ),
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: ifComplete ? kPrimaryColor : Colors.grey,
      ),
      child: const Center(
        child: Text(
          "اضافه کردن لوله",
          textAlign: TextAlign.end,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: "Vazir",
          ),
        ),
      ),
    );
  }
}
