import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:football_quiz_app/Change.dart';
import 'package:football_quiz_app/KariyerBul.dart';
import 'package:football_quiz_app/KariyerBulPart.dart';
import 'package:football_quiz_app/KariyerBulSoru.dart';
import 'package:football_quiz_app/KariyerListe.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';

class RouteCreater {
  static Route<dynamic>? routecreater(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return routeOlustur(AnaSayfa(), settings);
      case '/Change':
        return routeOlustur(Change(), settings);
      case '/KariyerBulSoru':
        var GelenListe = settings.arguments as List<KariyerListe>;
        var yildiz = settings.arguments as int;
        var anahtar = settings.arguments as int;
        var part = settings.arguments as int;
        var kacincifutbolcu = settings.arguments as int;
        var takimad = settings.arguments as String;
        var AcildiMi = settings.arguments as List<String>;
        var DogruMu = settings.arguments as List<String>;
        var YuzdeKac = settings.arguments as List<String>;

        return routeOlustur(
            KariyerSoru(
              YuzdeKac: YuzdeKac,
              DogruMu: DogruMu,
              AcildiMi: AcildiMi,
              takimad: takimad,
              kacincifutbolcu: kacincifutbolcu,
              part: part,
              anahtar: anahtar,
              yildiz: yildiz,
              Liste: GelenListe,
            ),
            settings);

      case '/KariyerBul':
        var yildiz = settings.arguments as int;
        var anahtar = settings.arguments as int;
        var AcildiMi = settings.arguments as List<String>;
        var DogruMu = settings.arguments as List<String>;
        var YuzdeKac = settings.arguments as List<String>;
        return routeOlustur(
            KariyerBul(
              YuzdeKac: YuzdeKac,
              DogruMu: DogruMu,
              AcildiMi: AcildiMi,
              anahtar: anahtar,
              yildiz: yildiz,
            ),
            settings);
      case '/KariyerPart':
        var part = settings.arguments as int;
        var yildiz = settings.arguments as int;
        var anahtar = settings.arguments as int;
        var deger = settings.arguments as int;
        var takimad = settings.arguments as String;
        var AcildiMi = settings.arguments as List<String>;
        var DogruMu = settings.arguments as List<String>;
        var YuzdeKac = settings.arguments as List<String>;

        return routeOlustur(
            KariyerPart(
              YuzdeKac: YuzdeKac,
              DogruMu: DogruMu,
              AcildiMi: AcildiMi,
              takimad: takimad,
              deger: deger,
              part: part,
              yildiz: yildiz,
              anahtar: anahtar,
            ),
            settings);
    }
    return null;
  }

  static PageRoute<dynamic> routeOlustur(
      Widget gidilicekSayfa, RouteSettings settings) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return MaterialPageRoute(
          builder: (context) => gidilicekSayfa, settings: settings);
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return CupertinoPageRoute(
          builder: (context) => gidilicekSayfa, settings: settings);
    } else {
      return CupertinoPageRoute(
          builder: (context) => gidilicekSayfa, settings: settings);
    }
  }
}
