import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../Widgets/input_measure.dart';
import '../../../constants.dart';

class SearchBar extends StatefulWidget {
  const SearchBar(
      {Key? key,
      required this.customController,
      required this.hintText,
      required this.onChangeCustom})
      : super(key: key);

  final TextEditingController customController;
  final String hintText;
  final Function onChangeCustom;

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextFormField(
        onChanged: (value) {
          widget.onChangeCustom();
        },
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp("[0-9]")),
          LengthLimitingTextInputFormatter(12),
          ThousandsFormatter(),
        ],
        controller: widget.customController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                width: 1,
                color: kShadeDarkColor.withOpacity(0.5),
              )),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 1,
            ),
          ),
          icon: Icon(
            Icons.search,
            color: kShadeDarkColor.withOpacity(0.5),
          ),
          hintText: widget.hintText,
          hintTextDirection: TextDirection.rtl,
          hintStyle: TextStyle(
            color: kShadeDarkColor.withOpacity(0.5),
            fontFamily: "Vazir",
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
