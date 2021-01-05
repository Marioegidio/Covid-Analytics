// import 'package:charts_flutter/flutter.dart';
import 'package:intl/intl.dart';
// import 'dart:convert';

class FormatoNumeri {
  static NumberFormat formatter;

  static NumberFormat getFormatter() {
    if (formatter == null) {
      formatter = new NumberFormat("#,##0", "it_IT");
      formatter.maximumFractionDigits =
          3; // valore che resta impostato dall'ultima chiamata
    }
    return formatter;
  }

  static String formattaNumero(int numero) {
    try {
      return getFormatter().format(numero);
    } catch (e) {
      return "0";
    }
  }

  static String formattaNumeroPercentuale(dynamic numero,
      {int maxCifreDecimali = 2,
      bool conSegno = true,
      String defaultValue = ""}) {
    try {
      //NumberFormat tmpFormatter=NumberFormat.decimalPattern("it_IT");
      String strDecimals = "##########".substring(0, maxCifreDecimali);
      NumberFormat formatter = new NumberFormat("#.$strDecimals%", "it_IT");
      //NumberFormat formatter = getFormatter();
      //formatter.maximumFractionDigits = maxCifreDecimali;
      String conv = formatter.format(numero);
      if (conSegno && numero > 0) {
        conv = "+" + conv;
      }
      return conv;
    } catch (e) {
      return defaultValue;
    }
  }

  static String formattaNumeroCompatto(int numero,
      {String suffissoMilioni = "",
      String suffisso = "",
      bool conSegno = false}) {
    String segno = "";
    try {
      if (numero >= 1000000) {
        if (conSegno) {
          segno = "+";
        }
        return segno +
            NumberFormat.compact(locale: "it_IT").format(numero) +
            suffissoMilioni;
      } else {
        if (conSegno) {
          if (numero > 0) {
            segno = "+";
          }
        }
        return segno + formattaNumero(numero) + suffisso;
      }
    } catch (e) {
      return "0";
    }
  }

/******************** CONVERSIONE DI NUMERI SICURA ************************/
  double StringToDouble(String numero, {double defaultValue = 0}) {
    try {
      return double.tryParse(numero) ?? defaultValue;
    } catch (e) {
      return defaultValue;
    }
  }

  double IntToDouble(int numero, {double defaultValue = 0}) {
    try {
      return numero.toDouble();
    } catch (e) {
      return defaultValue;
    }
  }

  int StringToInt(String numero, {int defaultValue = 0}) {
    try {
      return int.tryParse(numero) ?? defaultValue;
    } catch (e) {
      return defaultValue;
    }
  }

  int DynamicToInt(dynamic numero, {int defaultValue = 0}) {
    try {
      if (dynamic.runtimeType == int) {
        return int.parse(numero.toString()); //vogliamo l'eccezione
      }
    } catch (e) {}
    try {
      if (dynamic.runtimeType == String) {
        return int.parse(numero); //vogliamo l'eccezione
      }
    } catch (e) {
      return defaultValue;
    }
  }
}
