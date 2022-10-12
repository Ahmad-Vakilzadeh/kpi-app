import 'package:auto_direction/auto_direction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart' as intl;
import 'package:kpi_app/Widgets/utils.dart';
import '../constants.dart';

class InputMeasure extends StatefulWidget {
  const InputMeasure({
    required this.hintText,
    required this.icon,
    required this.name,
    required this.customController,
    required this.onChange,
    required this.numberOnly,
    Key? key,
  }) : super(key: key);
  final bool numberOnly;

  final String name;
  final IconData icon;
  final String hintText;
  final TextEditingController customController;
  final Function onChange;

  @override
  State<InputMeasure> createState() => _InputMeasureState();
}

var formatter = intl.NumberFormat('###,###,###');

class _InputMeasureState extends State<InputMeasure> {
  late bool isTypingNumber = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text(
              "*",
              style: TextStyle(color: Colors.red, fontSize: 16),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              widget.name,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: kShadeDarkColor,
                fontFamily: "Vazir",
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Icon(
              widget.icon,
              color: kPrimaryColor,
              size: 24,
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          textAlign: isTypingNumber ? TextAlign.left : TextAlign.right,
          onChanged: (value) {
            setState(() {
              widget.onChange();
              if (value.isNotEmpty) {
                isTypingNumber = true;
              } else if (value.isEmpty) {
                isTypingNumber = false;
              }
            });
          },
          inputFormatters: [
            if (widget.numberOnly)
              FilteringTextInputFormatter.allow(RegExp("[0-9]")),
            if (widget.numberOnly) ThousandsFormatter(),
            if (widget.numberOnly) LengthLimitingTextInputFormatter(12),
          ],
          controller: widget.customController,
          keyboardType:
              widget.numberOnly ? TextInputType.number : TextInputType.name,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: kShadeDarkColor,
                width: 1,
              ),
            ),
            hintText: widget.hintText,
            hintTextDirection: TextDirection.rtl,
            hintStyle: const TextStyle(
              color: Colors.grey,
              fontFamily: "Vazir",
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}

class ThousandsFormatter extends TextInputFormatter {
  final String separator;

  ThousandsFormatter({this.separator = ','});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return textManipulation(
      oldValue,
      newValue,
      textInputFormatter: FilteringTextInputFormatter.digitsOnly,
      formatPattern: (String filteredString) {
        var output = "";
        for (int i = filteredString.length; i > 0; i--) {
          if (i < filteredString.length &&
              (filteredString.length - i) % 3 == 0) {
            output = ",$output";
          }
          output = filteredString[i - 1] + output;
        }
        return output == "0" ? "" : output;
      },
    );
  }
}
