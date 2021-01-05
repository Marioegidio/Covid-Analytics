import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:covid/Utils/Utility.dart';

class DatiPopolazioneMondiale {
  static Map<String, int> popolazioneNazioni = new Map<String, int>();
  static Map<String, String> codiciNazioni = Map<String, String>();
  final String nome_nazione;
  final String codice_nazione;
  final int numero_abitanti;

  DatiPopolazioneMondiale(
      {this.nome_nazione, this.codice_nazione, this.numero_abitanti});

  static Future<List<dynamic>> parseJsonFromAssets(String assetsPath) async {
    //print('--- Parse json from: $assetsPath');
    return rootBundle
        .loadString(assetsPath)
        .then((jsonStr) => jsonDecode(jsonStr));
  }
//TODO DATI ANCHE DI ITALIA
  // static fromJson() async {
  //   List<dynamic> array = await Utility.fecthPopolazioneMondiale();
  //   if (array == null) return;
  //   int numeroAbitanti;
  //   for (int i = 0; i < array.length; i++) {
  //     Map<String, dynamic> elemento = array[i];
  //     try {
  //       //int.parse
  //       numeroAbitanti = int.tryParse(elemento['population']) ?? 0;
  //     } catch (e) {
  //       numeroAbitanti = 0;
  //     }
  //     popolazioneNazioni[elemento["country"]] = numeroAbitanti;
  //   }
  //   // for (var item in popolazioneNazioni.keys) {
  //   //   if(popolazioneNazioni[item]==0){
  //   //     print(item);
  //   //   }
  //   // }

  //   //salvo anche i codici delle nazioni nell'apposita variabile
  //   Utility.fetchCodiciNazioni().then((val) => {
  //         if (val != null)
  //           for (String s in val.keys) codiciNazioni[s] = val[s]
  //       });
  // }

  // List<DatiPopolazioneMondiale> list = [];
  // for (int i = 0; i < array.length; i++) {
  //   Map<String, dynamic> json = array[i];
  //     //nome_nazione: json['country'].toString(),
  //     int numero= int.tryParse(json['population'].toString()) ?? 0;
  //     popolazioneNazioni.putIfAbsent(json['country'].toString(),() => numero);
  //      //print( DatiPopolazioneMondiale.popolazioneNazioni.containsKey(["Albania"].toString().trim()) ? DatiPopolazioneMondiale.popolazioneNazioni["Albania"]:"0");
  // }
  // return popolazioneNazioni;
  //}
//https://gist.github.com/ssskip/5a94bfcd2835bf1dea52
//var reversed = Map.fromEntries(orig.entries.map((e) => MapEntry(e.value, e.key)));

}
