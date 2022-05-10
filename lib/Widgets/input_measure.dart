import 'dart:math';

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
    Key? key,
  }) : super(key: key);

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
            if (widget.onChange != null) widget.onChange();
          },
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp("[0-9]")),
            LengthLimitingTextInputFormatter(12),
            ThousandsFormatter(),
          ],
          controller: widget.customController,
          keyboardType: TextInputType.number,
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
        int offset = 0;
        StringBuffer buffer = StringBuffer();
        for (int i = min(3, filteredString.length);
            i <= filteredString.length;
            i += min(3, max(1, filteredString.length - i))) {
          buffer.write(filteredString.substring(offset, i));
          if (i < filteredString.length) {
            buffer.write(separator);
          }
          offset = i;
        }
        return buffer.toString();
      },
    ); 
  }
}
