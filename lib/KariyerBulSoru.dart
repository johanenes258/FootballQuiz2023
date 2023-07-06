import 'dart:ffi';
import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:football_quiz_app/Change.dart';
import 'package:football_quiz_app/IconListe.dart';
import 'package:football_quiz_app/KariyerBul.dart';
import 'package:football_quiz_app/KariyerBulPart.dart';
import 'package:football_quiz_app/KariyerListe.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class KariyerSoru extends StatefulWidget {
  final List<KariyerListe> Liste;
  final String takimad;
  final int yildiz, anahtar, part, kacincifutbolcu;
  final List<String> AcildiMi, DogruMu, YuzdeKac;

  const KariyerSoru({
    super.key,
    required this.YuzdeKac,
    required this.DogruMu,
    required this.AcildiMi,
    required this.takimad,
    required this.kacincifutbolcu,
    required this.Liste,
    required this.part,
    required this.anahtar,
    required this.yildiz,
  });

  @override
  State<KariyerSoru> createState() => _KariyerSoruState();
}

class _KariyerSoruState extends State<KariyerSoru> {
  Future<bool> _onWillPop() async {
    verileriKaydet();
    return (await Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => KariyerPart(
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

  int mevki = 3;
  int uyruk = 2;
  int harfal = 1;
  int kontrol = 0;
  String alfabe = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  List<int> visible = List.filled(16, -1);
  List<String> harfler = List.filled(16, 'X');
  List<bool> Boolean = List.filled(16, true);
  late String isim, soyisim;
  late List<Color> Renkisim, Renksoyisim;
  late int yildiz, anahtar, kim, takim, random;
  late List<String> isimListe = List.filled(20, '');
  late List<String> soyisimListe = List.filled(20, '');
  late List<String> DogruMu, YuzdeKac;
  @override
  void initState() {
    DogruMu = widget.DogruMu;
    kim = widget.kacincifutbolcu;
    YuzdeKac = widget.YuzdeKac;
    takim = widget.Liste.elementAt(kim).takim;
    isim = widget.Liste.elementAt(kim).isim;
    soyisim = widget.Liste.elementAt(kim).soyisim;
    Renkisim = List.filled(
      isim.length,
      Color.fromARGB(255, 31, 32, 92),
    );
    Renksoyisim = List.filled(
      soyisim.length,
      Color.fromARGB(255, 31, 32, 92),
    );
    HarfleriBelirle();
    yildiz = widget.yildiz;
    anahtar = widget.anahtar;
    super.initState();
  }

  void IpucuAl(int x, String Button) {
    if (anahtar - x > 0) {
      anahtar = anahtar - x;
      verileriKaydet();
      if (x == 3 || Button == "MEVKİ") {
        setState(() {
          mevki = 0;
        });
        EasyLoading.showToast("MEVKİ: ${widget.Liste.elementAt(kim).pozisyon}");
      } else if (x == 2 || Button == "UYRUK") {
        setState(() {
          uyruk = 0;
        });
        EasyLoading.showToast("UYRUK: ${widget.Liste.elementAt(kim).uyruk}");
      }
    } else
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Change(),
          ));
    setState(() {});
  }

  void HarfYerlestir(String harf, int q) {
    for (int x = 0; x < isim.length; x++) {
      if (isimListe[x] == '') {
        isimListe[x] = harf;
        visible[x] = q;
        setState(() {});
        break;
      } else if (x == isim.length - 1) {
        if (isimListe[isim.length - 1] != '') {
          for (int a = 0; a < soyisim.length; a++) {
            if (soyisimListe[a] == '') {
              soyisimListe[a] = harf;
              visible[a + isim.length] = q;
              setState(() {});
              break;
            }
          }
        }
      }
    }
  }

  void verileriKaydet() async {
    final preferences = await SharedPreferences.getInstance();
    preferences.remove("yildiz");
    preferences.remove("anahtar");
    preferences.setInt("yildiz", yildiz);
    preferences.setInt("anahtar", anahtar);
    preferences.setStringList("DogruMu", DogruMu);
    preferences.setStringList("YuzdeKac", YuzdeKac);
  }

  void DogruKontrol() {
    if (soyisim == "") {
      for (int x = 0; x < isim.length; x++) {
        if (isim.substring(x, x + 1) != isimListe[x]) {
          break;
        } else if (x == isim.length - 1) {
          DogruMu[kim] = "true";
          YuzdeKac[widget.part - 1] =
              (int.parse(YuzdeKac[widget.part - 1]) + 1).toString();
          yildiz = yildiz + 5;
          Renkisim = List.filled(isim.length, Colors.green);
          verileriKaydet();
        }
      }
    } else {
      for (int x = 0; x < isim.length; x++) {
        if (isim.substring(x, x + 1) != isimListe[x]) {
          break;
        } else if (x == isim.length - 1) {
          for (int a = 0; a < soyisim.length; a++) {
            if (soyisim.substring(a, a + 1) != soyisimListe[a]) {
              break;
            } else if (a == soyisim.length - 1) {
              DogruMu[kim] = "true";
              YuzdeKac[widget.part - 1] =
                  (int.parse(YuzdeKac[widget.part - 1]) + 1).toString();
              yildiz = yildiz + 5;
              Renkisim = List.filled(isim.length, Colors.green);
              Renksoyisim = List.filled(soyisim.length, Colors.green);
              verileriKaydet();
            }
          }
        }
      }
    }
  }

  void HarfAliyim() {
    if (harfal == 1) {
      int degisken = 0;
      while (degisken == 0) {
        random = Random().nextInt(isim.length + soyisim.length - 1) + 1;
        if (random <= isim.length) {
          isimListe[random - 1] = isim.substring(random - 1, random);
          setState(() {
            Renkisim[random - 1] = Colors.red;
          });
          degisken++;
          harfal = 0;
          kontrol = 1;
        } else {
          soyisimListe[random - isim.length - 1] =
              soyisim.substring(random - isim.length - 1, random - isim.length);
          setState(() {
            Renksoyisim[random - isim.length - 1] = Colors.red;
          });
          degisken++;
          harfal = 0;
          kontrol = 1;
        }
      }
    }
  }

  void HarfSil(int x) {
    if (kontrol == 0) {
      isimListe[x] = '';
      setState(() {});
    } else {
      if (random - 1 == x) {
      } else {
        isimListe[x] = '';
        setState(() {});
      }
    }
  }

  double KacTakim() {
    if (widget.Liste.elementAt(kim).takim > 4) {
      return 30;
    } else {
      return 45;
    }
  }

  void HarfleriBelirle() {
    for (int i = 0; i < isim.length; i++) {
      harfler[i] = isim.substring(i, i + 1);
    }
    if (soyisim != "") {
      for (int i = 0; i < soyisim.length; i++) {
        harfler[i + isim.length] = soyisim.substring(i, i + 1);
      }
      for (int i = 0; i < 16 - isim.length - soyisim.length; i++) {
        int x = Random().nextInt(alfabe.length - 1);
        harfler[i + isim.length + soyisim.length] = alfabe.substring(x, x + 1);
      }
    } else {
      for (int i = 0; i < 16 - isim.length - soyisim.length; i++) {
        int x = Random().nextInt(alfabe.length - 1);
        harfler[i + isim.length + soyisim.length] = alfabe.substring(x, x + 1);
      }
    }
    setState(() {});
    harfler.shuffle();
  }

  void HarfSil2(int x) {
    if (kontrol == 0) {
      soyisimListe[x] = '';

      setState(() {});
    } else {
      if (random - isim.length - 1 == x) {
      } else {
        soyisimListe[x] = '';

        setState(() {});
      }
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

  double TakimWidth() {
    if (takim == 5) {
      return 55;
    } else if (takim == 6) {
      return 50;
    } else if (takim == 7) {
      return 45;
    } else if (takim == 8) {
      return 38;
    } else if (takim == 9) {
      return 33;
    } else {
      return 66;
    }
  }

  double TakimSize() {
    if (takim == 5) {
      return 30;
    } else if (takim == 6) {
      return 26;
    } else if (takim == 7) {
      return 24;
    } else if (takim == 8) {
      return 21;
    } else if (takim == 9) {
      return 18;
    } else {
      return 36;
    }
  }

  double ArrowSize() {
    if (takim < 5) {
      return 12;
    } else if (takim < 7) {
      return 8;
    } else {
      return 6;
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
                backgroundColor: Renkisim[i],
                alignment: Alignment.center),
            onPressed: () {
              HarfSil(i);
              Boolean[visible[i]] = true;
              setState(() {});
            },
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
                backgroundColor: Renksoyisim[i],
                alignment: Alignment.center),
            onPressed: () {
              HarfSil2(i);
              Boolean[visible[i + isim.length]] = true;
              setState(() {});
            },
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
    List<Widget> mywidgets7 = [];
    if (Renkisim[1] != Colors.green) {
      mywidgets7.add(Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HarfButton(harfler[1], 1),
                HarfButton(harfler[2], 2),
                HarfButton(harfler[3], 3),
                HarfButton(harfler[0], 0),
                HarfButton(harfler[4], 4),
                HarfButton(harfler[5], 5),
                HarfButton(harfler[6], 6),
                HarfButton(harfler[7], 7),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HarfButton(harfler[8], 8),
              HarfButton(harfler[9], 9),
              HarfButton(harfler[10], 10),
              HarfButton(harfler[11], 11),
              HarfButton(harfler[12], 12),
              HarfButton(harfler[13], 13),
              HarfButton(harfler[14], 14),
              HarfButton(harfler[15], 15),
            ],
          ),
        ],
      ));
    } else {
      mywidgets7.add(Container(
        height: 150,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.stars_sharp,
                    size: 48,
                  ),
                  Text(
                    "+5",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: ZoomTapAnimation(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => KariyerPart(
                          YuzdeKac: YuzdeKac,
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
                child: Neumorphic(
                  duration: Duration(seconds: 5),
                  child: Container(
                    color: Color.fromARGB(255, 165, 146, 82),
                    alignment: Alignment.center,
                    width: 200,
                    height: 50,
                    child: Text(
                      "Devam et",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                  ),
                  style: NeumorphicStyle(
                      border: NeumorphicBorder(width: 5),
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(5))),
                ),
              ),
            )
          ],
        ),
      ));
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
                                verileriKaydet();
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => KariyerPart(
                                        YuzdeKac: YuzdeKac,
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
                            padding: EdgeInsets.only(left: 150),
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
                        IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.add_circle_sharp))
                      ],
                    ),
                    Divider()
                  ],
                ),
              ),
              Expanded(
                child: ScrollSnapList(
                  dynamicItemSize: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (p0, p1) {
                    return Container(
                      width: 150,
                      decoration: BoxDecoration(
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
              Padding(
                padding: const EdgeInsets.only(
                  top: 40,
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: mywidgets6),
              ),
              Column(
                children: mywidgets7,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 80, left: 5, right: 5, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Cont('MEVKİ', mevki),
                    Cont('UYRUK', uyruk),
                    Cont('HARF', harfal),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding HarfButton(String harf, int x) {
    return Padding(
      padding: EdgeInsets.only(top: 10, left: 1, right: 1),
      child: ZoomTapAnimation(
        child: Container(
          height: 45,
          width: 45,
          child: Visibility(
            visible: Boolean[x],
            child: ElevatedButton(
                onPressed: () {
                  HarfYerlestir(harf, x);
                  DogruKontrol();
                  Boolean[x] = false;
                  setState(() {});
                },
                style: ElevatedButton.styleFrom(
                  splashFactory: NoSplash.splashFactory,
                  foregroundColor: Color.fromARGB(255, 19, 48, 84),
                  backgroundColor: Color.fromARGB(255, 19, 48, 84),
                  side: BorderSide(width: 0.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  harf,
                  style: TextStyle(color: Colors.white),
                )),
          ),
        ),
      ),
    );
  }

  ZoomTapAnimation Cont(String title, int x, {Function}) {
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
                      x.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    )
                  ],
                ),
              )
            ],
          ),
          onPressed: () {
            if (title == "HARF") {
              HarfAliyim();
              IpucuAl(x, "HARF");
            } else if (title == "UYRUK") {
              IpucuAl(x, "UYRUK");
            } else if (title == "MEVKİ") {
              IpucuAl(x, "MEVKİ");
            }
          },
        ),
      ),
    );
  }
}
