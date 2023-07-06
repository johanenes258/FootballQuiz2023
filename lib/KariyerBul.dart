import 'package:flutter/services.dart';
import 'package:football_quiz_app/Change.dart';
import 'package:football_quiz_app/EkListe.dart';
import 'package:football_quiz_app/KariyerBulPart.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:football_quiz_app/main.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import 'Github/arc.dart';

class KariyerBul extends StatefulWidget {
  final int yildiz, anahtar;
  final List<String> AcildiMi;
  final List<String> DogruMu, YuzdeKac;

  const KariyerBul({
    super.key,
    required this.YuzdeKac,
    required this.DogruMu,
    required this.yildiz,
    required this.anahtar,
    required this.AcildiMi,
  });

  @override
  State<KariyerBul> createState() => _KariyerBulState();
}

class _KariyerBulState extends State<KariyerBul> {
  @override
  void initState() {
    Tanimla();
    setState(() {});
  }

  late int yildiz, anahtar;
  late List<String> AcildiMi;

  void Ontap(int index) {
    if (AcildiMi.elementAt(index) == "false") {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Color.fromARGB(255, 205, 199, 180),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: Text(
              takimismi.elementAt(index),
              textAlign: TextAlign.center,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            content: Image.asset(
              takimContainer.elementAt(index),
              width: 200,
              height: 200,
            ),
            actions: [
              ButtonBar(
                alignment: MainAxisAlignment.spaceAround,
                children: [
                  ZoomTapAnimation(
                    child: Container(
                      height: 50,
                      width: 105,
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(5)),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.red,
                              backgroundColor: Colors.red),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                              Text("İPTAL",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
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
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(5)),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.green,
                              backgroundColor: Colors.green),
                          onPressed: () {
                            if (yildiz >= 100) {
                              yildiz = yildiz - 100;
                              AcildiMi[index] = "true";
                              verileriKaydet();
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => KariyerPart(
                                        YuzdeKac: widget.YuzdeKac,
                                        DogruMu: widget.DogruMu,
                                        AcildiMi: AcildiMi,
                                        takimad: takimismi.elementAt(index),
                                        deger: index * 50,
                                        part: index + 1,
                                        anahtar: anahtar,
                                        yildiz: yildiz),
                                  ));
                            } else {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Change()));
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.orange,
                              ),
                              Text("100",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
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
        },
      );
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => KariyerPart(
                YuzdeKac: widget.YuzdeKac,
                DogruMu: widget.DogruMu,
                AcildiMi: AcildiMi,
                takimad: takimismi.elementAt(index),
                deger: index * 50,
                part: index + 1,
                anahtar: anahtar,
                yildiz: yildiz),
          ));
    }
  }

  Future<bool> _onWillPop() async {
    return (await Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => AnaSayfa())));
  }

  void Tanimla() {
    yildiz = widget.yildiz;
    anahtar = widget.anahtar;
    AcildiMi = widget.AcildiMi;
  }

  void verileriKaydet() async {
    final preferences = await SharedPreferences.getInstance();
    preferences.setInt("yildiz", yildiz);
    preferences.setInt("anahtar", anahtar);
    preferences.setStringList("AcildiMi", AcildiMi);
  }

  @override
  Widget build(BuildContext context) {
    Widget mywidgets(int index) {
      if (AcildiMi[index] == "false") {
        return Center(
          child: Container(
            width: 60,
            height: 30,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 102, 118, 132),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "100",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: Icon(
                    Icons.star,
                    color: Colors.orange,
                  ),
                )
              ],
            ),
          ),
        );
      } else {
        return Padding(
          padding: const EdgeInsets.only(left: 25),
          child: LinearPercentIndicator(
            backgroundColor: Color.fromARGB(255, 150, 137, 101),
            width: 200,
            barRadius: Radius.circular(5),
            animation: true,
            lineHeight: 20.0,
            animationDuration: 1000,
            percent: int.parse(widget.YuzdeKac[index]) / 50,
            center: Text(
              widget.YuzdeKac[index] + "/50",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            progressColor: Color.fromARGB(255, 41, 44, 43),
          ),
        );
      }
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromARGB(255, 77, 145, 200),
            Color.fromARGB(255, 181, 116, 116)
          ], end: Alignment.bottomCenter, begin: Alignment.topCenter)),
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                leading: ZoomTapAnimation(
                  child: Icon(Icons.arrow_back),
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => AnaSayfa()));
                  },
                ),
                shape: Border(bottom: BorderSide(width: 1)),
                expandedHeight: 110,
                pinned: true,
                backgroundColor: Color.fromARGB(255, 205, 199, 180),
                iconTheme: IconThemeData(color: Colors.black),
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(
                    'TAKIM SEÇ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 18),
                  ),
                ),
                actions: [
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.orange,
                      ),
                      Text(
                        yildiz.toString(),
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
                        anahtar.toString(),
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 10,
                      )
                    ],
                  )
                ],
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 50),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ZoomTapAnimation(
                            onTap: () {
                              Ontap(index);
                            },
                            child: Neumorphic(
                              style: NeumorphicStyle(
                                  border: NeumorphicBorder(width: 6),
                                  boxShape: NeumorphicBoxShape.circle(),
                                  depth: 15,
                                  intensity: 0.5),
                              child: ClipOval(
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  color: Color.fromARGB(255, 205, 199, 180),
                                  child: Container(
                                    margin: EdgeInsets.all(5),
                                    child: Image.asset(
                                      takimContainer.elementAt(index),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          ZoomTapAnimation(
                            onTap: () {
                              Ontap(index);
                            },
                            child: Arc(
                                edge: Edge.LEFT,
                                arcType: ArcType.CONVEY,
                                height: 10.0,
                                clipShadows: [
                                  ClipShadow(
                                      color: Colors.black, elevation: 0.1)
                                ],
                                child: new Container(
                                  width: 250,
                                  height: 70,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        takimismi.elementAt(index),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      mywidgets(index)
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 205, 199, 180),
                                  ),
                                )),
                          )
                        ]),
                  );
                }, childCount: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
