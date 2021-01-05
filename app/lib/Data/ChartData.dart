import 'package:charts_flutter/flutter.dart' as charts;
import 'package:covid/Data/DatiRegione.dart';
import 'package:covid/Utils/helper/FormatoNumeri.dart';
import 'package:flutter/material.dart';
import 'DatiNazione.dart';

class ChartData {
  DateTime date;
  int day;
  int people;
  double percentage;

  ChartData(this.date, this.people);
  ChartData.forAreaChart(this.day, this.people);
  ChartData.forPercentagesChart(this.date, this.percentage);
  //print("TIMESTAMP-->"+timestamp.toString()+"-----"+new DateTime.fromMillisecondsSinceEpoch(timestamp*1000).toString()+"\n");
  //timestamp è in secondi mentre la funzione lo vuole in millisecondi.

//genero i dati del grafico che mostra tutti i grafici dei totali
  static List<charts.Series<ChartData, int>> createConfirmedData(
      List<DatiNazione> dnList) {
    List<ChartData> data = [];
    List<ChartData> dataDeaths = [];
    List<ChartData> dataPositive = [];
    List<ChartData> dataRecovered = [];
    int i = 0;
    //creo la lista di tutti i dati che andranno nel grafico
    for (DatiNazione ts in dnList) {
      data.add(new ChartData.forAreaChart(i, ts.totale_casi));
      dataDeaths.add(new ChartData.forAreaChart(i, ts.deceduti));
      dataPositive.add(new ChartData.forAreaChart(i, ts.totale_positivi));
      dataRecovered.add(new ChartData.forAreaChart(i++, ts.dimessi_guariti));
    }

    return [
      new charts.Series<ChartData, int>(
        id: 'Casi Totali',
        seriesColor: charts.Color.fromHex(code: "#0a78dc"),
        strokeWidthPxFn: (ChartData sales, _) => 4.2,
        domainFn: (ChartData sales, _) => sales.day,
        measureFn: (ChartData sales, _) => sales.people,
        data: data,
      ),
      new charts.Series<ChartData, int>(
        id: 'Positivi',
        colorFn: (_, __) => charts.MaterialPalette.gray.shade700,
        strokeWidthPxFn: (ChartData sales, _) => 4,
        domainFn: (ChartData sales, _) => sales.day,
        measureFn: (ChartData sales, _) => sales.people,
        data: dataPositive,
      ),
      new charts.Series<ChartData, int>(
        id: 'Guariti',
        seriesColor: charts.Color.fromHex(code: "#329e52"),
        strokeWidthPxFn: (ChartData sales, _) => 4,
        domainFn: (ChartData sales, _) => sales.day,
        measureFn: (ChartData sales, _) => sales.people,
        data: dataRecovered,
      ),
      new charts.Series<ChartData, int>(
        id: 'Decessi',
        seriesColor: charts.Color.fromHex(code: "#d44242"),
        strokeWidthPxFn: (ChartData sales, _) => 4,
        domainFn: (ChartData sales, _) => sales.day,
        measureFn: (ChartData sales, _) => sales.people,
        data: dataDeaths,
      ),
    ];
  }

