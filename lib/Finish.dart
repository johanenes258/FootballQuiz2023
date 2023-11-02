import 'dart:ffi';
import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:football_quiz_app/Change.dart';
import 'package:football_quiz_app/IconListe.dart';
import 'package:football_quiz_app/KariyerBul.dart';
import 'package:football_quiz_app/KariyerBulPart.dart';
import 'package:football_quiz_app/KariyerListe.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class Finish extends StatefulWidget {
  final List<KariyerListe> Liste;
  final String takimad;
  final int yildiz, anahtar, part, kacincifutbolcu, winstreak, video;
  final List<String> AcildiMi, DogruMu, YuzdeKac;
  const Finish({
    super.key,
    required this.video,
    required this.winstreak,
    required this.DogruMu,
    required this.YuzdeKac,
    required this.AcildiMi,
    required this.takimad,
    required this.kacincifutbolcu,
    required this.Liste,
    required this.part,
    required this.anahtar,
    required this.yildiz,
  });

  @override
  State<Finish> createState() => _FinishState();
}

class _FinishState extends State<Finish> {
  Future<bool> _onWillPop() async {
    return (await Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => KariyerPart(
            video: widget.video,
            winstreak: widget.winstreak,
            YuzdeKac: widget.YuzdeKac,
            DogruMu: DogruMu,
            AcildiMi: widget.AcildiMi,
            takimad: widget.takimad,
            deger: (widget.part - 1) * 50,
            part: widget.part,
            anahtar: anahtar,
            yildiz: yildiz,
          ),
        )));
  }

  late String isim, soyisim;
  late int yildiz, anahtar, kim, takim;
  late List<String> isimListe = List.filled(20, '');
  late List<String> soyisimListe = List.filled(20, '');
  late List<String> DogruMu, YuzdeKac;
  @override
  void initState() {
    DogruMu = widget.DogruMu;
    kim = widget.kacincifutbolcu;
    takim = widget.Liste.elementAt(kim).takim;
    isim = widget.Liste.elementAt(kim).isim;
    soyisim = widget.Liste.elementAt(kim).soyisim;
    yildiz = widget.yildiz;
    anahtar = widget.anahtar;
    for (int i = 0; i < isim.length; i++) {
      isimListe[i] = isim.substring(i, i + 1);
    }
    for (int i = 0; i < soyisim.length; i++) {
      soyisimListe[i] = soyisim.substring(i, i + 1);
    }
    super.initState();
  }

  void IpucuAl(String Button) {
    if (Button == "MEVKİ") {
      Fluttertoast.showToast(
          msg: "MEVKİ: ${widget.Liste.elementAt(kim).pozisyon}");
    } else if (Button == "UYRUK") {
      Fluttertoast.showToast(
          msg: "UYRUK: ${widget.Liste.elementAt(kim).uyruk}");
    }
  }

  double ContainerIsimGenisligi() {
    if (isim.length > 10) {
      return 30;
    } else if (isim.length > 8) {
      return 30;
    } else {
      return 40;
    }
  }

  double ContainerSoyIsimGenisligi() {
    if (soyisim.length > 10) {
      return 30;
    } else if (soyisim.length > 8) {
      return 35;
    } else {
      return 40;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> mywidgets = [];
    for (int i = 0; i < isim.length; i++) {
      mywidgets.add(Padding(
        padding: const EdgeInsets.only(top: 10, left: 1),
        child: SizedBox(
          width: ContainerIsimGenisligi(),
          height: 45,
          child: TextButton(
            style: TextButton.styleFrom(
                shadowColor: Colors.amber,
                side: BorderSide(width: 0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                backgroundColor: Colors.green,
                alignment: Alignment.center),
            onPressed: () {},
            child: Text(
              isimListe[i],
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ));
    }
    List<Widget> mywidgets2 = [];
    for (int i = 0; i < soyisim.length; i++) {
      mywidgets2.add(Padding(
        padding: const EdgeInsets.only(top: 10, left: 1),
        child: SizedBox(
          width: ContainerSoyIsimGenisligi(),
          height: 45,
          child: TextButton(
            style: TextButton.styleFrom(
                side: BorderSide(width: 0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                backgroundColor: Colors.green,
                alignment: Alignment.center),
            onPressed: () {},
            child: Text(
              soyisimListe[i],
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ));
    }

    List<Widget> mywidgets6 = [];
    if (soyisim != "") {
      mywidgets6.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: mywidgets,
        ),
      );
      mywidgets6.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: mywidgets2,
        ),
      );
    } else {
      mywidgets6.add(
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: mywidgets,
          ),
        ),
      );
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/arkaplan.jpg"),
                  fit: BoxFit.fill)),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: IconButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => KariyerPart(
                                        video: widget.video,
                                        winstreak: widget.winstreak,
                                        YuzdeKac: widget.YuzdeKac,
                                        DogruMu: DogruMu,
                                        AcildiMi: widget.AcildiMi,
                                        takimad: widget.takimad,
                                        deger: (widget.part - 1) * 50,
                                        part: widget.part,
                                        anahtar: anahtar,
                                        yildiz: yildiz,
                                      ),
                                    ));
                              },
                              icon: Icon(
                                Icons.arrow_back,
                                size: 32,
                                color: Colors.black,
                              )),
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 180),
                            child: Container(
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(width: 5),
                                  Icon(
                                    Icons.lightbulb_circle_outlined,
                                    color: Color.fromARGB(255, 3, 3, 3),
                                  ),
                                  SizedBox(width: 2),
                                  Text(
                                    anahtar.toString(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              width: 125,
                              height: 30,
                              decoration: BoxDecoration(
                                  border: Border.all(width: 1),
                                  borderRadius: BorderRadius.circular(15)),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 50, bottom: 20),
                  child: ScrollSnapList(
                    dynamicItemSize: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (p0, p1) {
                      return Container(
                        width: 150,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage("assets/images/buttonplan.jpg"),
                                fit: BoxFit.fill),
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(IconListesi.elementAt(kim)[p1 + 10],
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Image.asset(
                              IconListesi.elementAt(kim)[p1],
                              width: 100,
                              height: 100,
                            ),
                            Text(
                              IconListesi.elementAt(kim)[p1 + 20],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: takim,
                    itemSize: 150,
                    onItemFocus: (p0) {},
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 80, bottom: 10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: mywidgets6),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 80, left: 5, right: 5, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Cont('MEVKİ'),
                    Cont('UYRUK'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  ZoomTapAnimation Cont(String title, {Function}) {
    return ZoomTapAnimation(
      child: Container(
        width: 120,
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              foregroundColor: Color.fromARGB(255, 239, 156, 84),
              splashFactory: NoSplash.splashFactory,
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              backgroundColor: Color.fromARGB(255, 239, 156, 84)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(color: Colors.black),
              ),
              Container(
                height: 30,
                width: 36,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(width: 1)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.lightbulb_circle_outlined,
                      size: 25,
                      color: Colors.black,
                    ),
                    Text(
                      "0",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    )
                  ],
                ),
              )
            ],
          ),
          onPressed: () {
            if (title == "UYRUK") {
              IpucuAl("UYRUK");
            } else if (title == "MEVKİ") {
              IpucuAl("MEVKİ");
            }
          },
        ),
      ),
    );
  }
}
