import 'package:covid_analytics_web/Data/DatiNazione.dart';
import 'package:covid_analytics_web/Data/DatiProvince.dart';
import 'package:covid_analytics_web/Data/DatiRegione.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import 'helper/config/DatiConfig.dart';

class Utility {
  static int width;
  static double aspectRatio; //quella effettiva
  static double aspectRatioRidotta; //ridotta per nostre esigenze
  //static final formato = new NumberFormat("#,##0", "it_IT");

  static updateDeviceDimension(context) {
    Utility.width = MediaQuery.of(context).size.width.toInt();
    Utility.height = MediaQuery.of(context).size.height.toInt();
    Utility.aspectRatio = MediaQuery.of(context).size.aspectRatio;
    Utility.aspectRatioRidotta = 1.9;
    // print(Utility.aspectRatioRidotta.toString());
  }

  static EdgeInsets margineCards =
      EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 4);

  static int height;

  static Future<List<DatiNazione>> fetchDatiNazione(url,
      {bool isBackupServer = false}) async {
    // Utility.URL_NAZIONE= "https://raw.githubusercontent.com/pcm-dpc/COVID-19/master/dati-json/dpc-covid19-ita-andamento-nazionale.json";
    final response = await http.get(url); //DatiConfig.URL_NAZIONE);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then parse the JSON.

      return DatiNazione.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      // if (!isBackupServer) {
      //   return await Utility.fetchDatiNazione(DatiConfig.URL_NAZIONE_BACKUP,
      //       isBackupServer: false);
      // } else {
      throw Exception('Failed to load data');
      // }
    }
  }

  static Future<List<DatiRegione>> fetchDatiRegioni(url,
      {bool isBackupServer = false}) async {
    // 'https://raw.githubusercontent.com/pcm-dpc/COVID-19/master/dati-json/dpc-covid19-ita-regioni.json';
    final response = await http.get(url); //DatiConfig.URL_REGIONI);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then parse the JSON.

      return DatiRegione.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      // if (!isBackupServer) {
      //   return Utility.fetchDatiRegioni(DatiConfig.URL_REGIONI_BACKUP,
      //       isBackupServer: false);
      // } else {
      throw Exception('Failed to load data');
    }
    // }
  }

  static Future<List<DatiProvince>> fetchDatiProvince(url,
      {bool isBackupServer = false}) async {
    // 'https://raw.githubusercontent.com/pcm-dpc/COVID-19/master/dati-json/dpc-covid19-ita-province.json';
    final response = await http.get(url); //DatiConfig.URL_PROVINCE);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then parse the JSON.

      return DatiProvince.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      // if (!isBackupServer) {
      //   return Utility.fetchDatiProvince(DatiConfig.URL_PROVINCE_BACKUP,
      //       isBackupServer: false);
      // } else {
      throw Exception('Failed to load data');
    }
  }

  // static Future<List<DatiMondiali>> fetchDatiMondiali(url,
  //     {bool isBackupServer = false}) async {
  //   String url = "https://covid-193.p.rapidapi.com/statistics";

  //   //deve completare il caricamento prima di usare caricare i dati dei contagi mondiali'
  //   await DatiPopolazioneMondiale.fromJson();
  //   final response = await http.get(url, headers: {
  //     "x-rapidapi-host": "covid-193.p.rapidapi.com",
  //     "x-rapidapi-key": "c5f85893demsh25f3b94ef993c98p16f883jsnd1b1fb1029ab"
  //   });

  //   if (response.statusCode == 200) {
  //     // If the server did return a 200 OK response, then parse the JSON.

  //     return DatiMondiali.fromJson(
  //         json.decode(utf8.decode(response.bodyBytes)));
  //   } else {
  //     // If the server did not return a 200 OK response, then throw an exception.
  //     if (!isBackupServer) {
  //       return Utility.fetchDatiMondiali(DatiConfig.URL_MONDO_BACKUP,
  //           isBackupServer: true);
  //     } else {
  //       return null; //throw Exception('Failed to load data');
  //     }
  //   }
  // }
  // static Future<List<DatiMondiali>> fetchDatiMondiali(url,{bool isBackupServer=false}) async {
  //   //     'https://thevirustracker.com/free-api?countryTotals=ALL';
  //   await (new DatiPopolazioneMondiale()).fromJson();//deve completare il caricamento prima di usare caricare i dati dei contagi mondiali'
  //   final response = await http.get(url);//DatiConfig.URL_MONDO);

  //   if (response.statusCode == 200) {
  //     // If the server did return a 200 OK response, then parse the JSON.

  //     return DatiMondiali.fromJsonNew(
  //         json.decode(utf8.decode(response.bodyBytes)));
  //   } else {
  //     // If the server did not return a 200 OK response, then throw an exception.
  //     if(!isBackupServer){
  //       return Utility.fetchDatiMondiali(DatiConfig.URL_MONDO_BACKUP,isBackupServer:true);
  //     }else{
  //       return null;//throw Exception('Failed to load data');
  //     }
  //   }
  // }

  static DateTime ConvertToDateTime(String data) {
    try {
      return DateTime.parse(data);
    } catch (e) {
      return new DateTime(2000, 1, 1);
    }
  }