  //ricava i dati per il grafico che indica i nuovi casi in una certa data
  static List<charts.Series<ChartData, DateTime>> createConfirmedNewCasesData(
      List<DatiNazione> dnList) {
    List<ChartData> data = [];
    var oldTs = 0;
    //creo la lista di tutti i dati che andranno nel grafico
    for (DatiNazione ts in dnList) {
      DateTime d = DateTime.parse(ts.data);
      data.add(new ChartData(d, ts.totale_casi - oldTs));
      oldTs = ts.totale_casi;
    }

    // List<ChartData> data2 = [];

    // //creo la lista di tutti i dati che andranno nel grafico
    // for (DatiNazione ts in dnList) {
    //   DateTime d = DateTime.parse(ts.data);
    //   data2.add(new ChartData(d, ts.totale_casi));
    // }

    return [
      new charts.Series<ChartData, DateTime>(
        id: 'excluded',
        //colorFn: (_, __) => charts.MaterialPalette.deepOrange.shadeDefault,
        strokeWidthPxFn: (ChartData sales, _) => 4,
        seriesColor: charts.Color.fromHex(code: "#888888"),
        domainFn: (ChartData sales, _) => sales.date,
        measureFn: (ChartData sales, _) => sales.people,
        data: data,
      ),
      new charts.Series<ChartData, DateTime>(
          id: 'new_casesChart',
          //colorFn: (_, __) => charts.MaterialPalette.white,
          seriesColor: charts.Color.fromHex(code: "#888888"),
          domainFn: (ChartData sales, _) => sales.date,
          measureFn: (ChartData sales, _) => sales.people,
          data: data)
        // Configure our custom point renderer for this series.
        ..setAttribute(charts.rendererIdKey, 'pointNewCases'),
    ];
  }

//dati del grafico che mostra i positivi giornalieri
  static List<charts.Series<ChartData, DateTime>> createNewPositiveData(
      List<DatiNazione> dnList) {
    List<ChartData> data = [];
    //creo la lista di tutti i dati che andranno nel grafico

    for (int i = 0; i < dnList.length; i++) {
      DateTime d = DateTime.parse(dnList[i].data);
      data.add(new ChartData(d, dnList[i].variazione_totale_positivi));
    }

    return [
      new charts.Series<ChartData, DateTime>(
        id: 'newPositive_casesChart',
        colorFn: (_, __) => charts.Color.fromHex(code: "#c47600"),
        strokeWidthPxFn: (ChartData sales, _) => 4,
        domainFn: (ChartData sales, _) => sales.date,
        measureFn: (ChartData sales, _) => sales.people,
        data: data,
      ),
      new charts.Series<ChartData, DateTime>(
          id: 'newPositive_casesChart',
          colorFn: (_, __) => charts.Color.fromHex(code: "#c47600"),
          domainFn: (ChartData sales, _) => sales.date,
          measureFn: (ChartData sales, _) => sales.people,
          data: data)
        // Configure our custom point renderer for this series.
        ..setAttribute(charts.rendererIdKey, 'pointNewPositive'),
    ];
  }

//dati del grafico che mostra i positivi giornalieri
  static List<charts.Series<ChartData, DateTime>> createnewTamponiData(
      List<DatiNazione> dnList) {
    List<ChartData> dataTamponi = [];

    DatiNazione old = dnList[0];

    for (int i = 1; i < dnList.length; i++) {
      DateTime d = DateTime.parse(dnList[i].data);

      //nuovi tamponi
      dataTamponi.add(new ChartData(d, dnList[i].tamponi - old.tamponi));

      old = dnList[i];
    }

    return [
      new charts.Series<ChartData, DateTime>(
        id: 'new_tamponi_Chart',
        colorFn: (_, __) => charts.Color.fromHex(code: "#21a1c8"),
        strokeWidthPxFn: (ChartData sales, _) => 4,
        domainFn: (ChartData sales, _) => sales.date,
        measureFn: (ChartData sales, _) => sales.people,
        data: dataTamponi,
      ),
      new charts.Series<ChartData, DateTime>(
          id: 'new_tamponi_Chart',
          colorFn: (_, __) => charts.Color.fromHex(code: "#21a1c8"),
          domainFn: (ChartData sales, _) => sales.date,
          measureFn: (ChartData sales, _) => sales.people,
          data: dataTamponi)
        // Configure our custom point renderer for this series.
        ..setAttribute(charts.rendererIdKey, 'pointTamponi'),
    ];
  }

  //ricava i dati per il grafico che indica il numero di persone guarite in una certa data
  static List<charts.Series<ChartData, DateTime>> createNewRecoveredData(
      List<DatiNazione> tsList) {
    List<ChartData> data = [];
    DatiNazione old = tsList[0];

    //creo la lista di tutti i dati che andranno nel grafico
    for (int i = 1; i < tsList.length; i++) {
      DatiNazione actual_ts = tsList[i];
      DateTime date = DateTime.parse(actual_ts.data);

      int newRecovered = actual_ts.dimessi_guariti - old.dimessi_guariti;
      //print(i.toString()+" ******   "+new_confirmed.toString()+" Scusa->"+actual_ts.confirmed.toString()+" - "+old.confirmed.toString());
      if (newRecovered > 0) data.add(new ChartData(date, newRecovered));

      old = actual_ts;
    }

    return [
      new charts.Series<ChartData, DateTime>(
        id: 'new_recoveredChart',
        seriesColor: charts.Color.fromHex(code: "#329e52"),
        strokeWidthPxFn: (ChartData sales, _) => 4,
        domainFn: (ChartData sales, _) => sales.date,
        measureFn: (ChartData sales, _) => sales.people,
        data: data,
      ),
      new charts.Series<ChartData, DateTime>(
          id: 'new_recoveredChart',
          seriesColor: charts.Color.fromHex(code: "#329e52"),
          domainFn: (ChartData sales, _) => sales.date,
          measureFn: (ChartData sales, _) => sales.people,
          data: data)
        // Configure our custom point renderer for this series.
        ..setAttribute(charts.rendererIdKey, 'pointNewRecovered'),
    ];
  }

