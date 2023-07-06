import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:football_quiz_app/Change.dart';
import 'package:football_quiz_app/KariyerBul.dart';
import 'package:football_quiz_app/KariyerBulSoru.dart';
import 'package:football_quiz_app/KariyerListe.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class KariyerPart extends StatefulWidget {
  final int part, yildiz, anahtar, deger;
  final String takimad;
  final List<String> AcildiMi, DogruMu, YuzdeKac;

  const KariyerPart(
      {Key? key,
      required this.YuzdeKac,
      required this.DogruMu,
      required this.AcildiMi,
      required this.takimad,
      required this.deger,
      required this.part,
      required this.anahtar,
      required this.yildiz})
      : super(key: key);

  @override
  State<KariyerPart> createState() => _KariyerPartState();
}

class _KariyerPartState extends State<KariyerPart> {
  Future<List<KariyerListe>> JsonOku() async {
    String okunanString = await DefaultAssetBundle.of(context)
        .loadString('assets/data/KariyerListe.json');
    var jsonObject = jsonDecode(okunanString);
    List<KariyerListe> liste = (jsonObject as List)
        .map((listeMap) => KariyerListe.fromMap(listeMap))
        .toList();

    return liste;
  }

  Future<bool> _onWillPop() async {
    return (await Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => KariyerBul(
            YuzdeKac: widget.YuzdeKac,
            DogruMu: widget.DogruMu,
            AcildiMi: widget.AcildiMi,
            anahtar: anahtar,
            yildiz: yildiz,
          ),
        )));
  }

  late int part, yildiz, anahtar;
  bool BittiMi = false;
  late Color renk;
  Color DogrulukRengi(int index) {
    if (widget.DogruMu[index + widget.deger] == "true") {
      return Color.fromARGB(255, 46, 87, 183);
    } else {
      if (index == 0) {
        return Colors.black;
      } else if (widget.DogruMu[widget.deger + index - 1] == "true" &&
          widget.DogruMu[widget.deger + index] == "false") {
        return Colors.black;
      } else {
        return Color.fromARGB(255, 205, 199, 180);
      }
    }
  }

  void Tanimla() {
    part = widget.part;
    yildiz = widget.yildiz;
    anahtar = widget.anahtar;
  }

  @override
  void initState() {
    Tanimla();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromARGB(255, 77, 145, 200),
          Color.fromARGB(255, 181, 116, 116)
        ], end: Alignment.bottomCenter, begin: Alignment.topCenter)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leading: Padding(
              padding: EdgeInsets.only(bottom: 52),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => KariyerBul(
                          YuzdeKac: widget.YuzdeKac,
                          DogruMu: widget.DogruMu,
                          yildiz: yildiz,
                          anahtar: anahtar,
                          AcildiMi: widget.AcildiMi,
                        ),
                      ));
                },
                child: Icon(Icons.arrow_back),
              ),
            ),
            toolbarHeight: 110,
            shape: Border(bottom: BorderSide(width: 1)),
            backgroundColor: Color.fromARGB(255, 205, 199, 180),
            iconTheme: IconThemeData(color: Colors.black),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                widget.takimad,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 24),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(bottom: 52),
                child: Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.orange,
                    ),
                    Text(
                      '$yildiz',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.key,
                      color: Colors.blue,
                    ),
                    Text(
                      '$anahtar',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 10,
                    )
                  ],
                ),
              )
            ],
          ),
          resizeToAvoidBottomInset: false,
          body: CustomScrollView(
            slivers: [
              SliverGrid(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return FutureBuilder<List<KariyerListe>>(
                    future: JsonOku(),
                    builder: (context, snapshot) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: ZoomTapAnimation(
                          onTap: () {
                            if (widget.DogruMu[widget.deger + index] ==
                                "true") {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Change()));
                            } else {
                              if (index == 0) {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => KariyerSoru(
                                        YuzdeKac: widget.YuzdeKac,
                                        DogruMu: widget.DogruMu,
                                        AcildiMi: widget.AcildiMi,
                                        takimad: widget.takimad,
                                        kacincifutbolcu: widget.deger + index,
                                        Liste: snapshot.requireData,
                                        part: part,
                                        anahtar: anahtar,
                                        yildiz: yildiz,
                                      ),
                                    ));
                              } else if (widget
                                      .DogruMu[widget.deger + index - 1] ==
                                  "true") {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => KariyerSoru(
                                        YuzdeKac: widget.YuzdeKac,
                                        DogruMu: widget.DogruMu,
                                        AcildiMi: widget.AcildiMi,
                                        takimad: widget.takimad,
                                        kacincifutbolcu: widget.deger + index,
                                        Liste: snapshot.requireData,
                                        part: part,
                                        anahtar: anahtar,
                                        yildiz: yildiz,
                                      ),
                                    ));
                              } else {}
                            }
                          },
                          child: Neumorphic(
                            margin: EdgeInsets.all(5),
                            style: NeumorphicStyle(
                                boxShape: NeumorphicBoxShape.circle(),
                                border: NeumorphicBorder(width: 5),
                                depth: 15,
                                intensity: 0.4),
                            child: ClipOval(
                              child: Container(
                                width: 100,
                                height: 100,
                                color: Color.fromARGB(255, 165, 146, 82),
                                child: Center(
                                    child: Text(
                                  (index + 1).toString(),
                                  style: TextStyle(
                                      color: DogrulukRengi(index),
                                      fontSize: 36,
                                      fontWeight: FontWeight.bold),
                                )),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }, childCount: 50),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
