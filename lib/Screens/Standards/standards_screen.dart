// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:kpi_app/Engine/measuring.dart';
import 'package:kpi_app/constants.dart';

class StandardsScreen extends StatefulWidget {
  const StandardsScreen({Key? key}) : super(key: key);

  @override
  State<StandardsScreen> createState() => _StandardsScreenState();
}

Future<List<Map<String, dynamic>>> getDataFromFile() async {
  var data = await SqfL.open();

  List<Map<String, dynamic>> ret =
      await data.rawQuery("SELECT DISTINCT * FROM  standards");
  return ret;
}

List<Widget> createListOfStandards(BuildContext context, Object ret) {
  List<Widget> fields = <Widget>[];
  // ignore: unused_local_variable
  if (ret is! List<Map<String, dynamic>>) {
    return [Container()];
  }
  // ignore: avoid_function_literals_in_foreach_calls
  ret.forEach((element) {
    return fields.add(GestureDetector(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(color: kShadeLiteColor, width: 2),
            borderRadius: BorderRadius.circular(15)),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Row(
          children: [
            Expanded(
              child: Text(
                "${element["title"]}",
                textAlign: TextAlign.right,
                softWrap: true,
                style: const TextStyle(
                    fontFamily: "Vazir", color: kShadeDarkColor, fontSize: 18),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: kOpacityShade,
                  borderRadius: BorderRadius.circular(15)),
              child: const Icon(
                Icons.document_scanner_outlined,
                color: Colors.white,
                size: 24,
              ),
            )
          ],
          mainAxisAlignment: MainAxisAlignment.end,
        ),
      ),
      onTap: () {
        showModalBottomSheet(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(15),
              topRight: const Radius.circular(15),
            )),
            context: context,
            builder: (context) {
              return Container(
                  padding: const EdgeInsets.all(15),
                  height: MediaQuery.of(context).size.height / 4 * 5,
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: Center(
                      child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Icon(
                                    Icons.close,
                                    color: kShadeDarkColor,
                                  )),
                            ],
                          ),
                        ),
                        Text(
                          "${element["title"]}",
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                            fontFamily: "Vazir",
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          replaceArabicYeh(element["desc"]),
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          style: const TextStyle(
                              fontFamily: "Vazir",
                              color: kShadeDarkColor,
                              fontSize: 18),
                        ),
                      ],
                    ),
                  )));
            });
      },
    ));
  });
  return fields;
}

String replaceArabicYeh(String t) {
  return t.replaceAll("ي", "ی").replaceAll("‌", " ").replaceAll("‍", "");
}

class _StandardsScreenState extends State<StandardsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: FutrueListStandards(),
    );
  }
}

class FutrueListStandards extends StatelessWidget {
  const FutrueListStandards({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getDataFromFile(),
      initialData: "loading",
      builder: (BuildContext context, AsyncSnapshot<Object> snapshot) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 25,
                color: Color(0x200D6472),
              )
            ],
          ),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  snapshot.data == null
                      ? Container()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children:
                              createListOfStandards(context, snapshot.data!),
                        ),
                  const SizedBox(
                    height: 96,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
