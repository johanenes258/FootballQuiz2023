import 'dart:async';
import 'dart:io';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:football_quiz_app/KariyerBul.dart';
import 'package:football_quiz_app/RouteCreater.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
      title: 'Flutter Demo',
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

  late int yildiz;
  late int anahtar;
  late List<String> AcildiMi, YuzdeKac;
  late List<String> DogruMu;

  void verileriOku() async {
    final preferences = await SharedPreferences.getInstance();
    YuzdeKac = preferences.getStringList("YuzdeKac") ?? List.filled(14, "0");
    yildiz = preferences.getInt("yildiz") ?? 200;
    anahtar = preferences.getInt("anahtar") ?? 100;
    AcildiMi =
        preferences.getStringList("AcildiMi") ?? List.filled(14, "false");
    DogruMu = preferences.getStringList("DogruMu") ?? List.filled(700, "false");
  }

  void verileriKaydet() async {
    final preferences = await SharedPreferences.getInstance();
    preferences.setInt("yildiz", yildiz);
    preferences.setInt("anahtar", anahtar);
    preferences.setStringList("AcildiMi", AcildiMi);
    preferences.setStringList("DogruMu", DogruMu);
    preferences.setStringList("YuzdeKac", YuzdeKac);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.cyan.shade800),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Container(
                  height: 400,
                  width: 300,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/applogo2.png'))),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: ButtonContainer("Oyna", Icons.sports_soccer)),
              Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: ButtonContainer(
                      "Diğer Uygulamalara Gözat", Icons.search)),
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

  ZoomTapAnimation ButtonContainer(String isim, IconData ikon) {
    return ZoomTapAnimation(
      child: Container(
          height: 60,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [BoxShadow(blurRadius: 5)]),
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => KariyerBul(
                      YuzdeKac: YuzdeKac,
                      DogruMu: DogruMu,
                      AcildiMi: AcildiMi,
                      anahtar: anahtar,
                      yildiz: yildiz,
                    ),
                  ));
            },
            icon: Icon(
              ikon,
              color: Colors.black,
            ),
            label: Text(
              isim,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
                foregroundColor: Color.fromARGB(255, 145, 130, 79),
                splashFactory: NoSplash.splashFactory,
                backgroundColor: Color.fromARGB(255, 145, 130, 79),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
          )),
    );
  }
}
