import 'package:covid_analytics_web/Components/My_clipper.dart';
import 'package:covid_analytics_web/Data/DatiRegione.dart';
import 'package:covid_analytics_web/Utils/Utility.dart';
import 'package:covid_analytics_web/Utils/helper/FormatoNumeri.dart';
import 'package:covid_analytics_web/Utils/helper/widget/MyListTile.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main.dart';

class WdgHomeRegioni extends StatefulWidget {
  static const double distanzaCard = 5;

  @override
  State<StatefulWidget> createState() => WdgHomeRegioniState();
}

class WdgHomeRegioniState extends State<WdgHomeRegioni> {
  static int _selectedSort = 0;
  static int _selectedModSort = 1;

  //TODO se si modifica l'altezza dei servizi o del nome utente bisogna modificare qua
  static const double _altezzaExpanded = 161.0 + 87 * 4;
  static List<DatiRegione> datiOggiRegioniList = [], datiIeriRegioniList = [];

  @override
  Widget build(BuildContext context) {
    Utility.updateDeviceDimension(context);
    return FutureBuilder<List<DatiRegione>>(
      future: MainScreenAppState.futureDatiRegioni,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (datiOggiRegioniList.length == 0) {
            for (int i = 0; i < 21; i++)
              datiIeriRegioniList.add(snapshot.data[i]);

            datiIeriRegioniList
                .sort((a, b) => a.codice_regione.compareTo(b.codice_regione));
            for (int i = 21; i < snapshot.data.length; i++) {
              datiOggiRegioniList.add(snapshot.data[i]);
            }
            ordinaListaRegioni();
          }

          return SingleChildScrollView(
              child: Column(children: generateRegioni()));
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

        return Container(
            height: Utility.height.toDouble(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[Center(child: RefreshProgressIndicator())],
            ));
      },
    );
  }

  GridTile generateGrid(
      IconData icon, String title, String subtitle, int incremento,
      {bool visIncremento = true}) {
    String incrementoStr = "";
    if (visIncremento) {
      incrementoStr = "(" +
          FormatoNumeri.formattaNumeroCompatto(incremento, conSegno: true) +
          ")";
      // incremento > 0
      //     ? incrementoStr = "(+" + incremento.toString() + ")"
      //     // : incrementoStr = "(" + incremento.toString() + ")";
      //     : incrementoStr = "(0)";
    }
    return GridTile(
        child: Container(
      child: Card(
        elevation: 1,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            MyListTile(
              contentPadding: EdgeInsets.only(left: 5, top: 0, bottom: 0),
              leading: Icon(
                icon,
                size: 35,
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              title: Padding(
                  padding: EdgeInsets.only(
                      left: 10, top: 4.6, bottom: 4.8, right: 5),
                  child: Wrap(
                    children: <Widget>[
                      Text(
                        title + "",
                        style: TextStyle(
                            fontSize: 17.3,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).scaffoldBackgroundColor),
                      ),
                    ],
                  )),
              subtitle: Padding(
                padding: const EdgeInsets.only(left: 10.0, bottom: 1),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      subtitle + " ",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).scaffoldBackgroundColor),
                    ),
                    Text(
                      incrementoStr,
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w200,
                          color: Theme.of(context).scaffoldBackgroundColor),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }

  List<Widget> generateRegioni() {
    List<Widget> listaWidget = [];
    //prossima release ordinamento

    listaWidget.add(buildFilterHeader());

    int codRegione;
    //for (int i = 0; i < datiOggiRegioniList.length; i++) {

    listaWidget.add(Container(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: datiOggiRegioniList.length,
            itemBuilder: (context, i) {
              codRegione = datiOggiRegioniList[i].codice_regione;
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                child: ExpandableNotifier(
                    child: Column(children: [
                  ExpandableTheme(
                      data: ExpandableThemeData(
                          iconColor: Colors.white,
                          animationDuration: const Duration(milliseconds: 150)),
                      child: Expandable(
                          collapsed: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .accentColor
                                  .withOpacity(0.945),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              // boxShadow: [
                              //   BoxShadow(color: Colors.deepOrangeAccent, spreadRadius: 3),
                              // ],
                            ),
                            child: ExpandableButton(
                                child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10.0,
                                          left: 18,
                                          right: 5,
                                          bottom: 0),
                                      child: Text(
                                        datiOggiRegioniList[i]
                                            .denominazione_regione
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: 24,
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 15.0),
                                      child: Icon(
                                        Icons.info,
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        size: 20,
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.82,
                                      child: Center(
                                        child: Row(
                                          children: [
                                            Text(
                                              FormatoNumeri.formattaNumero(
                                                      datiOggiRegioniList[i]
                                                          .totale_casi) +
                                                  " casi",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 24,
                                                  color: Theme.of(context)
                                                      .scaffoldBackgroundColor),
                                            ),
                                            Text(
                                              " ( " +
                                                  FormatoNumeri
                                                      .formattaNumeroCompatto(
                                                    (datiOggiRegioniList[i]
                                                            .totale_casi -
                                                        datiIeriRegioniList[
                                                                codRegione - 1]
                                                            .totale_casi),
                                                    conSegno: true,
                                                  ) +
                                                  " )",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Theme.of(context)
                                                      .scaffoldBackgroundColor),
                                            ),
                                          ],
                                        ),
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.82,
                                    child: Text(
                                      FormatoNumeri.formattaNumeroCompatto(
                                        datiOggiRegioniList[i].numero_abitanti,
                                        suffissoMilioni: " di abit.",
                                        suffisso: " abit.",
                                      ),
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w300,
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                )
                              ],
                            )),
                          ),
                          expanded: Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: Column(children: [
                              ExpandableButton(
                                child: Container(
                                    margin: EdgeInsets.only(top: 0, bottom: 0),
                                    width: MediaQuery.of(context).size.width,
                                    decoration: new BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20)),
                                      shape: BoxShape.rectangle,
                                      color: Theme.of(context)
                                          .accentColor
                                          .withOpacity(0.945),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10.0,
                                                  left: 18,
                                                  right: 5,
                                                  bottom: 10),
                                              child: Text(
                                                datiOggiRegioniList[i]
                                                    .denominazione_regione
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize: 26,
                                                  fontWeight: FontWeight.w600,
                                                  color: Theme.of(context)
                                                      .scaffoldBackgroundColor,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 15.0),
                                              child: Icon(
                                                Icons.close,
                                                color: Theme.of(context)
                                                    .scaffoldBackgroundColor,
                                                size: 20,
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    )),
                              ),
                              Container(
                                  margin: EdgeInsets.only(top: 0, bottom: 0),
                                  height: _altezzaExpanded,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .accentColor
                                        .withOpacity(0.945),
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(30),
                                        bottomRight: Radius.circular(30)),
                                    // boxShadow: [
                                    //   BoxShadow(color: Colors.deepOrangeAccent, spreadRadius: 3),
                                    // ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GridView.count(
                                      crossAxisCount:
                                          MediaQuery.of(context).orientation ==
                                                  Orientation.landscape
                                              ? 3
                                              : 2,
                                      childAspectRatio:
                                          MediaQuery.of(context).orientation ==
                                                  Orientation.landscape
                                              ? 2.3
                                              : 1.92,
                                      // TODO: !!ATTENZIONE!!
                                      // TODO: controllare se così l'aspectRadio va bene su device piccoli
                                      // ora è  Utility.aspectRatioRidotta - prima era 1.9
                                      primary: false,
                                      children: <Widget>[
                                        generateGrid(
                                            Icons.assignment_turned_in,
                                            "Casi totali",
                                            FormatoNumeri
                                                .formattaNumeroCompatto(
                                                    datiOggiRegioniList[i]
                                                        .totale_casi),
                                            (datiOggiRegioniList[i]
                                                    .totale_casi -
                                                datiIeriRegioniList[
                                                        codRegione - 1]
                                                    .totale_casi)),
                                        generateGrid(
                                            Icons.playlist_add_check,
                                            "Positivi",
                                            FormatoNumeri
                                                .formattaNumeroCompatto(
                                                    datiOggiRegioniList[i]
                                                        .totale_positivi),
                                            (datiOggiRegioniList[i]
                                                    .totale_positivi -
                                                datiIeriRegioniList[
                                                        codRegione - 1]
                                                    .totale_positivi)),
                                        generateGrid(
                                            Icons.healing,
                                            "Guariti",
                                            FormatoNumeri
                                                .formattaNumeroCompatto(
                                                    datiOggiRegioniList[i]
                                                        .dimessi_guariti),
                                            (datiOggiRegioniList[i]
                                                    .dimessi_guariti -
                                                datiIeriRegioniList[
                                                        codRegione - 1]
                                                    .dimessi_guariti)),
                                        generateGrid(
                                            Icons.cancel,
                                            "Deceduti",
                                            FormatoNumeri
                                                .formattaNumeroCompatto(
                                                    datiOggiRegioniList[i]
                                                        .deceduti),
                                            (datiOggiRegioniList[i].deceduti -
                                                datiIeriRegioniList[
                                                        codRegione - 1]
                                                    .deceduti)),
                                        generateGrid(
                                            Icons.import_export,
                                            "Terapia intensiva",
                                            FormatoNumeri
                                                .formattaNumeroCompatto(
                                                    datiOggiRegioniList[i]
                                                        .terapia_intensiva),
                                            (datiOggiRegioniList[i]
                                                    .terapia_intensiva -
                                                datiIeriRegioniList[
                                                        codRegione - 1]
                                                    .terapia_intensiva)),
                                        generateGrid(
                                            Icons.local_hospital,
                                            "Ricoverati",
                                            FormatoNumeri
                                                .formattaNumeroCompatto(
                                                    datiOggiRegioniList[i]
                                                        .totale_ospedalizzati),
                                            (datiOggiRegioniList[i]
                                                    .totale_ospedalizzati -
                                                datiIeriRegioniList[
                                                        codRegione - 1]
                                                    .totale_ospedalizzati)),
                                        generateGrid(
                                            Icons.colorize,
                                            "Tamponi",
                                            FormatoNumeri
                                                .formattaNumeroCompatto(
                                                    datiOggiRegioniList[i]
                                                        .tamponi),
                                            (datiOggiRegioniList[i].tamponi -
                                                datiIeriRegioniList
                                                    .elementAt(codRegione - 1)
                                                    .tamponi)),
                                        generateGrid(
                                            Icons.home,
                                            "Isolamento domiciliare",
                                            FormatoNumeri.formattaNumeroCompatto(
                                                datiOggiRegioniList[i]
                                                    .isolamento_domiciliare),
                                            (datiOggiRegioniList[i]
                                                    .isolamento_domiciliare -
                                                datiIeriRegioniList[
                                                        codRegione - 1]
                                                    .isolamento_domiciliare)),
                                        generateGrid(
                                            Icons.show_chart,
                                            "Contag./abit.",
                                            datiOggiRegioniList[i].tasso_casi,
                                            0,
                                            visIncremento: false),
                                        generateGrid(
                                            Icons.show_chart,
                                            "Deced./abit.",
                                            datiOggiRegioniList[i]
                                                .tasso_deceduti,
                                            0,
                                            visIncremento: false),
                                      ],
                                    ),
                                  )),
                            ]),
                          )))
                ])),
              );
            }),
      ),
    ));
    //}
    return listaWidget;
  }

  Widget generaSwitchOrdinamento() {
    final Map<int, Widget> logoWidgets = <int, Widget>{
      0: Center(
        child: Text("Contagi",
            style: TextStyle(
                fontSize: 13.2,
                color: _selectedSort == 0
                    ? Theme.of(context).scaffoldBackgroundColor
                    : Theme.of(context).accentColor)),
      ),
      1: Center(
        child: Text("Decessi",
            style: TextStyle(
                fontSize: 13.2,
                color: _selectedSort == 1
                    ? Theme.of(context).scaffoldBackgroundColor
                    : Theme.of(context).accentColor)),
      ),
      2: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Padding(
                padding: EdgeInsets.only(top: 3, left: 2, right: 2),
                child: Text("Perc.",
                    style: TextStyle(
                        fontSize: 13,
                        color: _selectedSort == 2
                            ? Theme.of(context).scaffoldBackgroundColor
                            : Theme.of(context).accentColor))),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 3, left: 2, right: 2),
              child: Text("Decessi",
                  style: TextStyle(
                      fontSize: 13.2,
                      color: _selectedSort == 2
                          ? Theme.of(context).scaffoldBackgroundColor
                          : Theme.of(context).accentColor)),
            ),
          ]),
        ],
      ),
      3: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 3, left: 2, right: 2),
              child: Text("Perc.",
                  style: TextStyle(
                      fontSize: 13,
                      color: _selectedSort == 3
                          ? Theme.of(context).scaffoldBackgroundColor
                          : Theme.of(context).accentColor)),
            ),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 3, left: 2, right: 2),
              child: Text("Casi tot.",
                  style: TextStyle(
                      fontSize: 13.2,
                      color: _selectedSort == 3
                          ? Theme.of(context).scaffoldBackgroundColor
                          : Theme.of(context).accentColor)),
            ),
          ]),
        ],
      ),
      4: Center(
          child: Text("Nome",
              style: TextStyle(
                  fontSize: 13.2,
                  color: _selectedSort == 4
                      ? Theme.of(context).scaffoldBackgroundColor
                      : Theme.of(context).accentColor))),
    };
    Widget cupe_switch;
    cupe_switch = Padding(
      padding: EdgeInsets.only(top: 3.0, bottom: 7.0),
      child: Row(
        children: <Widget>[
          // SizedBox(
          //   width: 5.0,
          // ),
          Expanded(
            child: CupertinoSlidingSegmentedControl(
              thumbColor: Theme.of(context).accentColor,
              backgroundColor: Theme.of(context).backgroundColor,
              groupValue: _selectedSort,
              onValueChanged: (changeFromGroupValue) {
                setState(() {
                  _selectedSort = changeFromGroupValue;
                });
                ordinaListaRegioni();
              },
              children: logoWidgets,
            ),
          ),
          // SizedBox(
          //   width: 5.0,
          // ),
        ],
      ),
    );
    return cupe_switch;
  }

  Widget generaSwitchModOrdinamento() {
    final Map<int, Widget> logoWidgets = <int, Widget>{
      0: Padding(
        padding: EdgeInsets.only(bottom: 6, top: 6, left: 3, right: 3),
        child: Text("Crescente",
            style: TextStyle(
                fontSize: 14,
                color: _selectedModSort == 0
                    ? Theme.of(context).scaffoldBackgroundColor
                    : Theme.of(context).accentColor)),
      ),
      1: Padding(
        padding: EdgeInsets.only(left: 5, right: 5),
        child: Text("Decrescente",
            style: TextStyle(
                fontSize: 14,
                color: _selectedModSort == 1
                    ? Theme.of(context).scaffoldBackgroundColor
                    : Theme.of(context).accentColor)),
      )
    };
    Widget cupe_switch;
    cupe_switch = CupertinoSlidingSegmentedControl(
      thumbColor: Theme.of(context).accentColor,
      backgroundColor: Theme.of(context).backgroundColor,
      groupValue: _selectedModSort,
      onValueChanged: (changeFromGroupValue) {
        setState(() {
          _selectedModSort = changeFromGroupValue;
        });
        ordinaListaRegioni();
      },
      children: logoWidgets,
    );
    return cupe_switch;
  }

  void ordinaListaRegioni() {
    //considero anche il tipo di ordinamento scelto (crescente=0, decrescente=1)
    switch (_selectedSort) {
      case 0:
        _selectedModSort == 0
            ? datiOggiRegioniList
                .sort((a, b) => a.totale_casi.compareTo(b.totale_casi))
            : datiOggiRegioniList
                .sort((a, b) => b.totale_casi.compareTo(a.totale_casi));
        break;
      case 1:
        _selectedModSort == 0
            ? datiOggiRegioniList
                .sort((a, b) => a.deceduti.compareTo(b.deceduti))
            : datiOggiRegioniList
                .sort((a, b) => b.deceduti.compareTo(a.deceduti));
        break;
      case 2:
        _selectedModSort == 0
            ? datiOggiRegioniList
                .sort((a, b) => a.tasso_deceduti.compareTo(b.tasso_deceduti))
            : datiOggiRegioniList
                .sort((a, b) => b.tasso_deceduti.compareTo(a.tasso_deceduti));
        break;
      case 3:
        _selectedModSort == 0
            ? datiOggiRegioniList
                .sort((a, b) => a.tasso_casi.compareTo(b.tasso_casi))
            : datiOggiRegioniList
                .sort((a, b) => b.tasso_casi.compareTo(a.tasso_casi));
        break;
      case 4:
        _selectedModSort == 0
            ? datiOggiRegioniList.sort((a, b) =>
                a.denominazione_regione.compareTo(b.denominazione_regione))
            : datiOggiRegioniList.sort((a, b) =>
                b.denominazione_regione.compareTo(a.denominazione_regione));
        break;
    }
  }

  Widget buildFilterHeader() {
    return ExpandableNotifier(
        child: Column(children: [
      ExpandableTheme(
          data: ExpandableThemeData(
              iconColor: Colors.white,
              animationDuration: const Duration(milliseconds: 150)),
          child: Expandable(
              collapsed: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  // boxShadow: [
                  //   BoxShadow(color: Colors.deepOrangeAccent, spreadRadius: 3),
                  // ],
                ),
                child: ExpandableButton(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      color: Theme.of(context).accentColor,
                      size: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, left: 0, right: 0, bottom: 5),
                      child: Text(
                        "Ordina per",
                        style: TextStyle(
                          fontSize: 19,
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ),
                  ],
                )),
              ),
              expanded: Column(children: [
                ExpandableButton(
                  child: Container(
                      margin: EdgeInsets.only(top: 0, bottom: 0),
                      width: MediaQuery.of(context).size.width,
                      decoration: new BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        shape: BoxShape.rectangle,
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.arrow_drop_up,
                            color: Theme.of(context).accentColor,
                            size: 40,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10.0, left: 0, right: 0, bottom: 5),
                            child: Text(
                              "Ordina per",
                              style: TextStyle(
                                fontSize: 19,
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
                Container(
                    margin: EdgeInsets.only(top: 0, bottom: 0),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30)),
                      // boxShadow: [
                      //   BoxShadow(color: Colors.deepOrangeAccent, spreadRadius: 3),
                      // ],
                    ),
                    child: Center(
                        child: Column(
                      children: [
                        Container(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    SizedBox(height: 3),
                                    generaSwitchOrdinamento(),
                                    SizedBox(height: 3 //5,
                                        ),
                                    generaSwitchModOrdinamento(),
                                    SizedBox(height: 8),
                                  ],
                                ),
                              )),
                            ],
                          ),
                        ),
                      ],
                    )))
              ]))),
    ]));
    // Card(
    //   margin: Utility.margineCards.add(EdgeInsets.only(top: -7)),
    //   elevation: 4,
    //   child: ExpansionTile(
    //     initiallyExpanded: false,
    //     title: MyListTile(
    //       contentPadding: EdgeInsets.all(0),
    //       leading: Image.asset(
    //         "assets/images/filter.png",
    //         height: 50,
    //         width: 52,
    //         color: Colors.white,
    //       ),
    //       title: Padding(
    //           padding: const EdgeInsets.only(bottom: 8, top: 2, left: 11.5),
    //           child: Text("Ordinamento",
    //               style: TextStyle(
    //                   fontSize: 20,
    //                   fontWeight: FontWeight.w500,
    //                   color: Colors.white))),
    //     ),
    //     children: <Widget>[
    //       SizedBox(height: 3 //5,
    //           ),
    //       generaSwitchModOrdinamento(),
    //       SizedBox(height: 10),
    //       generaSwitchOrdinamento(),
    //       SizedBox(height: 3),
    //     ],
    //   ),
    // );
  }
}