  //ricava i dati per il grafico che indica il numero di persone morte in una certa data
  static List<charts.Series<ChartData, DateTime>> createNewDeathsData(
      List<DatiNazione> tsList) {
    List<ChartData> data = [];
    DatiNazione old = tsList[0];
    //
    //creo la lista di tutti i dati che andranno nel grafico
    for (int i = 1; i < tsList.length; i++) {
      DatiNazione actual_ts = tsList[i];
      DateTime date = DateTime.parse(actual_ts.data);

      int newDeaths = actual_ts.deceduti - old.deceduti;
      //print(i.toString()+" ******   "+new_confirmed.toString()+" Scusa->"+actual_ts.confirmed.toString()+" - "+old.confirmed.toString());
      if (newDeaths > 0) data.add(new ChartData(date, newDeaths));

      old = actual_ts;
    }

    return [
      new charts.Series<ChartData, DateTime>(
        id: 'new_deathsChart',
        seriesColor: charts.Color.fromHex(code: "#d44242"),
        strokeWidthPxFn: (ChartData sales, _) => 4,
        domainFn: (ChartData sales, _) => sales.date,
        measureFn: (ChartData sales, _) => sales.people,
        data: data,
      ),
      new charts.Series<ChartData, DateTime>(
          id: 'new_deathsChart',
          seriesColor: charts.Color.fromHex(code: "#d44242"),
          domainFn: (ChartData sales, _) => sales.date,
          measureFn: (ChartData sales, _) => sales.people,
          data: data)
        // Configure our custom point renderer for this series.
        ..setAttribute(charts.rendererIdKey, 'pointNewDeaths'),
    ];
  }

  //ricava i dati per il grafico che indica il numero di persone ricoverate in una certa data
  static List<charts.Series<ChartData, DateTime>> createNewRicoveratiData(
      List<DatiNazione> tsList) {
    List<ChartData> data = [];
    DatiNazione old = tsList[0];
    //
    //creo la lista di tutti i dati che andranno nel grafico
    for (int i = 1; i < tsList.length; i++) {
      DatiNazione actual_ts = tsList[i];
      DateTime date = DateTime.parse(actual_ts.data);

      int newRicoverati =
          actual_ts.ricoverati_con_sintomi - old.ricoverati_con_sintomi;
      data.add(new ChartData(date, newRicoverati));

      old = actual_ts;
    }

    return [
      new charts.Series<ChartData, DateTime>(
        id: 'new_ricoveratiChart',
        seriesColor: charts.Color.fromHex(code: "#3e9bde"),
        strokeWidthPxFn: (ChartData sales, _) => 4,
        domainFn: (ChartData sales, _) => sales.date,
        measureFn: (ChartData sales, _) => sales.people,
        data: data,
      ),
      new charts.Series<ChartData, DateTime>(
          id: 'new_ricoveratiChart',
          seriesColor: charts.Color.fromHex(code: "#3e9bde"),
          domainFn: (ChartData sales, _) => sales.date,
          measureFn: (ChartData sales, _) => sales.people,
          data: data)
        // Configure our custom point renderer for this series.
        ..setAttribute(charts.rendererIdKey, 'pointNewRicoverati'),
    ];
  }

