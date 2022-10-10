import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../Widgets/input_measure.dart';
import '../../../constants.dart';

class PipeMeterField extends StatelessWidget {
  const PipeMeterField({
    Key? key,
    required this.meterController,
  }) : super(key: key);
  final TextEditingController meterController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp("[0-9]")),
        LengthLimitingTextInputFormatter(12),
        ThousandsFormatter(),
      ],
      controller: meterController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: kShadeDarkColor,
            width: 1,
          ),
        ),
        hintText: "متراژ",
        hintTextDirection: TextDirection.rtl,
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontFamily: "Vazir",
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class PipeDropDownText extends StatelessWidget {
  const PipeDropDownText(
      {Key? key, required this.pipeAtribute, required this.isActive})
      : super(key: key);
  final bool isActive;
  final String pipeAtribute;

  @override
  Widget build(BuildContext context) {
    return Text(
      pipeAtribute,
      style: TextStyle(
        color: isActive ? kShadeDarkColor : kShadeDarkColor.withOpacity(0.8),
        fontWeight: FontWeight.bold,
        fontSize: 14,
        fontFamily: "Vazir",
      ),
    );
  }
}
