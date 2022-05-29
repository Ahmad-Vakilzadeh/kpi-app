import 'package:flutter/material.dart';
import 'package:kpi_app/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: kShadeDarkColor,
            )),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: Card(
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        "درباره ما",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: kShadeDarkColor,
                          fontSize: 34,
                          fontFamily: "Vazir",
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Container(
                        height: 5,
                        width: 100,
                        decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              var url = Uri.parse("tel: 03432750197");
                              // var url = Uri(path: "03432750197", scheme: "tel");
                              if (await canLaunchUrl(url)) {
                                await launchUrl(url);
                              } else {
                                throw 'Could not launch $url';
                              }
                            },
                            child: const Text(
                              "03432750197",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: kShadeDarkColor,
                                fontSize: 20,
                                fontFamily: "Vazir",
                              ),
                            ),
                          ),
                          const Text(
                            "تلفن کارخانه",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: "Vazir",
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "کرمان - کیلومتر پنج جاده زرند",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: kShadeDarkColor,
                              fontSize: 20,
                              fontFamily: "Vazir",
                            ),
                          ),
                          Text(
                            "آدرس",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: "Vazir",
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              var url =
                                  Uri(path: "info@kpico.co", scheme: "mailto");
                              if (await canLaunchUrl(url)) {
                                await launchUrl(url);
                              } else {
                                throw 'Could not launch $url';
                              }
                            },
                            child: const Text(
                              "info@kpico.co",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: kShadeDarkColor,
                                fontSize: 20,
                                fontFamily: "Vazir",
                              ),
                            ),
                          ),
                          const Text(
                            "ایمیل",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: "Vazir",
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
