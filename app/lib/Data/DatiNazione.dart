import 'package:covid/Utils/Utility.dart';

class DatiNazione {
  static DateTime lastUpdate;
  final String data;
  final String stato;
  final int ricoverati_con_sintomi;
  final int terapia_intensiva;
  final int totale_ospedalizzati;
  final int isolamento_domiciliare;
  final int
      totale_positivi; // (ricoverati_con_sintomi + terapia_intensiva + isolamento domiciliare)
  final int
      variazione_totale_positivi; //(totale positivi giorno corrente - totale positivi giorno precedente)
  final int dimessi_guariti;
  final int deceduti;
  final int totale_casi;
  final int tamponi;

//questo è un altro campo che ci dice direttamente i nuovi casi totali.
//per ora lo calcoliamo manualmente
  //final int nuovi_positivi;

  DatiNazione(
      {this.data,
      this.stato,
      this.ricoverati_con_sintomi,
      this.terapia_intensiva,
      this.totale_ospedalizzati,
      this.isolamento_domiciliare,
      this.totale_positivi,
      this.variazione_totale_positivi,
      this.dimessi_guariti,
      this.deceduti,
      this.totale_casi,
      this.tamponi});

  static List<DatiNazione> fromJson(List<dynamic> array) {
    List<DatiNazione> list = [];
    DatiNazione.lastUpdate = Utility.ConvertToDate(array[array.length - 1]
            ['data']
        .toString()); //TODO: verificare se corretto
    for (int i = 0; i < array.length; i++) {
      Map<String, dynamic> json = array[i];

      DatiNazione d = DatiNazione(
        data: json['data'],
        stato: json['stato'],
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
      list.add(d);
    }
    return list;
  }
}
