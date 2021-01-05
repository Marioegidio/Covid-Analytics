import 'package:covid_analytics_web/Data/ChartData.dart';
import 'package:covid_analytics_web/Data/DatiNazione.dart';
import 'package:covid_analytics_web/Data/DatiRegione.dart';
import 'package:covid_analytics_web/Page/WdgAreaLineChart.dart';
import 'package:covid_analytics_web/Page/WdgBarChart.dart';
import 'package:covid_analytics_web/Page/WdgLineChartPoint.dart';
import 'package:covid_analytics_web/Page/WdgPercentagesBarChart.dart';
import 'package:covid_analytics_web/Utils/Utility.dart';
import 'package:covid_analytics_web/Utils/helper/FormatoNumeri.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:covid_analytics_web/main.dart';

class WdgGraficiHome extends StatelessWidget {
  //static Future<List<DatiNazione>> futureDatiNazione;
  static String DESCRIZIONE_ULTIMO_DATO = "Ultimo dato del ";
  @override
  Widget build(BuildContext context) {
    Utility.updateDeviceDimension(context);

    return SingleChildScrollView(
      child: FutureBuilder(
        future: Future.wait([
          MainScreenAppState.futureDatiNazione,
          MainScreenAppState.futureDatiRegioni,
          // WdgHomeMondoState.futureDatiMondiali,
        ]),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<DatiNazione> listaDatiNazione = snapshot.data[0];
            List<DatiRegione> listaDatiRegioni = snapshot.data[1];
            // List<DatiMondiali> listaDatiMondiali = snapshot.data[2];
            return Center(
              child: Column(
                children: <Widget>[
                  Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        // boxShadow: [
                        //   BoxShadow(color: Colors.deepOrangeAccent, spreadRadius: 3),
                        // ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.insert_chart,
                            color: Theme.of(context).accentColor,
                            size: 30,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              child: Center(
                                child: Text(
                                  "Statistiche",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Theme.of(context).accentColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),

                  // Align(
                  //   alignment: Alignment.center,
                  //   child: Text(
                  //     //" \n(Esegui lo zoom sui grafici per vedere maggiori dettagli)",
                  //     "Ruota lo schermo per avere dei dati più leggibili!",
                  //     style: GoogleFonts.lato(
                  //         fontSize: 14, color: Colors.white),
                  //   ),
                  // Card(
                  //   color: Theme.of(context).accentColor,
                  //   margin:
                  //       EdgeInsets.only(top: 1, bottom: 4, left: 6, right: 6),
                  //   elevation: 8,
                  //   child: Padding(
                  //       padding: EdgeInsets.all(10),
                  //       child: Column(
                  //         children: <Widget>[
                  //           Align(
                  //             alignment: Alignment.center,
                  //             child: Row(
                  //               children: <Widget>[
                  //                 Padding(
                  //                   padding: const EdgeInsets.only(left: 8.0),
                  //                   child: Image.asset(
                  //                     "assets/images/swipe_right.png",
                  //                     width: 27,
                  //                   ),
                  //                 ),
                  //                 SizedBox(
                  //                   width: 6,
                  //                 ),
                  //                 Expanded(
                  //                   child: Text(
                  //                     //" \n(Esegui lo zoom sui grafici per vedere maggiori dettagli)",
                  //                     "Scorri verso destra per spostarti sulla linea temporale e visualizzare dati meno recenti.",
                  //                     style: GoogleFonts.lato(
                  //                         fontSize: 14, color: Colors.white),
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //           )
                  //         ],
                  //       )),
                  // ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)),
                      // boxShadow: [
                      //   BoxShadow(color: Colors.deepOrangeAccent, spreadRadius: 3),
                      // ],
                    ),
                    height: MediaQuery.of(context).size.height * 0.725,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          Card(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              margin: EdgeInsets.only(
                                  top: 20, bottom: 5, left: 12, right: 10),
                              elevation: 1,
                              child: ExpansionTile(
                                initiallyExpanded: true,
                                title: Padding(
                                  child: Text(
                                    "Andamento dei casi totali",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context).accentColor),
                                  ),
                                  padding: EdgeInsets.only(top: 12, bottom: 12),
                                ),
                                children: <Widget>[
                                  Container(
                                      height: MediaQuery.of(context)
                                                  .orientation ==
                                              Orientation.portrait
                                          ? MediaQuery.of(context).size.width *
                                              0.8
                                          : MediaQuery.of(context).size.height *
                                              0.67,
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      margin: EdgeInsets.only(
                                          left: 5.0, right: 2.0),
                                      child: WdgAreaLineChart(
                                          dataList:
                                              ChartData.createConfirmedData(
                                            listaDatiNazione,
                                          ),
                                          dataStrings: [
                                            "Il ",
                                            " i contagiati risalgono a ",
                                            "."
                                          ]))
                                ],
                              )),

                          Card(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              margin: EdgeInsets.only(
                                  top: 20, bottom: 5, left: 12, right: 10),
                              elevation: 1,
                              child: ExpansionTile(
                                title: Padding(
                                  child: Text(
                                    "Variazione percentuale giornaliera",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context).accentColor),
                                  ),
                                  padding: EdgeInsets.only(top: 12, bottom: 12),
                                ),
                                children: <Widget>[
                                  Container(
                                      height: MediaQuery.of(context)
                                                  .orientation ==
                                              Orientation.portrait
                                          ? MediaQuery.of(context).size.width *
                                              0.8
                                          : MediaQuery.of(context).size.height *
                                              0.67,
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      margin: EdgeInsets.only(
                                          left: 5.0, right: 2.0),
                                      child: WdgPercentagesBarChart(
                                          dataList: ChartData
                                              .createPercentagesTotalCasesData(
                                            listaDatiNazione,
                                          ),
                                          dataStrings: [
                                            "Il ",
                                            " la variazione è stata del ",
                                            "% rispetto al giorno precedente."
                                          ]))
                                ],
                              )),
                          Card(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              margin: EdgeInsets.only(
                                  top: 20, bottom: 5, left: 12, right: 10),
                              elevation: 1,
                              child: ExpansionTile(
                                title: Padding(
                                  child: Text(
                                    "Contagiati giornalieri",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context).accentColor),
                                  ),
                                  padding: EdgeInsets.only(top: 12, bottom: 12),
                                ),
                                children: <Widget>[
                                  _buildDatoLastUpdate(
                                      listaDatiNazione.last.data.toString(),
                                      listaDatiNazione.last.totale_casi -
                                          listaDatiNazione[
                                                  listaDatiNazione.length - 2]
                                              .totale_casi),
                                  Container(
                                      height: MediaQuery.of(context)
                                                  .orientation ==
                                              Orientation.portrait
                                          ? MediaQuery.of(context).size.width *
                                              0.8
                                          : MediaQuery.of(context).size.height *
                                              0.67,
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      margin: EdgeInsets.only(
                                          left: 5.0, right: 2.0),
                                      child: WdgLineChartPoint(
                                        dataList: ChartData
                                            .createConfirmedNewCasesData(
                                          listaDatiNazione,
                                        ),
                                        dataStrings: [
                                          "Il ",
                                          " sono stati registrati ",
                                          " nuovi casi totali."
                                        ],
                                        desideredCount: 10,
                                      ))
                                ],
                              )),
                          Card(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            margin: EdgeInsets.only(
                                top: 20, bottom: 5, left: 12, right: 10),
                            elevation: 1,
                            child: ExpansionTile(
                              title: Padding(
                                child: Text(
                                  "Positivi giornalieri",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).accentColor),
                                ),
                                padding: EdgeInsets.only(top: 12, bottom: 12),
                              ),
                              children: <Widget>[
                                _buildDatoLastUpdate(
                                    listaDatiNazione.last.data.toString(),
                                    listaDatiNazione
                                        .last.variazione_totale_positivi),
                                Container(
                                  height: MediaQuery.of(context).orientation ==
                                          Orientation.portrait
                                      ? MediaQuery.of(context).size.width * 0.8
                                      : MediaQuery.of(context).size.height *
                                          0.67,
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  margin:
                                      EdgeInsets.only(left: 10.0, right: 10.0),
                                  child: WdgLineChartPoint(
                                    dataList: ChartData.createNewPositiveData(
                                      listaDatiNazione,
                                    ),
                                    dataStrings: [
                                      "Il ",
                                      " sono risultate ",
                                      " persone positive."
                                    ],
                                    desideredCount: 9,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Card(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            margin: EdgeInsets.only(
                                top: 20, bottom: 5, left: 12, right: 10),
                            elevation: 1,
                            child: ExpansionTile(
                              title: Padding(
                                child: Text(
                                  "Tamponi giornalieri",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).accentColor),
                                ),
                                padding: EdgeInsets.only(top: 12, bottom: 12),
                              ),
                              children: <Widget>[
                                _buildDatoLastUpdate(
                                    listaDatiNazione.last.data.toString(),
                                    listaDatiNazione.last.tamponi -
                                        listaDatiNazione[
                                                listaDatiNazione.length - 2]
                                            .tamponi),
                                Container(
                                  height: MediaQuery.of(context).orientation ==
                                          Orientation.portrait
                                      ? MediaQuery.of(context).size.width * 0.8
                                      : MediaQuery.of(context).size.height *
                                          0.67,
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  margin:
                                      EdgeInsets.only(left: 10.0, right: 10.0),
                                  child: WdgLineChartPoint(
                                      dataList: ChartData.createnewTamponiData(
                                        listaDatiNazione,
                                      ),
                                      dataStrings: [
                                        "Il ",
                                        " sono stati effettuati ",
                                        " tamponi."
                                      ],
                                      desideredCount: 9),
                                )
                              ],
                            ),
                          ),
                          Card(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            margin: EdgeInsets.only(
                                top: 20, bottom: 5, left: 12, right: 10),
                            elevation: 1,
                            child: ExpansionTile(
                                title: Padding(
                                  child: Text(
                                    "Guarigioni giornaliere",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context).accentColor),
                                  ),
                                  padding: EdgeInsets.only(top: 12, bottom: 12),
                                ),
                                children: <Widget>[
                                  _buildDatoLastUpdate(
                                      listaDatiNazione.last.data.toString(),
                                      listaDatiNazione.last.dimessi_guariti -
                                          listaDatiNazione[
                                                  listaDatiNazione.length - 2]
                                              .dimessi_guariti),
                                  Container(
                                    height: MediaQuery.of(context)
                                                .orientation ==
                                            Orientation.portrait
                                        ? MediaQuery.of(context).size.width *
                                            0.8
                                        : MediaQuery.of(context).size.height *
                                            0.67,
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    margin: EdgeInsets.only(
                                        left: 10.0, right: 10.0),
                                    child: WdgLineChartPoint(
                                        dataList:
                                            ChartData.createNewRecoveredData(
                                          listaDatiNazione,
                                        ),
                                        dataStrings: [
                                          "Il ",
                                          " sono guarite ",
                                          " persone."
                                        ],
                                        desideredCount: 10),
                                  )
                                ]),
                          ),
                          Card(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              margin: EdgeInsets.only(
                                  top: 20, bottom: 5, left: 12, right: 10),
                              elevation: 1,
                              child: ExpansionTile(
                                  title: Padding(
                                    child: Text(
                                      "Decessi giornalieri",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: Theme.of(context).accentColor),
                                    ),
                                    padding:
                                        EdgeInsets.only(top: 12, bottom: 12),
                                  ),
                                  children: <Widget>[
                                    _buildDatoLastUpdate(
                                        listaDatiNazione.last.data.toString(),
                                        listaDatiNazione.last.deceduti -
                                            listaDatiNazione[
                                                    listaDatiNazione.length - 2]
                                                .deceduti),
                                    SizedBox(
                                      height: 1,
                                    ),
                                    Container(
                                      height: MediaQuery.of(context)
                                                  .orientation ==
                                              Orientation.portrait
                                          ? MediaQuery.of(context).size.width *
                                              0.8
                                          : MediaQuery.of(context).size.height *
                                              0.67,
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      margin: EdgeInsets.only(
                                          left: 10.0, right: 10.0),
                                      child: WdgLineChartPoint(
                                          dataList:
                                              ChartData.createNewDeathsData(
                                            listaDatiNazione,
                                          ),
                                          dataStrings: [
                                            "Il ",
                                            " sono avvenuti ",
                                            " decessi."
                                          ],
                                          desideredCount: 7),
                                    )
                                  ])),
                          Card(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              margin: EdgeInsets.only(
                                  top: 20, bottom: 5, left: 12, right: 10),
                              elevation: 1,
                              child: ExpansionTile(
                                  title: Padding(
                                    child: Text(
                                      "Ricoverati giornalieri",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: Theme.of(context).accentColor),
                                    ),
                                    padding:
                                        EdgeInsets.only(top: 12, bottom: 12),
                                  ),
                                  children: <Widget>[
                                    _buildDatoLastUpdate(
                                        listaDatiNazione.last.data.toString(),
                                        listaDatiNazione
                                                .last.ricoverati_con_sintomi -
                                            listaDatiNazione[
                                                    listaDatiNazione.length - 2]
                                                .ricoverati_con_sintomi),
                                    SizedBox(
                                      height: 1,
                                    ),
                                    Container(
                                      height: MediaQuery.of(context)
                                                  .orientation ==
                                              Orientation.portrait
                                          ? MediaQuery.of(context).size.width *
                                              0.8
                                          : MediaQuery.of(context).size.height *
                                              0.67,
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      margin: EdgeInsets.only(
                                          left: 10.0, right: 10.0),
                                      child: WdgLineChartPoint(
                                          dataList:
                                              ChartData.createNewRicoveratiData(
                                            listaDatiNazione,
                                          ),
                                          dataStrings: [
                                            "Il ",
                                            " c'erano ",
                                            " ricoverati."
                                          ],
                                          desideredCount: 7),
                                    )
                                  ])),
                          Padding(
                            padding: EdgeInsets.all(9),
                            child: Divider(
                              height: 12,
                              color: Theme.of(context).accentColor,
                              thickness: 0.5,
                            ),
                          ),
                          Card(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              margin: EdgeInsets.only(
                                  top: 5, bottom: 9, left: 12, right: 10),
                              elevation: 1,
                              child: ExpansionTile(
                                  title: Padding(
                                    child: Text(
                                      "Tasso di Letalità Regioni",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: Theme.of(context).accentColor),
                                    ),
                                    padding: EdgeInsets.only(
                                      top: 12,
                                      bottom: 12,
                                    ),
                                  ),
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12, right: 12),
                                      child: Text(
                                          "Le 10 regioni che hanno il tasso di mortalità più alto!",
                                          style: GoogleFonts.lato(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15,
                                              color: Theme.of(context)
                                                  .accentColor)),
                                    ),
                                    Container(
                                      height: MediaQuery.of(context)
                                                  .orientation ==
                                              Orientation.portrait
                                          ? MediaQuery.of(context).size.width *
                                              0.8
                                          : MediaQuery.of(context).size.height *
                                              0.67,
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      margin: EdgeInsets.only(
                                          left: 10.0, right: 10.0),
                                      child: WdgBarChart(
                                          dataList: ChartData
                                              .createRegionLetalitaData(
                                            listaDatiRegioni,
                                          ),
                                          numLines: 11),
                                    )
                                  ])),
                          Card(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              margin: EdgeInsets.only(
                                  top: 15, bottom: 9, left: 12, right: 10),
                              elevation: 1,
                              child: ExpansionTile(
                                  title: Padding(
                                    child: Text(
                                      "Casi Totali Regioni",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: Theme.of(context).accentColor),
                                    ),
                                    padding:
                                        EdgeInsets.only(top: 12, bottom: 12),
                                  ),
                                  children: <Widget>[
                                    Text("Le 10 regioni più colpite",
                                        style: GoogleFonts.lato(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15,
                                            color:
                                                Theme.of(context).accentColor)),
                                    Container(
                                      height: MediaQuery.of(context)
                                                  .orientation ==
                                              Orientation.portrait
                                          ? MediaQuery.of(context).size.width *
                                              0.8
                                          : MediaQuery.of(context).size.height *
                                              0.67,
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      margin: EdgeInsets.only(
                                          left: 10.0, right: 10.0),
                                      child: WdgBarChart(
                                          dataList: ChartData.createRegionData(
                                            listaDatiRegioni,
                                          ),
                                          numLines: 5),
                                    )
                                  ])),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          //fine card
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          // By default, show a loading spinner.
          return Container(
              height: Utility.height.toDouble(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[Center(child: RefreshProgressIndicator())],
              ));
        },
      ),
    );
  }

  Widget _buildDatoLastUpdate(String data, int numero) {
    return Text(
      DESCRIZIONE_ULTIMO_DATO +
          DateFormat("dd MMM yyyy ").format(DateTime.parse(data)) +
          ": " +
          FormatoNumeri.formattaNumeroCompatto(numero, conSegno: true)
              .toString(),
      style:
          TextStyle(fontWeight: FontWeight.w400, color: Colors.deepPurple[200]),
    );
  }
}