  //per il grafico a barre delle regioni
  static List<charts.Series<OrdinalSales, String>> createRegionData(
      List<DatiRegione> drList) {
    List<OrdinalSales> data = [];

    List<DatiRegione> sorted = [];

    sorted = drList.sublist(21);
    sorted.sort((a, b) => b.totale_casi.compareTo(a.totale_casi));

    int i = 0;
    for (DatiRegione ts in sorted) {
      if (i++ >= 10) break;
      data.add(
          OrdinalSales(ts.denominazione_regione, ts.totale_casi.toDouble()));
    }

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'regioni',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (OrdinalSales sales, _) => sales.regione,
        measureFn: (OrdinalSales sales, _) => sales.value,
        data: data,
      )
    ];
  }

  //per il grafico a barre dei continenti
  // static List<charts.Series<OrdinalSales, String>> createContinentData(
  //     List<DatiMondiali> drList) {
  //   List<OrdinalSales> data = [];
  //   Iterable<DatiMondiali> continents = [];
  //   continents = drList.where((test) => test.nome_nazione.startsWith(" "));
  //   for (DatiMondiali ts in continents)
  //     data.add(OrdinalSales(ts.nome_nazione, ts.casi_totali.toDouble()));

  //   return [
  //     new charts.Series<OrdinalSales, String>(
  //       id: 'continenti',
  //       colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
  //       domainFn: (OrdinalSales sales, _) => sales.regione,
  //       measureFn: (OrdinalSales sales, _) => sales.value,
  //       data: data,
  //     )
  //   ];
  // }

  //per il grafico a barre dei continenti che hanno il più alto tasso di letalità
  // static List<charts.Series<OrdinalSales, String>> createContinentLetalitaData(
  //     List<DatiMondiali> drList) {
  //   List<OrdinalSales> data = [];

  //   Iterable<DatiMondiali> continents = [];
  //   continents = drList.where((test) => test.nome_nazione.startsWith(" "));

  //   //ci saranno già tutti i continenti in data
  //   for (DatiMondiali ts in continents) {
  //     //escludo il mondo dal grafico
  //     if (DatiMondiali.verifyIfGlobal(ts.nome_nazione)) continue;

  //     double perc = (ts.decessi_totali / ts.casi_totali) * 100;
  //     String perc_str =
  //         FormatoNumeri.formattaNumeroPercentuale(perc / 100, conSegno: true);
  //     data.add(OrdinalSales(ts.nome_nazione + "  " + perc_str, perc));
  //   }
  //   //ordino in base alla perc di decessi
  //   data.sort((a, b) => b.value.compareTo(a.value));

  //   return [
  //     new charts.Series<OrdinalSales, String>(
  //       id: 'continentiLetalita',
  //       colorFn: (_, __) => charts.Color.fromHex(code: "#00acc1"),
  //       domainFn: (OrdinalSales sales, _) => sales.regione,
  //       measureFn: (OrdinalSales sales, _) => sales.value,
  //       data: data,
  //     )
  //   ];
  // }

  //per il grafico a barre per l avariazione percentuale giornaliera
  static List<charts.Series<ChartData, DateTime>>
      createPercentagesTotalCasesData(List<DatiNazione> drList) {
    List<ChartData> data = [];
    DatiNazione old = drList[0];
    int diff = 0;
    double perc = 0;
    for (int i = 1; i < drList.length; i++) {
      diff = drList[i].totale_casi - old.totale_casi;
      perc = (diff / old.totale_casi) * 100;
      DateTime d = DateTime.parse(drList[i].data);
      data.add(ChartData.forPercentagesChart(d, perc));
      old = drList[i];
    }

    return [
      new charts.Series<ChartData, DateTime>(
        id: 'variazionePercentuali',
        colorFn: (_, __) => charts.Color.fromHex(code: "#229688"),
        domainFn: (ChartData sales, _) => sales.date,
        measureFn: (ChartData sales, _) => sales.percentage,
        data: data,
      )
    ];
  }

  static createRegionLetalitaData(List<DatiRegione> listaDatiRegioni) {
    List<OrdinalSales> data = [];

    List<DatiRegione> miniListaRegione = [];

    //prendo solo i dati dell'ultimo aggiornamento
    miniListaRegione = listaDatiRegioni.sublist(21);

    int i = 0;
    for (DatiRegione ts in miniListaRegione) {
      if (i++ >= 10) break;
      double perc = (ts.deceduti / ts.totale_casi) * 100;
      String perc_str =
          FormatoNumeri.formattaNumeroPercentuale(perc / 100, conSegno: true);
      data.add(OrdinalSales(ts.denominazione_regione + " " + perc_str, perc));
    }

    //ordino per percentuale decrescente
    data.sort((a, b) => b.value.compareTo(a.value));

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'regioniLetalia',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (OrdinalSales sales, _) => sales.regione,
        measureFn: (OrdinalSales sales, _) => sales.value,
        data: data,
      )
    ];
  }
}

class OrdinalSales {
  final String regione; //regione inteso come area delimitata
  final double value;

  OrdinalSales(this.regione, this.value);
}
