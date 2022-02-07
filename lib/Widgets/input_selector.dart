import 'package:flutter/material.dart';
import 'package:kpi_app/constants.dart';

class InputSelector extends StatelessWidget {
  const InputSelector({
    required this.icon,
    required this.text,
    required this.name,
    Key? key,
  }) : super(key: key);

  final String name;
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              name,
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
              icon,
              color: kPrimaryColor,
              size: 24,
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 60,
          width: 150,
          decoration: BoxDecoration(
            border: Border.all(color: kShadeDarkColor),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            margin: const EdgeInsets.only(left: 10, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Icons.keyboard_arrow_down_outlined,
                  color: kShadeDarkColor,
                  size: 25,
                ),
                Text(
                  text,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    color: kShadeDarkColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Vazir",
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
