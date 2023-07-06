// To parse this JSON data, do
//
//     final kariyerListe = kariyerListeFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

KariyerListe kariyerListeFromMap(String str) =>
    KariyerListe.fromMap(json.decode(str));

String kariyerListeToMap(KariyerListe data) => json.encode(data.toMap());

class KariyerListe {
  KariyerListe({
    required this.pozisyon,
    required this.uyruk,
    required this.no,
    required this.isim,
    required this.soyisim,
    required this.takim,
  });

  final String pozisyon;
  final String uyruk;
  final int no;
  final String isim;
  final String soyisim;
  final int takim;

  factory KariyerListe.fromMap(Map<String, dynamic> json) => KariyerListe(
        pozisyon: json["pozisyon"],
        uyruk: json["uyruk"],
        no: json["no"],
        isim: json["isim"],
        soyisim: json["soyisim"],
        takim: json["takim"],
      );

  Map<String, dynamic> toMap() => {
        "pozisyon": pozisyon,
        "uyruk": uyruk,
        "no": no,
        "isim": isim,
        "soyisim": soyisim,
        "takim": takim,
      };
}
