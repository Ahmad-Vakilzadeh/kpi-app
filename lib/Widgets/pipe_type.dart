import 'package:flutter/material.dart';

import '../constants.dart';

// ignore: must_be_immutable
class PipeTypeWidget extends StatefulWidget {
  PipeTypeWidget({Key? key, 
    required this.peNumber,
    required this.onTapOne,
    required this.onTapTwo,
    required this.onTapFour,
    required this.onTapThree,
  }) : super(key: key);
  late int peNumber;
  Function onTapOne;
  Function onTapTwo;
  Function onTapThree;
  Function onTapFour;

  @override
  State<PipeTypeWidget> createState() => _PipeTypeWidgetState();
}

class _PipeTypeWidgetState extends State<PipeTypeWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 65,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xffC6E0E8),
        borderRadius: BorderRadius.circular(15),
      ),
      child: widget.peNumber == 80
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      widget.onTapOne();
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Center(
                        child: Text(
                          "PE80",
                          style: TextStyle(
                            color: kShadeDarkColor,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Vazir",
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      widget.onTapTwo();
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Center(
                        child: Text(
                          "PE100",
                          style: TextStyle(
                            color: Color(0xff5795A1),
                            fontWeight: FontWeight.bold,
                            fontFamily: "Vaizr",
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          : Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      widget.onTapThree();
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Center(
                        child: Text(
                          "PE80",
                          style: TextStyle(
                            color: Color(0xff5795A1),
                            fontWeight: FontWeight.bold,
                            fontFamily: "Vaizr",
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      widget.onTapFour();
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Center(
                        child: Text(
                          "PE100",
                          style: TextStyle(
                            color: kShadeDarkColor,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Vaizr",
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
