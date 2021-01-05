import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Utility.dart';

class DatiConfig {
  static String URL_FILE_CONFIG =
      "http://vimae.altervista.org/cov_italia/conf_monitorIT/file_config_v2.json";
  static String URL_REGIONI = "";
  static String URL_PROVINCE = "";
  static String URL_NAZIONE = "";
  static String URL_CODICI_NAZIONI =
      ""; //link che porta al json contenente i codici di ogni nazione
  static String VERSION_CODE = "";
  static List<Widget> RELEASE_NOTE_WIDGETS = [];
  static bool NEW_VERSION = false;
  static DateTime DATA_ULTIMO_AGG;
  static DateTime DATA_ULTIMO_JSON_NAZIONE;
  static DateTime DATA_ULTIMO_JSON_REGIONI;
  static DateTime DATA_ULTIMO_JSON_PROVINCE;

  DatiConfig(
      // {
      // this.URL_FILE_CONFIG,
      // this.URL_REGIONI,
      // this.URL_PROVINCE,
      // this.URL_MONDO,
      // this.URL_POPOLAZIONE_MONDO,
      // this.String URL_PLAYSTORE,
      // this.URL_APPSTORE,
      // this.URL_NAZIONE,
      // this.VERSION_CODE,
      // this.NEW_VERSION
      // }
      );

  static void fromJson(Map<String, dynamic> array) {
    //Map<String, dynamic> jsonArray = array[0];

    try {
      DatiConfig.URL_PROVINCE = array["url_dati_province"].toString();
    } catch (e) {
      print("Errore url_dati_province");
    }

    try {
      DatiConfig.URL_REGIONI = array["url_dati_regioni"].toString();
    } catch (e) {
      print("Errore url_dati_regioni");
    }

    try {
      DatiConfig.URL_NAZIONE = array["url_dati_nazione"].toString();
    } catch (e) {
      print("Errore url_dati_nazione");
    }

    try {
      DatiConfig.VERSION_CODE = array["app_version_code"].toString();
    } catch (e) {
      print("Errore app_version_code");
    }
    try {
      // DatiConfig.RELEASE_NOTE = "";
      List<dynamic> notes = array["last_release_note"];
      DatiConfig.RELEASE_NOTE_WIDGETS.add(
        Padding(
          padding: const EdgeInsets.only(left: 4, right: 4, bottom: 10),
          child: Divider(
            color: Colors.green,
            height: 5,
            thickness: 0.85,
          ),
        ),
      );
      for (String s in notes) {
        DatiConfig.RELEASE_NOTE_WIDGETS.add(ConstrainedBox(
            constraints: const BoxConstraints(minWidth: double.infinity),
            child: Card(
              margin: EdgeInsets.only(bottom: 6.5, left: 1, right: 1),
              elevation: 2,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Text(s,
                        style: GoogleFonts.lato(
                            fontSize: 13.5, fontWeight: FontWeight.w600)),
                  ),
                ),
              ),
            )));
      }
    } catch (e) {
      print("Errore last_release_note");
    }
    try {
      DatiConfig.DATA_ULTIMO_AGG = Utility.ConvertToDateTime(
          array["data_ultimo_aggiornamento"].toString());
      /*.add(Duration(
        hours: 23,
        minutes: 59,
        seconds: 59,
        milliseconds: 999
      )*/
      print(DatiConfig.DATA_ULTIMO_AGG);
    } catch (e) {
      print("Errore data_ultimo_aggiornamento");
    }

    try {
      DatiConfig.URL_CODICI_NAZIONI = array["url_codici_nazioni"].toString();
    } catch (e) {
      print("Errore msg_condivisione_app");
    }

    // return true;//restituisce sempre true
  }
}
