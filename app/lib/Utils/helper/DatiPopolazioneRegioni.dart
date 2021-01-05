import 'dart:collection';

class DatiPopolazioneRegioni {
  static HashMap mapRegioneAbitanti;
  static int getNumeroAbitanti(int codiceRegione) {
    if (mapRegioneAbitanti == null) {
      mapRegioneAbitanti = new HashMap<int, int>();
      caricaDati();
    }
    return mapRegioneAbitanti[codiceRegione];
  }

  static caricaDati() {
    mapRegioneAbitanti[1] =
        4356406; //"01","Piemonte", "Numero_abitanti":4356406
    mapRegioneAbitanti[2] = 125666; //"2, Valle d'Aosta", 125666
    mapRegioneAbitanti[3] =
        10060574; //"03","Lombardia", "Numero_abitanti":10060574
    mapRegioneAbitanti[4] =
        531178; //"021","Bolzano",  "Numero_abitanti":531178 ********ATTENZIONE, non viene più utilizzato, dal 22 maggio
    mapRegioneAbitanti[5] = 4905854; //"05","Veneto", "Numero_abitanti":4905854
    mapRegioneAbitanti[6] =
        1215220; //"06","Friuli-Venezia Giulia", "Numero_abitanti":1215220
    mapRegioneAbitanti[7] = 1550640; //"07","Liguria", "Numero_abitanti":1550640
    mapRegioneAbitanti[8] =
        4459477; //"08","Emilia-Romagna","Numero_abitanti":4459477
    mapRegioneAbitanti[9] = 3729641; //"09","Toscana", "Numero_abitanti":3729641
    mapRegioneAbitanti[10] = 882015; //"10","Umbria","Numero_abitanti":882015
    mapRegioneAbitanti[11] = 1525271; //"11","Marche", "Numero_abitanti":1525271
    mapRegioneAbitanti[12] = 5879082; //"12","Lazio","Numero_abitanti":5879082
    mapRegioneAbitanti[13] =
        1311580; //"13","Abruzzo", "Numero_abitanti":1311580
    mapRegioneAbitanti[14] =
        305617; // "14", "Molise",  "Numero_abitanti":305617
    mapRegioneAbitanti[15] =
        5801692; //"15","Campania", "Numero_abitanti":5801692
    mapRegioneAbitanti[16] = 4029053; //"16","Puglia", "Numero_abitanti":4029053
    mapRegioneAbitanti[17] =
        562869; //"17","Basilicata",    "Numero_abitanti":562869
    mapRegioneAbitanti[18] =
        1947131; //"18","Calabria", "Numero_abitanti":1947131
    mapRegioneAbitanti[19] = 4999891; //"19","Sicilia","Numero_abitanti":4999891
    mapRegioneAbitanti[20] =
        1639591; //"20","Sardegna", "Numero_abitanti":1639591
    mapRegioneAbitanti[22] =
        541098; //"022","Trento",   "Numero_abitanti":541098
    mapRegioneAbitanti[21] =
        531178; //"021","Bolzano",  "Numero_abitanti":531178
  }
}
