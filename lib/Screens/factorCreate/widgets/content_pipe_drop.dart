import 'package:flutter/material.dart';
import 'package:kpi_app/Screens/factorCreate/widgets/pipe_meter_field.dart';

import '../../../constants.dart';

class ContentPipeDropDownButton extends StatelessWidget {
  const ContentPipeDropDownButton({
    Key? key,
    required this.peNumberText,
    required this.pressureText,
    required this.exdiaText,
    required this.iconExist,
    required this.isActive,
  }) : super(key: key);

  final String peNumberText;
  final String pressureText;
  final String exdiaText;
  final bool iconExist;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(
            width: 2,
            color:
                isActive ? kShadeDarkColor : kShadeDarkColor.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          iconExist
              ? const Icon(
                  Icons.arrow_downward,
                  size: 18,
                  color: kShadeDarkColor,
                )
              : Container(),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PipeDropDownText(
                  isActive: isActive,
                  pipeAtribute: peNumberText,
                ),
                PipeDropDownText(
                  pipeAtribute: pressureText,
                  isActive: isActive,
                ),
                PipeDropDownText(
                  pipeAtribute: exdiaText,
                  isActive: isActive,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
