class DatiProvince {
  static const NUMERO_PROVINCE = 149;

  final String data;
  final String stato;
  String codice_regione;
  final String denominazione_regione;
  final String codice_provincia;
  String denominazione_provincia;
  final String sigla_provincia;
  final double lat;
  final double long;
  int totale_casi;

  DatiProvince(
      {this.data,
      this.stato,
      this.codice_regione,
      this.denominazione_regione,
      this.codice_provincia,
      this.denominazione_provincia,
      this.sigla_provincia = " ",
      this.lat,
      this.long,
      this.totale_casi});

  static List<DatiProvince> fromJson(List<dynamic> array) {
    List<DatiProvince> list = [];

    int k = 0;
    //sono NUMERO_PROVINCE province, circa
    for (int i = array.length - (NUMERO_PROVINCE * 2); i < array.length; i++) {
      Map<String, dynamic> json = array[i];

      //print(json['denominazione_provincia'] + "---" + i.toString());
      //calcolo del numero di province
      // if (json["denominazione_provincia"].toString().compareTo("Chieti") == 0 &&
      //     i == 0) {
      //   k = 1;
      // } else if (json["denominazione_provincia"]
      //         .toString()
      //         .compareTo("Chieti") !=
      //     0) {
      //   k++;
      // } else if (json["denominazione_provincia"]
      //             .toString()
      //             .compareTo("Chieti") ==
      //         0 &&
      //     i > 0) {
      //   print("************** " + k.toString());
      //   break;
      // }
      String new_denom_provincia;
      if (json['denominazione_provincia']
              .toString()
              .compareTo("In fase di definizione/aggiornamento") ==
          0) {
        new_denom_provincia = "Da associare territorialmente";
      } else
        new_denom_provincia = json['denominazione_provincia'];

      DatiProvince d = DatiProvince(
          data: json['data'].toString(),
          stato: json['stato'].toString(),
          codice_regione: json['codice_regione'].toString(),
          denominazione_regione: json['denominazione_regione'].toString(),
          codice_provincia: json['codice_provincia'].toString(),
          denominazione_provincia: new_denom_provincia,
          sigla_provincia: json['sigla_provincia'].toString(),
          lat: double.tryParse(json['lat'].toString()) ?? 0,
          long: double.tryParse(json['long'].toString()) ?? 0,
          totale_casi: int.parse(json['totale_casi'].toString()) ?? 0);

      if (d.denominazione_regione.compareTo("P.A. Trento") == 0) {
        d.codice_regione = "4";
      }
      list.add(d);
    }
    return list;
  }
}
