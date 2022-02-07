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
  var returnedList = ret as List<Map<String, dynamic>>;
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
            Text(
              "${element["title"]}",
              style: const TextStyle(
                  fontFamily: "Vazir", color: kShadeDarkColor, fontSize: 18),
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
                color: kShadeDarkColor,
                size: 24,
              ),
            )
          ],
          mainAxisAlignment: MainAxisAlignment.end,
        ),
      ),
      onTap: () {
        showModalBottomSheet(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            context: context,
            builder: (context) {
              return SingleChildScrollView(
                child: Container(
                    padding: const EdgeInsets.all(15),
                    height: MediaQuery.of(context).size.height / 2,
                    child: Center(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "${element["title"]}",
                          style: const TextStyle(
                            fontSize: 24,
                            color: kShadeDarkColor,
                            fontFamily: "Vazir",
                          ),
                        ),
                        Text(
                          "${element["desc"]}",
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                              fontFamily: "Vazir",
                              color: kShadeDarkColor,
                              fontSize: 18),
                        ),
                      ],
                    ))),
              );
            });
      },
    ));
  });
  return fields;
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
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: createListOfStandards(context, snapshot.data!),
          ),
        );
      },
    );
  }
}
