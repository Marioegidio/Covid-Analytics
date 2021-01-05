import 'package:covid_analytics_web/Utils/helper/widget/MyAlert.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class DatiNazioneComponent extends StatelessWidget {
  final IconData icona;
  final Color colore;
  final String titolo;
  final List<String> descrizioni;
  final List<String>
      datiGrassetto; //ha un diverso stile, per quello viene passato separatamente
  final bool usaAlert; //Se è true viene impostato un Alert sul pulsante
  final Icon iconaAlert; //Se usaAlert=true deve essere non-null
  final Widget titoloAlert; //Se usaAlert=true deve essere non-null
  final Widget descrizioneAlert; //Se usaAlert=true deve essere non-null

  DatiNazioneComponent(
      {this.icona,
      this.colore,
      this.titolo,
      this.descrizioni,
      this.datiGrassetto,
      @required this.usaAlert,
      this.iconaAlert,
      this.titoloAlert,
      this.descrizioneAlert}) {
    if (!(descrizioni.length > 1 && datiGrassetto.length > 1))
      throw FormatException(
          "Argomenti non validi, Le descrizioni e i numeri devono essere almeno due per parte!");
  }

  Widget build(BuildContext context) {
    // final popup = BeautifulPopup(
    //   context: context,
    //   template: TemplateNotification,
    // );
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.circular(10),
        // boxShadow: [
        //   BoxShadow(color: Colors.deepOrangeAccent, spreadRadius: 3),
        // ],
      ),
      margin: EdgeInsets.only(
          left: 7, right: 7, top: (MediaQuery.of(context).size.height * 0.04)),
      width: MediaQuery.of(context).orientation == Orientation.landscape
          ? MediaQuery.of(context).size.width * 0.50
          : MediaQuery.of(context).size.width * 0.86,
      height: MediaQuery.of(context).size.height * 0.72,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.30,
            decoration: BoxDecoration(
              color: Theme.of(context).cursorColor.withOpacity(0.145),
              borderRadius: BorderRadius.circular(10),
              // boxShadow: [
              //   BoxShadow(color: Colors.deepOrangeAccent, spreadRadius: 3),
              // ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      IconButton(
                        icon: Icon(this.icona),
                        iconSize: 72,
                        color: this.colore.withOpacity(0.8),
                        tooltip: 'Help',
                        onPressed: () {},
                        // onPressed: this.usaAlert != true
                        //     ? null
                        //     : () {
                        //         //!=true così prende anche il null
                        //         MyAlert(
                        //           context: context,
                        //           icona: iconaAlert,
                        //           style: AlertStyle(
                        //               animationType: AnimationType.grow),
                        //           titoloWidget: titoloAlert,
                        //           descrizioneWidget: descrizioneAlert,
                        //           buttons: [
                        //             DialogButton(
                        //               child: Text(
                        //                 "OK",
                        //                 style: TextStyle(
                        //                     color: Colors.white, fontSize: 16),
                        //               ),
                        //               onPressed: () => Navigator.pop(context),
                        //               width: 120,
                        //             )
                        //           ],
                        //         ).show();
                        //       },
                      ),
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 5, bottom: 5, top: 3, right: 5),
                          child: Wrap(
                            direction: Axis.vertical,
                            alignment: WrapAlignment.spaceAround,
                            children: <Widget>[
                              Text(titolo.toString(),
                                  style: TextStyle(
                                    fontSize: 22.5,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white.withOpacity(0.8),
                                  )),
                              Text(
                                "" + datiGrassetto[0].toString(),
                                style: TextStyle(
                                    fontSize: 23.0, //17.5,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white.withOpacity(0.6)
                                    // fromARGB(230, 0, 0,128), //Colors.blue[700],//Color.fromARGB(230, 0, 30, 70),//Color.fromARGB(200, 10, 30, 170),//
                                    ),
                              ),
                            ],
                          )),
                    ]),
                    Padding(
                      padding: const EdgeInsets.only(right: 25.0),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10.0, right: 5),
                                child: Container(
                                  width: MediaQuery.of(context).orientation ==
                                          Orientation.landscape
                                      ? MediaQuery.of(context).size.width * 0.21
                                      : MediaQuery.of(context).size.width * 0.5,
                                  child: RichText(
                                    text: TextSpan(
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.black,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: "\n" + descrizioni[0],
                                            style: TextStyle(
                                                color: Colors.white
                                                    .withOpacity(0.85))),
                                        TextSpan(
                                          text: "\n" + descrizioni[1],
                                          style: TextStyle(
                                              fontSize: 10.5,
                                              color: Colors.white
                                                  .withOpacity(0.85)),
                                        ),
                                        TextSpan(
                                            text: DateFormat(
                                                    "dd MMM yyyy ore HH:mm")
                                                .format(DateTime.parse(
                                                        datiGrassetto[1])
                                                    .add(Duration(hours: 1))),
                                            style: TextStyle(
                                                fontSize: 11.5,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white
                                                    .withOpacity(0.85))),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.22,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  datiGrassetto.length == 4
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: <Widget>[
                                              Text(" " + datiGrassetto[2],
                                                  style: TextStyle(
                                                      color: Colors.white
                                                          .withOpacity(0.9),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 19)),
                                              SizedBox(
                                                height: 3,
                                              ),
                                              Text(" " + datiGrassetto[3],
                                                  style: TextStyle(
                                                      color: Colors.white
                                                          .withOpacity(0.8),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 13)),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Text("ultime 24h",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white
                                                          .withOpacity(0.75),
                                                      fontSize: 11.5,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ])
                                      : Text(""),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Center(child: descrizioneAlert),
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
