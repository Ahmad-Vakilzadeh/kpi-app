import 'package:flutter/material.dart';

import '../../../constants.dart';

class AddButton extends StatelessWidget {
  AddButton({
    Key? key,
    required this.active,
    required this.controller,
  }) : super(key: key);
  final TextEditingController controller;
  final bool active;

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
        color: ifComplete
            ? active
                ? kPrimaryColor
                : Colors.grey
            : Colors.grey,
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

class AddButtonLowDense extends StatelessWidget {
  AddButtonLowDense({
    Key? key,
    required this.active,
    required this.controllerMeter,
    required this.controllerMoney,
  }) : super(key: key);
  final TextEditingController controllerMeter;
  final TextEditingController controllerMoney;
  final bool active;

  late bool ifCompleteMeter = controllerMeter.value.text.isNotEmpty;
  late bool ifCompleteMoney = controllerMoney.value.text.isNotEmpty;

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
          color: ifCompleteMeter && ifCompleteMoney && active
              ? kPrimaryColor
              : Colors.grey),
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
