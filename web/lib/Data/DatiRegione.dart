import 'package:covid_analytics_web/Utils/helper/DatiPopolazioneRegioni.dart';
import 'package:covid_analytics_web/Utils/helper/FormatoNumeri.dart';

class DatiRegione {
  final String data;
  final String stato;
  int codice_regione;
  final String denominazione_regione;
  final double lat;
  final double long;
  final int ricoverati_con_sintomi;
  final int terapia_intensiva;
  final int totale_ospedalizzati;
  final int isolamento_domiciliare;
  final int totale_positivi;
  final int variazione_totale_positivi;
  final int dimessi_guariti;
  final int deceduti;
  final int totale_casi;
  final int tamponi;
  int numero_abitanti;
  String tasso_casi; //viene messo il valore percentuale con 4 cifre decimali
  String
      tasso_deceduti; //viene messo il valore percentuale con 4 cifre decimali

//questo è un altro campo che ci dice direttamente i nuovi casi totali.
//per ora lo calcoliamo manualmente
  //final int nuovi_positivi;

  DatiRegione(
      {this.data,
      this.stato,
      this.codice_regione,
      this.denominazione_regione,
      this.lat,
      this.long,
      this.ricoverati_con_sintomi,
      this.terapia_intensiva,
      this.totale_ospedalizzati,
      this.isolamento_domiciliare,
      this.totale_positivi,
      this.variazione_totale_positivi,
      this.dimessi_guariti,
      this.deceduti,
      this.totale_casi,
      this.tamponi,
      this.numero_abitanti,
      this.tasso_casi,
      this.tasso_deceduti});

  static List<DatiRegione> fromJson(List<dynamic> array) {
    List<DatiRegione> list = [];
    for (int i = (array.length - 42); i < array.length; i++) {
      Map<String, dynamic> json = array[i];

      DatiRegione d = DatiRegione(
        data: json['data'].toString(),
        stato: json['stato'].toString(),
        codice_regione: int.tryParse(json['codice_regione'].toString()) ?? 0,
        denominazione_regione: json['denominazione_regione'].toString(),
        lat: double.tryParse(json['lat'].toString()) ?? 0,
        long: double.tryParse(json['long'].toString()) ?? 0,
        ricoverati_con_sintomi:
            int.tryParse(json['ricoverati_con_sintomi'].toString()) ?? 0,
        terapia_intensiva:
            int.tryParse(json['terapia_intensiva'].toString()) ?? 0,
        totale_ospedalizzati:
            int.tryParse(json['totale_ospedalizzati'].toString()) ?? 0,
        isolamento_domiciliare:
            int.tryParse(json['isolamento_domiciliare'].toString()) ?? 0,
        totale_positivi: int.tryParse(json['totale_positivi'].toString()) ?? 0,
        variazione_totale_positivi:
            int.tryParse(json['variazione_totale_positivi'].toString()) ?? 0,
        dimessi_guariti: int.tryParse(json['dimessi_guariti'].toString()) ?? 0,
        deceduti: int.tryParse(json['deceduti'].toString()) ?? 0,
        totale_casi: int.tryParse(json['totale_casi'].toString()) ?? 0,
        tamponi: int.tryParse(json['tamponi'].toString()) ?? 0,
      );

      if (d.denominazione_regione.compareTo("P.A. Trento") == 0) {
        d.codice_regione = 4;
      }
      d.numero_abitanti =
          DatiPopolazioneRegioni.getNumeroAbitanti(d.codice_regione);
      d.tasso_casi = FormatoNumeri.formattaNumeroPercentuale(
          d.totale_casi / d.numero_abitanti,
          maxCifreDecimali: 3);
      //(100 * d.totale_casi / d.numero_abitanti).toStringAsFixed(5);
      d.tasso_deceduti = FormatoNumeri.formattaNumeroPercentuale(
          d.deceduti / d.numero_abitanti,
          maxCifreDecimali: 3);
      //(100 * d.deceduti / d.numero_abitanti).toStringAsFixed(5);
      list.add(d);
    }
    return list;
  }
}
