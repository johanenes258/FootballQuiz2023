import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:football_quiz_app/EkListe.dart';
import 'package:football_quiz_app/main.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class Change extends StatefulWidget {
  final int yildiz, anahtar, video;
  const Change({
    super.key,
    required this.video,
    required this.anahtar,
    required this.yildiz,
  });

  @override
  State<Change> createState() => _ChangeState();
}

class _ChangeState extends State<Change> with SingleTickerProviderStateMixin {
  RewardedAd? rewardedAd;
  late TabController _controller;
  late int yildiz, anahtar, video;
  void Tanimla() {
    yildiz = widget.yildiz;
    anahtar = widget.anahtar;
    video = widget.video;
  }

  Future<bool> _onWillPop() async {
    verileriKaydet();
    Navigator.pop(context, [anahtar, yildiz, video]);
    return true;
  }

  @override
  void initState() {
    Tanimla();
    _controller = TabController(length: 4, vsync: this, initialIndex: 0);
    super.initState();
  }

  void verileriKaydet() async {
    final preferences = await SharedPreferences.getInstance();
    preferences.setInt("yildiz", yildiz);
    preferences.setInt("anahtar", anahtar);
  }

  @override
  Widget build(BuildContext context) {
    Widget myWidgets;
    if (video == 0) {
      myWidgets = Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TakasContainer("10", "İzle", Icons.slow_motion_video),
            SatinContainer("20", "₺19,99"),
            SatinContainer("50", "₺44,99"),
            SatinContainer("100", "₺79,99"),
            SatinContainer("200", "₺139,99"),
            SatinContainer("400", "₺239,99"),
          ],
        ),
      );
    } else {
      myWidgets = Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SatinContainer("20", "₺19,99"),
            SatinContainer("50", "₺44,99"),
            SatinContainer("100", "₺79,99"),
            SatinContainer("200", "₺139,99"),
            SatinContainer("400", "₺239,99"),
          ],
        ),
      );
    }
    Widget myWidgets2;
    myWidgets2 = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TakasContainer(
            "1",
            "20",
            Icons.stars_sharp,
          ),
          TakasContainer(
            "3",
            "50",
            Icons.stars_sharp,
          ),
          TakasContainer(
            "5",
            "75",
            Icons.stars_sharp,
          ),
          TakasContainer(
            "10",
            "100",
            Icons.stars_sharp,
          ),
          TakasContainer(
            "20",
            "150",
            Icons.stars_sharp,
          ),
        ],
      ),
    );
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/arkaplan.jpg"),
                fit: BoxFit.fill)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.black),
            title: Text(
              "Coin İşlemleri",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Color.fromARGB(255, 205, 199, 180),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.stars_sharp,
                      color: Color.fromARGB(255, 29, 28, 28),
                    ),
                    SizedBox(width: 2),
                    Text(
                      yildiz.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    SizedBox(width: 5),
                    Icon(
                      Icons.key,
                      color: Color.fromARGB(255, 3, 3, 3),
                    ),
                    SizedBox(width: 2),
                    Text(
                      anahtar.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ],
                ),
              )
            ],
            bottom: TabBar(
                controller: _controller,
                indicatorColor: Colors.black,
                tabs: [
                  ZoomTapAnimation(
                    child: Tab(
                      child: Text(
                        "Satın Al",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  ZoomTapAnimation(
                    child: Tab(
                      child: Text(
                        "Takas Et",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black),
                      ),
                    ),
                  ),
                ]),
          ),
          resizeToAvoidBottomInset: false,
          body: TabBarView(
              controller: _controller, children: [myWidgets, myWidgets2]),
        ),
      ),
    );
  }

  Container SatinContainer(String coin, fiyat) {
    return Container(
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Row(
              children: [
                Text(
                  coin,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 3, right: 3),
                  child: Icon(
                    Icons.key,
                    size: 20,
                  ),
                ),
                Text(
                  "SATIN AL",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
          ),
          ZoomTapAnimation(
              child: Container(
            width: 105,
            height: 40,
            child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  side: BorderSide(width: 0.5),
                  elevation: 5,
                  splashFactory: NoSplash.splashFactory,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  backgroundColor: Color.fromARGB(255, 205, 199, 180),
                ),
                child: Text(
                  fiyat,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                )),
          ))
        ],
      ),
      decoration: BoxDecoration(
          boxShadow: [BoxShadow(blurRadius: 5)],
          color: Color.fromARGB(255, 205, 199, 180),
          borderRadius: BorderRadius.circular(10)),
    );
  }

  Container TakasContainer(String coin, fiyat, IconData icon) {
    return Container(
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Row(
              children: [
                Text(
                  coin,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 3, right: 3),
                  child: Icon(
                    Icons.key,
                    size: 20,
                  ),
                ),
                Text(
                  "SATIN AL",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
          ),
          ZoomTapAnimation(
              child: Container(
            width: 105,
            height: 40,
            child: ElevatedButton(
                onPressed: () {
                  if (fiyat == "İzle") {
                    RewardedAd.load(
                        adUnitId: Platform.isAndroid
                            ? "ca-app-pub-5466834995480304/7771852307"
                            : "ca-app-pub-3940256099942544/1712485313",
                        request: const AdRequest(),
                        rewardedAdLoadCallback:
                            RewardedAdLoadCallback(onAdLoaded: (ad) {
                          rewardedAd = ad;
                          rewardedAd?.show(onUserEarnedReward: ((ad, reward) {
                            setState(() {
                              Fluttertoast.showToast(msg: "Ödülünüz eklendi");
                              anahtar = anahtar + int.parse(coin);
                              video++;
                              verileriKaydet();
                            });
                          }));
                          rewardedAd?.fullScreenContentCallback =
                              FullScreenContentCallback(
                                  onAdFailedToShowFullScreenContent: (ad, err) {
                            ad.dispose();
                          }, onAdDismissedFullScreenContent: (ad) {
                            ad.dispose();
                          });
                        }, onAdFailedToLoad: (err) {
                          debugPrint(err.message);
                        }));
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: Color.fromARGB(255, 205, 199, 180),
                            title: Text(
                              "$coin İpucu Almak İstiyor Musun?",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            actions: [
                              ButtonBar(
                                alignment: MainAxisAlignment.spaceAround,
                                children: [
                                  ZoomTapAnimation(
                                    child: Container(
                                      height: 50,
                                      width: 105,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              foregroundColor: Colors.red,
                                              backgroundColor: Colors.red),
                                          onPressed: () {
                                            Navigator.pop(context,
                                                [anahtar, yildiz, video]);
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Icon(
                                                Icons.close,
                                                color: Colors.white,
                                              ),
                                              Text("İPTAL",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                      color: Colors.white)),
                                            ],
                                          )),
                                    ),
                                  ),
                                  ZoomTapAnimation(
                                    child: Container(
                                      height: 50,
                                      width: 105,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              foregroundColor: Colors.green,
                                              backgroundColor: Colors.green),
                                          onPressed: () {
                                            setState(() {
                                              Fluttertoast.showToast(
                                                  msg: "Takasınız gerçekleşti");
                                              if (yildiz - int.parse(fiyat) >=
                                                  0) {
                                                yildiz =
                                                    yildiz - int.parse(fiyat);
                                                anahtar =
                                                    anahtar + int.parse(coin);
                                                verileriKaydet();
                                                Navigator.pop(context);
                                              } else {
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "Yeterince altınınız yok, lütfen satın alınız");
                                              }
                                            });
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.check_sharp,
                                                color: Colors.white,
                                              ),
                                              Text("EVET",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                      color: Colors.white)),
                                            ],
                                          )),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          );
                        });
                  }
                },
                style: ElevatedButton.styleFrom(
                  side: BorderSide(width: 0.5),
                  elevation: 5,
                  splashFactory: NoSplash.splashFactory,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  backgroundColor: Color.fromARGB(255, 205, 199, 180),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 1),
                      child: Icon(
                        icon,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      fiyat,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ],
                )),
          ))
        ],
      ),
      decoration: BoxDecoration(
          boxShadow: [BoxShadow(blurRadius: 5)],
          color: Color.fromARGB(255, 205, 199, 180),
          borderRadius: BorderRadius.circular(10)),
    );
  }
}
