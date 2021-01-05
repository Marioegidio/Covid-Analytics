import 'package:covid_analytics_web/Components/Dati_nazione_component.dart';
import 'package:covid_analytics_web/Data/DatiNazione.dart';
import 'package:covid_analytics_web/Utils/Utility.dart';
import 'package:covid_analytics_web/Utils/helper/FormatoNumeri.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../main.dart';

class WdgDatiItalia extends StatelessWidget {
  static const double distanzaCard = 5;
  static String fonte_interpretazione_dati =
      "\n(fonte: www.corriere.it/salute)";
  static TextStyle stileDescrizioneAlert =
      TextStyle(color: Colors.black, fontSize: 12.5);

  @override
  Widget build(BuildContext context) {
    Utility.updateDeviceDimension(context);
    return FutureBuilder<List<DatiNazione>>(
      future: MainScreenAppState.futureDatiNazione,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          DatiNazione lastUpdate = snapshot.data[snapshot.data.length - 1];
          DatiNazione secondLastUpdate =
              snapshot.data[snapshot.data.length - 2];

          double percCasiTotTamponi =
              (lastUpdate.totale_casi - secondLastUpdate.totale_casi) /
                  (lastUpdate.tamponi - secondLastUpdate.tamponi);

          // double percCasiTotali = num.parse(
          //     (((lastUpdate.totale_casi - secondLastUpdate.totale_casi) /
          //             secondLastUpdate.totale_casi))
          //         .toStringAsFixed(2));
          // double percPositivi = num.parse((((lastUpdate.totale_positivi -
          //             secondLastUpdate.totale_positivi) /
          //         secondLastUpdate.totale_positivi))
          //     .toStringAsFixed(2));
          // double percGuariti = num.parse((((lastUpdate.dimessi_guariti -
          //             secondLastUpdate.dimessi_guariti) /
          //         secondLastUpdate.dimessi_guariti))
          //     .toStringAsFixed(2));
          // double percDecessi = num.parse(
          //     (((lastUpdate.deceduti - secondLastUpdate.deceduti) /
          //             secondLastUpdate.deceduti))
          //         .toStringAsFixed(2));
          // double percOspedalizzati = num.parse(
          //     (((lastUpdate.totale_ospedalizzati -
          //                 secondLastUpdate.totale_ospedalizzati) /
          //             secondLastUpdate.totale_ospedalizzati))
          //         .toStringAsFixed(2));
          // double percTerapia = num.parse((((lastUpdate.terapia_intensiva -
          //             secondLastUpdate.terapia_intensiva) /
          //         secondLastUpdate.terapia_intensiva))
          //     .toStringAsFixed(2));
          // double percRicoverati = num.parse(
          //     (((lastUpdate.ricoverati_con_sintomi -
          //                 secondLastUpdate.ricoverati_con_sintomi) /
          //             secondLastUpdate.ricoverati_con_sintomi))
          //         .toStringAsFixed(2));
          // double percTamponi = num.parse(
          //     (((lastUpdate.tamponi - secondLastUpdate.tamponi) /
          //             secondLastUpdate.tamponi))
          //         .toStringAsFixed(2));
          // double percIsolamento = num.parse(
          //     (((lastUpdate.isolamento_domiciliare -
          //                 secondLastUpdate.isolamento_domiciliare) /
          //             secondLastUpdate.isolamento_domiciliare))
          //         .toStringAsFixed(2));

          return Container(
            margin: EdgeInsets.zero,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  SizedBox(width: distanzaCard * 3 - 10),
                  // PRIMA CARD *******************************
                  DatiNazioneComponent(
                    icona: Icons.assignment_turned_in,
                    colore: Colors.white,
                    titolo: "Casi totali",
                    descrizioni: [
                      'Casi totali registrati in Italia\n(Positivi + Guariti + Decessi).' +
                          "\nTamponi positivi: " +
                          FormatoNumeri.formattaNumeroPercentuale(
                              percCasiTotTamponi,
                              conSegno: false),
                      "\n"
                    ],
                    datiGrassetto: [
                      FormatoNumeri.formattaNumeroCompatto(
                          lastUpdate.totale_casi),
                      //int.parse(lastUpdate.totale_casi.toString()).toString(),
                      lastUpdate.data.toString(),
                      FormatoNumeri.formattaNumeroCompatto(
                          lastUpdate.totale_casi - secondLastUpdate.totale_casi,
                          conSegno: true),
                      // (lastUpdate.totale_casi -secondLastUpdate.totale_casi).toString()
                      FormatoNumeri.formattaNumeroPercentuale(
                          (((lastUpdate.totale_casi -
                                  secondLastUpdate.totale_casi) /
                              secondLastUpdate.totale_casi)))
                    ],
                    usaAlert: true,
                    iconaAlert: Icon(
                      Icons.assignment_turned_in,
                      color: Colors.white,
                      size: 60.0,
                    ),
                    titoloAlert: Text(
                      "Casi totali",
                      style: stileDescrizioneAlert,
                      textAlign: TextAlign.center,
                    ),
                    descrizioneAlert: Container(
                      height: MediaQuery.of(context).size.height * 0.33,
                      width: MediaQuery.of(context).orientation ==
                              Orientation.landscape
                          ? MediaQuery.of(context).size.width * 0.47
                          : MediaQuery.of(context).orientation ==
                                  Orientation.landscape
                              ? MediaQuery.of(context).size.width * 0.47
                              : MediaQuery.of(context).size.width * 0.75,
                      child: SingleChildScrollView(
                        child: Center(
                          child: Text(
                              "Indica quante persone hanno di sicuro contratto il virus dall'inizio dell'epidemia. Tali persone possono trovarsi in una delle seguenti situazioni: 'Positive', 'Guarite o dimesse', 'Decedute'. Per questo motivo il numero dei 'Casi totali' viene suddiviso nelle suddette 3 categorie e si avrà sempre che: CasiTotali = Positivi + Guariti/dimessi + Decessi. L’esito dei tamponi risultati positivi finisce in questa voce. \n$fonte_interpretazione_dati",
                              style: TextStyle(
                                fontSize: 13.5,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                              textAlign: TextAlign.justify),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: distanzaCard),
                  //SECONDA CARD ************************************
                  DatiNazioneComponent(
                      icona: Icons.playlist_add_check,
                      colore: Colors.white,
                      titolo: "Positivi",
                      descrizioni: [
                        'Casi accertati di persone che risultano attualmente positive.\n(Ospedalizzati + In Isolamento).', // \n\n $DESCRIZIONE_VARIAZ_PERC $perc_positivi%',
                        "\n"
                      ],
                      datiGrassetto: [
                        FormatoNumeri.formattaNumeroCompatto(
                            lastUpdate.totale_positivi),
                        //lastUpdate.totale_attualmente_positivi.toString(),
                        lastUpdate.data.toString(),
                        FormatoNumeri.formattaNumeroCompatto(
                            lastUpdate.totale_positivi -
                                secondLastUpdate.totale_positivi,
                            conSegno: true),
                        FormatoNumeri.formattaNumeroPercentuale(
                            (((lastUpdate.totale_positivi -
                                    secondLastUpdate.totale_positivi) /
                                secondLastUpdate.totale_positivi)))
                        // (lastUpdate.totale_attualmente_positivi -
                        //         secondLastUpdate
                        //             .totale_attualmente_positivi)
                        //     .toString()
                      ],
                      usaAlert: true,
                      iconaAlert: Icon(
                        Icons.healing,
                        color: Colors.white,
                        size: 60.0,
                      ),
                      titoloAlert: Text(
                        "Positivi",
                        style: stileDescrizioneAlert,
                        textAlign: TextAlign.center,
                      ),
                      descrizioneAlert: Container(
                        width: MediaQuery.of(context).orientation ==
                                Orientation.landscape
                            ? MediaQuery.of(context).size.width * 0.47
                            : MediaQuery.of(context).size.width * 0.75,
                        height: MediaQuery.of(context).size.height * 0.33,
                        child: SingleChildScrollView(
                          child: Center(
                            child: Text(
                                "È il numero delle persone che oggi, in Italia, sono positive al Coronavirus e non sono ancora guarite. Viene ottenuto sommando Ospedalizzati + In isolamento." +
                                    //"Il dato viene poi «spacchettato» in tre parti: quanti di quei contagiati si trovano a casa, in isolamento domiciliare; quanti sono in ospedale in terapia intensiva; quanti sono in ospedale, con sintomi ma non in terapia intensiva." +
                                    " La Protezione civile fornisce la differenza tra i «totale attualmente positivi». E' un dato importante ma non risponde alla domanda «Quante persone si sono ammalate ieri?» ma alla domanda: il numero di persone positive, in Italia, è aumentato o no? Questo dato dà dunque una indicazione importante sullo stato di salute del nostro sistema sanitario. \n$fonte_interpretazione_dati",
                                style: TextStyle(
                                  fontSize: 13.5,
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                ),
                                textAlign: TextAlign.justify),
                          ),
                        ),
                      )),
                  SizedBox(width: distanzaCard),
                  //TERZA CARD *********************************
                  DatiNazioneComponent(
                      icona: Icons.healing,
                      colore: Colors.white,
                      titolo: "Guariti",
                      descrizioni: [
                        'Persone risultate positive e poi guarite o dimesse.', //\n\n $DESCRIZIONE_VARIAZ_PERC $perc_guariti%',
                        "\n"
                      ],
                      datiGrassetto: [
                        FormatoNumeri.formattaNumeroCompatto(
                            lastUpdate.dimessi_guariti),
                        // lastUpdate.dimessi_guariti.toString(),
                        lastUpdate.data.toString(),
                        FormatoNumeri.formattaNumeroCompatto(
                            lastUpdate.dimessi_guariti -
                                secondLastUpdate.dimessi_guariti,
                            conSegno: true),
                        FormatoNumeri.formattaNumeroPercentuale(
                            (((lastUpdate.dimessi_guariti -
                                    secondLastUpdate.dimessi_guariti) /
                                secondLastUpdate.dimessi_guariti)))
                        // (lastUpdate.dimessi_guariti -
                        //         secondLastUpdate.dimessi_guariti)
                        //     .toString()
                      ],
                      usaAlert: true,
                      iconaAlert: Icon(
                        Icons.import_export,
                        color: Colors.white,
                        size: 60.0,
                      ),
                      titoloAlert: Text(
                        "Guariti/dimessi",
                        style: stileDescrizioneAlert,
                        textAlign: TextAlign.center,
                      ),
                      descrizioneAlert: Container(
                          height: MediaQuery.of(context).size.height * 0.33,
                          width: MediaQuery.of(context).orientation ==
                                  Orientation.landscape
                              ? MediaQuery.of(context).size.width * 0.47
                              : MediaQuery.of(context).size.width * 0.75,
                          child: SingleChildScrollView(
                            child: Center(
                              child: Text(
                                  "Nel bollettino, i dati sotto la voce 'Guariti/Dimessi' riguardano due categorie ben diverse: i 'guariti' (tampone negativo dopo essere state trovate positive) e i 'dimessi' (possono essere state dimesse pur avendo ancora sintomi e inviate in isolamento domiciliare)." +
                                      // " Come indicato da un’analisi della Fondazione GIMBE (organizzazione indipendente senza scopo di lucro che si occupa di sanità pubblica) e da YouTrend, la Lombardia, ad esempio, «non menziona affatto il numero delle guarigioni, ma riporta solo il numero di pazienti dimessi dall’ospedale (o dal pronto soccorso) e inviati in isolamento domiciliare."+
                                      // " Tutti questi casi confluiscono nei 'Guariti/Dimessi' del bollettino nazionale sovrastimando il tasso di guarigione». "+
                                      " Pertanto dal bollettino non è possibile risalire al numero di coloro che sono guariti ma soltanto a quello di chi è stato dimesso o è effettivamente guarito. " +
                                      "\n$fonte_interpretazione_dati",
                                  style: TextStyle(
                                    fontSize: 13.5,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                  ),
                                  textAlign: TextAlign.justify),
                            ),
                          ))),
                  SizedBox(width: distanzaCard),
                  //QUARTA CARD **********************************
                  DatiNazioneComponent(
                      icona: Icons.cancel,
                      colore: Colors.white,
                      titolo: "Decessi",
                      descrizioni: [
                        'Persone decedute.', // \n\n $DESCRIZIONE_VARIAZ_PERC $perc_decessi%',
                        "\n"
                      ],
                      datiGrassetto: [
                        FormatoNumeri.formattaNumeroCompatto(
                            lastUpdate.deceduti),
                        // lastUpdate.deceduti.toString(),
                        lastUpdate.data.toString(),
                        FormatoNumeri.formattaNumeroCompatto(
                            lastUpdate.deceduti - secondLastUpdate.deceduti,
                            conSegno: true),
                        FormatoNumeri.formattaNumeroPercentuale(
                            (((lastUpdate.deceduti -
                                    secondLastUpdate.deceduti) /
                                secondLastUpdate.deceduti)))
                        // (lastUpdate.deceduti - secondLastUpdate.deceduti)
                        //     .toString()
                      ],
                      usaAlert: true,
                      titoloAlert: Text(
                        "Decessi",
                        style: stileDescrizioneAlert,
                        textAlign: TextAlign.center,
                      ),
                      descrizioneAlert: Container(
                          height: MediaQuery.of(context).size.height * 0.33,
                          width: MediaQuery.of(context).orientation ==
                                  Orientation.landscape
                              ? MediaQuery.of(context).size.width * 0.47
                              : MediaQuery.of(context).size.width * 0.75,
                          child: SingleChildScrollView(
                            child: Center(
                              child: Text(
                                  "Numero di persone decedute dall'inizio dell'epidemia. \nCasi totali = Positivi + Guariti/dimessi + Deceduti\n" +
                                      fonte_interpretazione_dati,
                                  style: TextStyle(
                                    fontSize: 13.5,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                  ),
                                  textAlign: TextAlign.justify),
                            ),
                          ))),
                  SizedBox(width: distanzaCard),
                  //QUINTA CARD ************************************
                  DatiNazioneComponent(
                      icona: Icons.local_hospital,
                      colore: Colors.white,
                      titolo: "Ospedalizzati",
                      descrizioni: [
                        'Persone ricoverate in ospedale (In terapia intensiva + Ricoverati).', //\n\n $DESCRIZIONE_VARIAZ_PERC $perc_ospedalizzati%',
                        "\n "
                      ],
                      datiGrassetto: [
                        FormatoNumeri.formattaNumeroCompatto(
                            lastUpdate.totale_ospedalizzati),
                        // lastUpdate.totale_ospedalizzati.toString(),
                        lastUpdate.data.toString(),
                        FormatoNumeri.formattaNumeroCompatto(
                            lastUpdate.totale_ospedalizzati -
                                secondLastUpdate.totale_ospedalizzati,
                            conSegno: true),
                        FormatoNumeri.formattaNumeroPercentuale(
                            (lastUpdate.totale_ospedalizzati -
                                    secondLastUpdate.totale_ospedalizzati) /
                                secondLastUpdate.totale_ospedalizzati)
                        // (lastUpdate.totale_ospedalizzati -
                        //         secondLastUpdate.totale_ospedalizzati)
                        //     .toString()
                      ],
                      usaAlert: true,
                      iconaAlert: Icon(
                        Icons.import_export,
                        color: Colors.white,
                        size: 60.0,
                      ),
                      titoloAlert: Text(
                        "Ospedalizzati",
                        style: stileDescrizioneAlert,
                        textAlign: TextAlign.center,
                      ),
                      descrizioneAlert: Container(
                          height: MediaQuery.of(context).size.height * 0.33,
                          width: MediaQuery.of(context).orientation ==
                                  Orientation.landscape
                              ? MediaQuery.of(context).size.width * 0.47
                              : MediaQuery.of(context).size.width * 0.75,
                          child: SingleChildScrollView(
                            child: Center(
                              child: Text(
                                  "Indica quante persone tra i 'Positivi' (il numero degli attualmente contagiati) si trovano in ospedale in terapia intensiva o ricoverati in posti normali." +
                                      "Positivi = Ospedalizzati + InIsolamento"
                                          "\n$fonte_interpretazione_dati",
                                  style: TextStyle(
                                    fontSize: 13.5,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                  ),
                                  textAlign: TextAlign.justify),
                            ),
                          ))),
                  SizedBox(width: distanzaCard),
                  //SESTA CARD ************************************
                  DatiNazioneComponent(
                      icona: Icons.import_export,
                      colore: Colors.white,
                      titolo: "Terapia intensiva",
                      descrizioni: [
                        'Persone in terapia intensiva.', // \n\n $DESCRIZIONE_VARIAZ_PERC $perc_terapia%',
                        "\n"
                      ],
                      datiGrassetto: [
                        FormatoNumeri.formattaNumeroCompatto(
                            lastUpdate.terapia_intensiva),
                        // lastUpdate.terapia_intensiva.toString(),
                        lastUpdate.data.toString(),
                        FormatoNumeri.formattaNumeroCompatto(
                            lastUpdate.terapia_intensiva -
                                secondLastUpdate.terapia_intensiva,
                            conSegno: true),
                        FormatoNumeri.formattaNumeroPercentuale(
                            (((lastUpdate.terapia_intensiva -
                                    secondLastUpdate.terapia_intensiva) /
                                secondLastUpdate.terapia_intensiva)))
                        // (lastUpdate.terapia_intensiva -
                        //         secondLastUpdate.terapia_intensiva)
                        //     .toString()
                      ],
                      usaAlert: true,
                      iconaAlert: Icon(
                        Icons.import_export,
                        color: Colors.white,
                        size: 60.0,
                      ),
                      titoloAlert: Text(
                        "Terapia intensiva",
                        style: stileDescrizioneAlert,
                        textAlign: TextAlign.center,
                      ),
                      descrizioneAlert: Container(
                          height: MediaQuery.of(context).size.height * 0.33,
                          width: MediaQuery.of(context).orientation ==
                                  Orientation.landscape
                              ? MediaQuery.of(context).size.width * 0.47
                              : MediaQuery.of(context).size.width * 0.75,
                          child: SingleChildScrollView(
                            child: Center(
                              child: Text(
                                  "Rappresenta il numero di persone attualmente in terapia intensiva. È un dato molto importante ed è uno dei pochi dati certi. Ma va fatta attenzione." +
                                      " Prendiamo, per esempio, i dati del 2 aprile scorso: i posti occupati in terapia intensiva erano 4053. Il giorno prima erano 4035." +
                                      " Questo non significa, però, che tra l’1 e il 2 aprile siano state ricoverate in terapia intensiva 18 persone." +
                                      " Perché non sappiamo quante persone, in quelle 24 ore, siano uscite dalla terapia intensiva, né in quali condizioni (potrebbero essere decedute, o portate in un reparto non di terapia intensiva)." +
                                      " In teoria, tutte quelle 4035 persone potrebbero essere state ricoverate in reparti normali: e se questo fosse successo, in quelle 24 ore, in Italia, sarebbero state ricoverate in terapia intensiva 4053 persone.\n" +
                                      fonte_interpretazione_dati,
                                  style: TextStyle(
                                    fontSize: 13.5,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                  ),
                                  textAlign: TextAlign.justify),
                            ),
                          ))),
                  SizedBox(width: distanzaCard),

                  //SETTIMA CARD ************************************
                  DatiNazioneComponent(
                      icona: Icons.local_hospital,
                      colore: Colors.white,
                      titolo: "Ricoverati",
                      descrizioni: [
                        'Ospedalizzati ma non in terapia intensiva.', // \n\n $DESCRIZIONE_VARIAZ_PERC $perc_ricoverati%',
                        "\n"
                      ],
                      datiGrassetto: [
                        FormatoNumeri.formattaNumeroCompatto(
                            lastUpdate.ricoverati_con_sintomi),
                        // lastUpdate.ricoverati_con_sintomi.toString(),
                        lastUpdate.data.toString(),
                        FormatoNumeri.formattaNumeroCompatto(
                            lastUpdate.ricoverati_con_sintomi -
                                secondLastUpdate.ricoverati_con_sintomi,
                            conSegno: true),
                        FormatoNumeri.formattaNumeroPercentuale(
                            (((lastUpdate.ricoverati_con_sintomi -
                                    secondLastUpdate.ricoverati_con_sintomi) /
                                secondLastUpdate.ricoverati_con_sintomi)))
                        // (lastUpdate.ricoverati_con_sintomi -
                        //         secondLastUpdate.ricoverati_con_sintomi)
                        //     .toString()
                      ],
                      usaAlert: true,
                      iconaAlert: Icon(
                        Icons.import_export,
                        color: Colors.white,
                        size: 60.0,
                      ),
                      titoloAlert: Text(
                        "Ricoverati",
                        style: stileDescrizioneAlert,
                        textAlign: TextAlign.center,
                      ),
                      descrizioneAlert: Container(
                          height: MediaQuery.of(context).size.height * 0.33,
                          width: MediaQuery.of(context).orientation ==
                                  Orientation.landscape
                              ? MediaQuery.of(context).size.width * 0.47
                              : MediaQuery.of(context).size.width * 0.75,
                          child: SingleChildScrollView(
                            child: Center(
                              child: Text(
                                  "Indica quante persone gli 'Ospedalizzati' si trovano in ospedale in un reparto normale quindi non in terapia intensiva." +
                                      "\n Ospedalizzati = Ricoverati + In terapia intensiva\n" +
                                      fonte_interpretazione_dati,
                                  style: TextStyle(
                                    fontSize: 13.5,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                  )),
                            ),
                          ))),
                  SizedBox(width: distanzaCard),
                  //OTTAVA CARD ************************************
                  DatiNazioneComponent(
                      icona: Icons.colorize,
                      colore: Colors.white,
                      titolo: "Tamponi",
                      descrizioni: [
                        'Numero di tamponi effettuati.' +
                            "\nTamponi positivi: " +
                            FormatoNumeri.formattaNumeroPercentuale(
                                percCasiTotTamponi,
                                conSegno:
                                    false), // \n\nLa Percentuale di positivi sui tamponi effettuati è pari a ' +
                        // perc_pos_tamponi.toString() +
                        // '% \n $DESCRIZIONE_VARIAZ_PERC $perc_tamponi%',
                        "\n"
                      ],
                      datiGrassetto: [
                        FormatoNumeri.formattaNumeroCompatto(
                            lastUpdate.tamponi),
                        // lastUpdate.tamponi.toString(),
                        lastUpdate.data.toString(),
                        FormatoNumeri.formattaNumeroCompatto(
                            lastUpdate.tamponi - secondLastUpdate.tamponi,
                            conSegno: true),
                        FormatoNumeri.formattaNumeroPercentuale(
                            (((lastUpdate.tamponi - secondLastUpdate.tamponi) /
                                secondLastUpdate.tamponi)))
                        // (lastUpdate.tamponi - secondLastUpdate.tamponi)
                        //     .toString()
                      ],
                      usaAlert: true,
                      iconaAlert: Icon(
                        Icons.import_export,
                        color: Colors.white,
                        size: 60.0,
                      ),
                      titoloAlert: Text(
                        "Tamponi",
                        style: stileDescrizioneAlert,
                        textAlign: TextAlign.center,
                      ),
                      descrizioneAlert: Container(
                          height: MediaQuery.of(context).size.height * 0.33,
                          width: MediaQuery.of(context).orientation ==
                                  Orientation.landscape
                              ? MediaQuery.of(context).size.width * 0.47
                              : MediaQuery.of(context).size.width * 0.75,
                          child: SingleChildScrollView(
                            child: Center(
                              child: Text(
                                  "Indica il numero di tamponi effettuati dall'inizio dell'epidemia. Non indica il numero di persone distinte che sono state sottoposte a tampone perché alcune persone vengono sottoposte a più tamponi." +
                                      " Il numero di persone che giornalmente risultano positive al tampone confluisce nei 'Casi totali'.\n" +
                                      fonte_interpretazione_dati,
                                  style: TextStyle(
                                    fontSize: 13.5,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                  ),
                                  textAlign: TextAlign.justify),
                            ),
                          ))),
                  SizedBox(width: distanzaCard),
                  //NONA CARD ************************************
                  DatiNazioneComponent(
                      icona: Icons.home,
                      colore: Colors.white,
                      titolo: "In isolamento",
                      descrizioni: [
                        'Persone in isolamento presso il proprio domicilio.', //\n\n $DESCRIZIONE_VARIAZ_PERC $perc_isolamento%',
                        "\n"
                      ],
                      datiGrassetto: [
                        FormatoNumeri.formattaNumeroCompatto(
                            lastUpdate.isolamento_domiciliare),
                        // lastUpdate.isolamento_domiciliare.toString(),
                        lastUpdate.data.toString(),
                        FormatoNumeri.formattaNumeroCompatto(
                            lastUpdate.isolamento_domiciliare -
                                secondLastUpdate.isolamento_domiciliare,
                            conSegno: true),
                        FormatoNumeri.formattaNumeroPercentuale(
                            (((lastUpdate.isolamento_domiciliare -
                                    secondLastUpdate.isolamento_domiciliare) /
                                secondLastUpdate.isolamento_domiciliare)))
                        //     (lastUpdate.isolamento_domiciliare -
                        //     secondLastUpdate.isolamento_domiciliare)
                        // .toString()
                      ],
                      usaAlert: true,
                      iconaAlert: Icon(
                        Icons.import_export,
                        color: Colors.white,
                        size: 60.0,
                      ),
                      titoloAlert: Text(
                        "In isolamento domiciliare",
                        style: stileDescrizioneAlert,
                        textAlign: TextAlign.center,
                      ),
                      descrizioneAlert: Container(
                          height: MediaQuery.of(context).size.height * 0.33,
                          width: MediaQuery.of(context).orientation ==
                                  Orientation.landscape
                              ? MediaQuery.of(context).size.width * 0.47
                              : MediaQuery.of(context).size.width * 0.75,
                          child: SingleChildScrollView(
                            child: Center(
                              child: Text(
                                  "Indica quante persone tra i 'Positivi' (il numero degli attualmente contagiati) si trovano a casa in isolamento domiciliare." +
                                      "\nPositivi = Ospedalizzati + InIsolamento\n" +
                                      fonte_interpretazione_dati,
                                  style: TextStyle(
                                    fontSize: 13.5,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                  )),
                            ),
                          ))),
                  SizedBox(width: distanzaCard * 3)
                ],
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: <Widget>[
                  Text(
                      "Le informazioni non sono al momento disponibili perchè il server che fornisce i dati non è al momento raggiungibile.",
                      style: GoogleFonts.lato(
                          fontSize: 18, fontWeight: FontWeight.w600)),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text("Ci scusiamo per il disagio!",
                        style: GoogleFonts.lato(
                            fontSize: 17, fontWeight: FontWeight.w600)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text("Si prega di riprovare più tardi.",
                        style: GoogleFonts.lato(
                            fontSize: 17, fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            ),
          );
        }

        // By default, show a loading spinner.
        return Container(
            height: Utility.height.toDouble(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(child: RefreshProgressIndicator()
                    // child: Image.asset("assets/images/prova.gif")
                    )
              ],
            ));
      },
    );
  }
}
