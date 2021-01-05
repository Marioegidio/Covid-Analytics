import 'package:covid_analytics_web/Utils/helper/widget/MyAlert.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:list_tile_more_customizable/list_tile_more_customizable.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class WdgCardDati extends StatelessWidget {
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

  WdgCardDati(
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
      margin: EdgeInsets.only(left: 7, right: 7, top: 5),
      child: Container(
        width: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            //MyListTile(
            Row(children: [
              IconButton(
                icon: Icon(this.icona),
                iconSize: 50,
                color: this.colore,
                tooltip: 'Help',
                onPressed: this.usaAlert != true
                    ? null
                    : () {
                        //!=true così prende anche il null
                        MyAlert(
                          context: context,
                          icona: iconaAlert,
                          style:
                              AlertStyle(animationType: AnimationType.fromTop),
                          titoloWidget: titoloAlert,
                          descrizioneWidget: descrizioneAlert,
                          buttons: [
                            DialogButton(
                              child: Text(
                                "OK",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              onPressed: () => Navigator.pop(context),
                              width: 120,
                            )
                          ],
                        ).show();
                        //  },
                        // popup.show(
                        //   title: 'String or Widget',
                        //   content: 'String or Widget',
                        //   actions: [
                        //     popup.button(
                        //       label: 'Close',
                        //       onPressed: Navigator.of(context).pop,
                        //     ),
                        //   ],
                        //   // bool barrierDismissible = false,
                        //   // Widget close,
                        // );
                      },
              ),
              // Icon(
              //   this.icona,
              //   size: 50,
              //   color: this.colore,
              // ),
              Padding(
                  padding: const EdgeInsets.only(
                      left: 11, bottom: 8, top: 3, right: 5),
                  child: Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    children: <Widget>[
                      Text(titolo.toString(),
                          style: TextStyle(
                            fontSize: 17.5,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          )),
                      Text(
                        "" + datiGrassetto[0].toString(),
                        style: TextStyle(
                          fontSize: 18.0, //17.5,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(230, 0, 0,
                              128), //Colors.blue[700],//Color.fromARGB(230, 0, 30, 70),//Color.fromARGB(200, 10, 30, 170),//
                        ),
                      ),
                    ],
                  )),
              datiGrassetto.length == 4
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                          Text(" \t" + datiGrassetto[2],
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14)),
                          SizedBox(
                            height: 1,
                          ),
                          Text(" \t" + datiGrassetto[3],
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11)),
                          SizedBox(
                            height: 1,
                          ),
                          Text("ultime 24h",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 8.5,
                                  fontWeight: FontWeight.w500)),
                        ])
                  : Text(""),
              Padding(
                padding: const EdgeInsets.only(left: 11.0, right: 5),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(text: descrizioni[0]),
                      TextSpan(
                        text: "\n" + descrizioni[1],
                        style: TextStyle(
                          fontSize: 11.5,
                        ),
                      ),
                      TextSpan(
                          text: DateFormat("dd MMM yyyy ore HH:mm").format(
                              DateTime.parse(datiGrassetto[1])
                                  .add(Duration(hours: 1))),
                          style: TextStyle(
                              fontSize: 11.5, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ]),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}
