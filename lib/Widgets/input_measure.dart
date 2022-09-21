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
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
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
          onChanged: (value) {
            widget.onChange();
          },
          inputFormatters: [
            if (widget.numberOnly) ThousandsFormatter(),
            if (widget.numberOnly)
              FilteringTextInputFormatter.allow(RegExp("[0-9]")),
            LengthLimitingTextInputFormatter(12),
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
            output = "," + output;
          }
          output = filteredString[i - 1] + output;
        }
        return output == "0" ? "" : output;
      },
    );
  }
}
