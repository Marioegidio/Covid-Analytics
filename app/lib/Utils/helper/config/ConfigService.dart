import 'package:http/http.dart' as http;
import 'package:covid/Data/DatiNazione.dart';
import 'dart:convert';

import 'DatiConfig.dart';

class ConfigService {
  static String URL_FILE_CONFIG =
      "http://vimae.altervista.org/cov_italia/conf_monitorIT/file_config_v2.json";

  static invocaCopiaDatiSulServer() {
    //verifica se è necessario copiare i dati sul server e, nel caso, invoca il relativo servizio
    try {
      //print("non sto inviando i dati sul server!!"+DatiNazione.lastUpdate.toString()            +"  "+DatiConfig.DATA_ULTIMO_AGG.toString());
      if (DatiNazione.lastUpdate.isAfter(DatiConfig.DATA_ULTIMO_AGG)) {
        // print("e invece si");
        //invocare pagina php per copia. N.B. la pagina php deve anche cambiare la data nel  file_config_v2.json
        // copiaDatiSulServer();
      }
    } catch (e) {
      //si presuppone che se le date di aggiornamento delle fonti siano nulle allora il server non sia raggiungibile
    }
  }

  // static Future<bool> copiaDatiSulServer() async {
  //   http.get(DatiConfig.URL_WS_COPIA_DATI);
  // }

  static Future<List<DatiConfig>> fetchFileConfig() async {
    final response = await http.get(URL_FILE_CONFIG);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then parse the JSON.
      Map<String, dynamic> array = json.decode(response.body);
      DatiConfig.fromJson(array);
    } else {
      //return Future.value(false);
    }
  }
}
