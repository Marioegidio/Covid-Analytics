import 'package:covid_analytics_web/Components/My_clipper.dart';
import 'package:covid_analytics_web/Data/DatiProvince.dart';
import 'package:covid_analytics_web/Utils/Utility.dart';
import 'package:covid_analytics_web/Utils/helper/FormatoNumeri.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main.dart';

class WdgHomeProvince extends StatefulWidget {
  static const double distanzaCard = 5;

  createState() => WdgHomeProvinceState();
}

class WdgHomeProvinceState extends State<WdgHomeProvince> {
  WdgHomeProvinceState() {
    flag = false;
  }
  List<DatiProvince> filteredUsers = List();
  List<DatiProvince> filteredYesterday = List();
  List<DatiProvince> allToday = List();
  List<DatiProvince> allYesterday = List();
  static bool flag = false;

  @override
  Widget build(BuildContext context) {
    Utility.updateDeviceDimension(context);
    return FutureBuilder<List<DatiProvince>>(
      future: MainScreenAppState.futureDatiProvince,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (!flag) {
            for (int i = DatiProvince.NUMERO_PROVINCE;
                i < snapshot.data.length;
                i++) {
              filteredUsers.add(snapshot.data[i]);
              allToday.add(snapshot.data[i]);
            }
            for (int i = 0; i < DatiProvince.NUMERO_PROVINCE; i++) {
              filteredYesterday.add(snapshot.data[i]);
              allYesterday.add(snapshot.data[i]);
              //se il dato del giorno precedente è maggiore di quello attuale,
              //vuol dire che devo sostituire al giorno precedente il dato attuale(che è sicuramente più aggiornato)
              if (allYesterday[i].totale_casi > allToday[i].totale_casi)
                allYesterday[i].totale_casi = allToday[i].totale_casi;
            }
            flag = true;
          }

          return Column(
            children: <Widget>[
              Container(
                child: Padding(
                    padding: EdgeInsets.only(left: 12.0, right: 12, bottom: 15),
                    child: ListTile(
                        contentPadding:
                            EdgeInsets.only(left: 4, top: 10, right: 4),
                        title: TextField(
                            decoration: InputDecoration(
                              hintText: 'Cerca una provincia...',
                            ),
                            style: TextStyle(
                                fontSize: 18.3,
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).cursorColor),
                            onChanged: (string) {
                              setState(() => {
                                    filteredUsers = allToday
                                        .where((u) => (u.denominazione_provincia
                                            .toLowerCase()
                                            .contains(string.toLowerCase())))
                                        .toList(),
                                    filteredYesterday = allYesterday
                                        .where((u) => (u.denominazione_provincia
                                            .toLowerCase()
                                            .contains(string.toLowerCase())))
                                        .toList(),
                                  });
                            }))),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.all(9.0),
                    itemCount: filteredUsers.length,
                    itemBuilder: (BuildContext context, int index) {
                      return filteredUsers[index].totale_casi < 1
                          ? SizedBox()
                          : Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                child: Material(
                                  child: InkWell(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    child: Stack(
                                      overflow: Overflow.clip,
                                      children: <Widget>[
                                        Positioned(
                                          child: ClipPath(
                                            clipper: MyCustomClipper(
                                                clipType: ClipType.semiCircle),
                                            child: Container(
                                              decoration: new BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)),
                                                color: Theme.of(context)
                                                    .accentColor,
                                              ),
                                              height: 130,
                                              width: 130,
                                            ),
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Container(
                                                  decoration: new BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20)),
                                                    color: Theme.of(context)
                                                        .accentColor
                                                        .withOpacity(0.945),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Column(
                                                            children: <Widget>[
                                                              // Image.asset(
                                                              //   "assets/images/" +
                                                              //       filteredUsers[
                                                              //               index]
                                                              //           .codice_regione
                                                              //           .toString() +
                                                              //       ".png",
                                                              //   height: 38,
                                                              //   width: 45,
                                                              // ),
                                                              // SizedBox(
                                                              //   height: 1,
                                                              // ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            3.0,
                                                                        right:
                                                                            15.0),
                                                                child: Text(
                                                                  filteredUsers[index]
                                                                              .sigla_provincia !=
                                                                          "null"
                                                                      ? filteredUsers[
                                                                              index]
                                                                          .sigla_provincia
                                                                      : "NB",
                                                                  style: TextStyle(
                                                                      color: Theme.of(
                                                                              context)
                                                                          .scaffoldBackgroundColor,
                                                                      fontSize:
                                                                          30,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                              ),
                                                            ]),
                                                        Column(
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      8.0,
                                                                  vertical: 0),
                                                              child: Container(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.6,
                                                                child: Text(
                                                                  (filteredUsers[index]
                                                                              .denominazione_provincia !=
                                                                          null
                                                                      ? filteredUsers[
                                                                              index]
                                                                          .denominazione_provincia
                                                                      : "null"),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          22,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      color: Theme.of(
                                                                              context)
                                                                          .scaffoldBackgroundColor),
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            15,
                                                                        right:
                                                                            15,
                                                                        bottom:
                                                                            0),
                                                                child:
                                                                    Container(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.6,
                                                                  child: Text(
                                                                    filteredUsers[
                                                                            index]
                                                                        .denominazione_regione,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        color: Theme.of(context)
                                                                            .scaffoldBackgroundColor),
                                                                  ),
                                                                )),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 2.0,
                                                                      left: 15,
                                                                      right: 15,
                                                                      bottom:
                                                                          0),
                                                              child: Container(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.6,
                                                                child: Text(
                                                                  FormatoNumeri.formattaNumeroCompatto(
                                                                      filteredUsers[
                                                                              index]
                                                                          .totale_casi,
                                                                      suffisso:
                                                                          " casi"),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          22.5,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color: Theme.of(
                                                                              context)
                                                                          .scaffoldBackgroundColor),
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 4.0,
                                                                      left: 15,
                                                                      right: 15,
                                                                      bottom:
                                                                          0),
                                                              child: Container(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.6,
                                                                child: Row(
                                                                  // crossAxisAlignment:
                                                                  //     CrossAxisAlignment
                                                                  //         .end,
                                                                  children: [
                                                                    Text(
                                                                      (FormatoNumeri.formattaNumeroCompatto((filteredUsers[index].totale_casi - filteredYesterday[index].totale_casi), conSegno: true) !=
                                                                              ""
                                                                          ? FormatoNumeri.formattaNumeroCompatto(
                                                                              (filteredUsers[index].totale_casi - filteredYesterday[index].totale_casi),
                                                                              conSegno: true)
                                                                          : "Id non disp."),
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              18,
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          color:
                                                                              Theme.of(context).scaffoldBackgroundColor),
                                                                    ),
                                                                    Text(
                                                                      (FormatoNumeri.formattaNumeroCompatto((filteredUsers[index].totale_casi - filteredYesterday[index].totale_casi), conSegno: true) !=
                                                                              ""
                                                                          ? " nelle ultime 24h"
                                                                          : "Id non disp."),
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          color:
                                                                              Theme.of(context).scaffoldBackgroundColor),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 5),
                                          ],
                                        )
                                      ],
                                    ),
                                    // onTap: () {
                                    //   CategoriaController.selezionaCategoria(context, prenotazione);
                                    // },
                                  ),
                                  color: Colors.transparent,
                                ),
                              ),
                            );
                      // : Card(
                      //     elevation: 10,
                      //     margin: EdgeInsets.only(
                      //         top: 8.0, right: 7, bottom: 8, left: 7),
                      //     child: Padding(
                      //       padding: EdgeInsets.only(
                      //           left: 9, right: 9, top: 5, bottom: 0),
                      //       child: ListTile(
                      //           contentPadding: EdgeInsets.only(left: 5),
                      //           leading: Container(
                      //             child: Column(children: <Widget>[
                      //               Image.asset(
                      //                 "assets/images/" +
                      //                     filteredUsers[index]
                      //                         .codice_regione
                      //                         .toString() +
                      //                     ".png",
                      //                 height: 38,
                      //                 width: 45,
                      //               ),
                      //               SizedBox(
                      //                 height: 1,
                      //               ),
                      //               Text(
                      //                   filteredUsers[index].sigla_provincia),
                      //             ]),
                      //           ),
                      //           title: Text(
                      //             filteredUsers[index]
                      //                 .denominazione_provincia,
                      //             style: TextStyle(
                      //                 fontSize: 17.8,
                      //                 color: Colors.black,
                      //                 fontWeight: FontWeight.bold),
                      //           ),
                      //           trailing: Padding(
                      //               padding:
                      //                   const EdgeInsets.only(right: 10.0),
                      //               child: Text(
                      //                   FormatoNumeri.formattaNumeroCompatto(
                      //                       (filteredUsers[index]
                      //                               .totale_casi -
                      //                           filteredYesterday[index]
                      //                               .totale_casi),
                      //                       conSegno: true),
                      //                   // "  +" +
                      //                   //     (filteredUsers[index]
                      //                   //                 .totale_casi -
                      //                   //             filteredYesterday[index]
                      //                   //                 .totale_casi)
                      //                   //         .toString(),
                      //                   textAlign: TextAlign.center,
                      //                   style: TextStyle(
                      //                       color: Colors.red,
                      //                       fontSize: 16,
                      //                       fontWeight: FontWeight.bold))),
                      //           subtitle: Padding(
                      //             padding: const EdgeInsets.only(
                      //                 top: 2.5, bottom: 0.0, left: 1),
                      //             child: Column(
                      //               mainAxisAlignment:
                      //                   MainAxisAlignment.start,
                      //               crossAxisAlignment:
                      //                   CrossAxisAlignment.start,
                      //               children: <Widget>[
                      //                 Text(
                      //                   "Regione: " +
                      //                       filteredUsers[index]
                      //                           .denominazione_regione,
                      //                   style: TextStyle(
                      //                       fontSize: 16,
                      //                       fontWeight: FontWeight.w500),
                      //                 ),
                      //                 Padding(
                      //                   padding: const EdgeInsets.only(
                      //                       top: 9.5, bottom: 7),
                      //                   child: Text(
                      //                       FormatoNumeri
                      //                           .formattaNumeroCompatto(
                      //                               filteredUsers[index]
                      //                                   .totale_casi,
                      //                               suffisso: " casi"),
                      //                       // filteredUsers[index]
                      //                       //         .totale_casi
                      //                       //         .toString() +
                      //                       //   " casi totali.",
                      //                       style: TextStyle(
                      //                         fontSize: 16,
                      //                         fontWeight: FontWeight.w600,
                      //                       )),
                      //                 )
                      //               ],
                      //             ),
                      //           )),
                      //     ),
                      //   )
                      ;
                    },
                  ),
                ),
              ),
            ],
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
}