// static Future<Map<String,int>> fetchDatiPopolazioneNazioni() async {
//     // https://github.com/samayo/country-json/blob/master/src/country-by-population.json

//     final response = await http.get(DatiConfig.URL_POPOLAZIONE_MONDO);

//     if (response.statusCode == 200) {
//       // If the server did return a 200 OK response, then parse the JSON.

//       return DatiPopolazioneMondiale.fromJson(json.decode(response.body));
//     } else {
//       // If the server did not return a 200 OK response, then throw an exception.
//       throw Exception('Failed to load data');
//     }
//   }
  // INVIO RICHIESTE MULTIPLE
  // static Future<List<DatiMondiali>> fetchDatiMondialiOLD() async {
  //   HttpClient client = new HttpClient();
  //   client.findProxy = null;
  //   HttpClientRequest request;
  //   HttpClientResponse response;
  //   List<HttpClientResponse> list =
  //       await Future.wait(initialsNations.map((itemId) async {
  //     request = await client.getUrl(Uri.parse(
  //         "http://vimae.altervista.org/cov_italia/test.php?country=" + itemId));
  //     return response = await request.close();
  //   }));
  //   client.close();
  //   List<DatiMondiali> lista = [];
  //   DatiMondiali d;
  //   for (int i = 0; i < list.length; i++) {
  //     if (list[i].statusCode == 200) {
  //       list[i].transform(utf8.decoder).listen((contents) {
  //         d = DatiMondiali.fromJson(json.decode(contents));
  //         lista.add(d);
  //       });
  //     } else {
  //       throw Exception('Errore nel caricamento dei dati! Riprova!');
  //     }
  //   }
  //   return lista;
  // }

  static Future<String> fetchLikes() async {
    String url;
    url =
        'https://cors-anywhere.herokuapp.com/https://vimae.altervista.org/cov_italia/covidItalia_getLikes.php';
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to load data');
    }
  }

  static Future<String> sendLike() async {
    String url;
    url =
        'https://cors-anywhere.herokuapp.com/https://vimae.altervista.org/cov_italia/covidItalia_updateLikes.php';
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to load data');
    }
  }

  //per scaricare il file contenente la lista dei codici nazione in base al suo nome
  static Future<Map<String, dynamic>> fetchCodiciNazioni() async {
    String url = DatiConfig.URL_CODICI_NAZIONI;

    final response = await http.get(url, headers: {
      "X-Requested-With": "XMLHttpRequest",
      "Access-Control-Allow-Origin": " *"
    });

    if (response.statusCode == 200) {
      return json.decode(utf8.decode(response.bodyBytes));
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      return null;
    }
  }

  static DateTime ConvertToDate(String data) {
    try {
      return DateFormat("yyyy-MM-dd").parse(data);
    } catch (e) {
      return new DateTime(2000, 1, 1);
    }
  }
}
