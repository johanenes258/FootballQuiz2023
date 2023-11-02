import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:football_quiz_app/Change.dart';
import 'package:football_quiz_app/Finish.dart';
import 'package:football_quiz_app/KariyerBul.dart';
import 'package:football_quiz_app/KariyerBulSoru.dart';
import 'package:football_quiz_app/KariyerListe.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class KariyerPart extends StatefulWidget {
  final int part, yildiz, anahtar, deger, winstreak, video;
  final String takimad;
  final List<String> AcildiMi, DogruMu, YuzdeKac;

  const KariyerPart(
      {Key? key,
      required this.video,
      required this.winstreak,
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
            video: video,
            winstreak: widget.winstreak,
            YuzdeKac: widget.YuzdeKac,
            DogruMu: widget.DogruMu,
            AcildiMi: widget.AcildiMi,
            anahtar: anahtar,
            yildiz: yildiz,
          ),
        )));
  }

  late String yazi;
  late int part, yildiz, anahtar, video;
  bool BittiMi = false;
  late Color renk;
  Color DogrulukRengi(int index) {
    if (widget.DogruMu[index + widget.deger] == "true") {
      return Color.fromARGB(255, 54, 201, 140);
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
    video = widget.video;
  }

  Widget IconTanim(int id) {
    if (widget.DogruMu[id + widget.deger] == "true") {
      return Icon(
        Icons.check,
        color: Colors.green.shade700,
        size: 28,
      );
    } else {
      return Icon(
        Icons.close,
        color: Colors.red.shade700,
        size: 28,
      );
    }
  }

  Future<void> _navigateAndDisplaySelection(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Change(
                video: video,
                anahtar: anahtar,
                yildiz: yildiz,
              )),
    );

    if (!mounted) return;
    setState(() {
      anahtar = result[0];
      yildiz = result[1];
      video = result[2];
    });
  }

  String Yazi(int id, String isim, String soyisim) {
    if (widget.DogruMu[id + widget.deger] == "true") {
      if (soyisim != "") {
        yazi = soyisim;
      } else {
        yazi = isim;
      }
    } else {
      yazi = "?";
    }
    return yazi;
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
            image: DecorationImage(
                image: AssetImage("assets/images/arkaplan.jpg"),
                fit: BoxFit.fill)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: false,
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 10),
                            child: IconButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => KariyerBul(
                                          video: video,
                                          winstreak: widget.winstreak,
                                          YuzdeKac: widget.YuzdeKac,
                                          DogruMu: widget.DogruMu,
                                          yildiz: yildiz,
                                          anahtar: anahtar,
                                          AcildiMi: widget.AcildiMi,
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
                              padding: EdgeInsets.only(left: 150, top: 10),
                              child: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.stars_sharp,
                                    ),
                                    SizedBox(width: 2),
                                    Text(
                                      yildiz.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
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
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                width: 125,
                                height: 30,
                                decoration: BoxDecoration(
                                    border: Border.all(width: 1),
                                    borderRadius: BorderRadius.circular(15)),
                              )),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: IconButton(
                                onPressed: () {
                                  _navigateAndDisplaySelection(context);
                                },
                                icon: Icon(Icons.add_circle_sharp)),
                          )
                        ],
                      ),
                      Image.asset(
                        widget.takimad,
                        width: 70,
                        height: 70,
                      )
                    ],
                  ),
                ),
              ),
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
                                        builder: (context) => Finish(
                                              video: video,
                                              winstreak: widget.winstreak,
                                              YuzdeKac: widget.YuzdeKac,
                                              DogruMu: widget.DogruMu,
                                              AcildiMi: widget.AcildiMi,
                                              takimad: widget.takimad,
                                              kacincifutbolcu:
                                                  widget.deger + index,
                                              Liste: snapshot.requireData,
                                              part: part,
                                              anahtar: anahtar,
                                              yildiz: yildiz,
                                            )));
                              } else {
                                if (index == 0) {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => KariyerSoru(
                                          video: video,
                                          winstreak: widget.winstreak,
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
                                          video: video,
                                          winstreak: widget.winstreak,
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
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "${index + 1}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22),
                                  ),
                                  height: 85,
                                  width: 85,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 5, color: DogrulukRengi(index)),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 5,
                                      )
                                    ],
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/buttonplan.jpg"),
                                        fit: BoxFit.fill),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                ),
                              ],
                            )),
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
