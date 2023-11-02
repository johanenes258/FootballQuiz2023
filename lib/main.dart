import 'dart:async';
import 'dart:io';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:football_quiz_app/KariyerBul.dart';
import 'package:football_quiz_app/RouteCreater.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FC Quiz',
      onGenerateRoute: RouteCreater.routecreater,
      builder: EasyLoading.init(),
      home: AnimatedSplashScreen(
        splash: Image.asset("assets/images/enesgames.png"),
        duration: 1500,
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: Colors.black,
        nextScreen: AnaSayfa(),
      ),
    );
  }
}

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({
    super.key,
  });

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  Future<bool> _onWillPop() async {
    return (await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: Text(
              "Oyundan çıkmak mı istiyorsunuz?",
              textAlign: TextAlign.center,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            actions: [
              ButtonBar(
                alignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 120,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                        onPressed: () {
                          SystemNavigator.pop();
                          verileriKaydet();
                        },
                        child: Text("OYUNDAN ÇIK",
                            style: TextStyle(fontSize: 12))),
                  ),
                  Container(
                    width: 120,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
                      child: Text(
                        "OYUNA DÖN",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        }));
  }

  @override
  void initState() {
    verileriOku();
    super.initState();
  }

  late int yildiz, anahtar, winstreak, video;
  late List<String> AcildiMi, YuzdeKac;
  late List<String> DogruMu;

  void verileriOku() async {
    final preferences = await SharedPreferences.getInstance();
    YuzdeKac = preferences.getStringList("YuzdeKac") ?? List.filled(20, "0");
    yildiz = preferences.getInt("yildiz") ?? 200;
    anahtar = preferences.getInt("anahtar") ?? 15;
    winstreak = 0;
    video = 0;
    AcildiMi =
        preferences.getStringList("AcildiMi") ?? List.filled(20, "false");
    DogruMu =
        preferences.getStringList("DogruMu") ?? List.filled(1000, "false");
  }

  void verileriKaydet() async {
    final preferences = await SharedPreferences.getInstance();
    preferences.setInt("yildiz", yildiz);
    preferences.setInt("anahtar", anahtar);
    preferences.setStringList("AcildiMi", AcildiMi);
    preferences.setStringList("DogruMu", DogruMu);
    preferences.setStringList("YuzdeKac", YuzdeKac);
    preferences.setInt("winstreak", winstreak);
    preferences.setInt("video", video);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage("assets/images/arkaplan.jpg"),
            fit: BoxFit.fill,
          )),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Container(
                  height: 400,
                  width: 300,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/sadelogo.png'))),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: ButtonContainer("Oyna", Icons.sports_soccer, 115)),
              Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: ButtonContainer(
                      "Diğer Uygulamalara Gözat", Icons.search, 330)),
              Padding(
                  padding: EdgeInsets.only(top: 60),
                  child: Opacity(
                    child: Image.asset(
                      "assets/images/enesgames.png",
                      height: 100,
                      width: 100,
                    ),
                    opacity: 0.5,
                  ))
            ],
          ),
        ),
      ),
    );
  }

  ZoomTapAnimation ButtonContainer(String isim, IconData ikon, double x) {
    return ZoomTapAnimation(
      onTap: () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => KariyerBul(
              video: video,
              winstreak: winstreak,
              YuzdeKac: YuzdeKac,
              DogruMu: DogruMu,
              AcildiMi: AcildiMi,
              anahtar: anahtar,
              yildiz: yildiz,
            ),
          )),
      child: Container(
          width: x,
          height: 60,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/buttonplan.jpg"),
                  fit: BoxFit.fill),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [BoxShadow(blurRadius: 5)]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                ikon,
                color: Colors.black,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Text(
                  isim,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          )),
    );
  }
}
