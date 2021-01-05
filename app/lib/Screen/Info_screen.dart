import 'package:carousel_slider/carousel_slider.dart';
import 'package:covid/Utils/Utility.dart';
import 'package:covid/Utils/helper/config/DatiConfig.dart';
import 'package:covid/Utils/helper/widget/MyAlert.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:url_launcher/url_launcher.dart';

//enum SchedaNotizia {logo_vima, num_verdi,mod_autocertificazione,minSalute,miur}

class WdgHomeInfo extends StatefulWidget {
  WdgHomeInfo({Key key}) : super(key: key);

  createState() => WdgHomeState();
}

class WdgHomeState extends State<WdgHomeInfo> with TickerProviderStateMixin {
  static bool _isButtonDisabled = false;
  static Future<String> futureNumLikes;
  static String _testoNotizia = "";
  static const String TestoPrimaNotizia = "Visita il  nostro sito";
  @override
  void initState() {
    caricaLikes();
    setState(() {
      _testoNotizia = TestoPrimaNotizia; //settare al testo della prima scheda.
    });
    super.initState();
  }

  caricaLikes() {
    setState(() {
      futureNumLikes = Utility.fetchLikes();
    });
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchMAE() async {
    const url = 'https://www.linkedin.com/in/mario-egidio';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchDPC() async {
    const url = 'https://github.com/pcm-dpc/COVID-19/blob/master/LICENSE';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchAutocertificazione() async {
    const url = 'http://app.go.wolterskluwer.com/e/er?s=1364398973&lid=116708';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchDPCDonation() async {
    const url =
        'http://www.protezionecivile.gov.it/media-comunicazione/news/dettaglio/-/asset_publisher/default/content/emergenza-coronavirus-attivato-il-conto-corrente-per-le-donazioni';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchMiur() async {
    const url = 'https://www.istruzione.it/coronavirus/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchNumeriVerdiRegionali() async {
    const url =
        'http://www.salute.gov.it/portale/nuovocoronavirus/dettaglioContenutiNuovoCoronavirus.jsp?area=nuovoCoronavirus&id=5364&lingua=italiano&menu=vuoto';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _sendLike() async {
    Utility.sendLike().then((onValue) => {
          if (onValue.compareTo("1") == 0)
            {mostraThanksToast(), caricaLikes(), _isButtonDisabled = true}
        });
  }

  mostraThanksToast() {
    Fluttertoast.cancel();
    Fluttertoast.showToast(
        msg: "Grazie !",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.deepPurple[300],
        textColor: Colors.green.shade100,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    Utility.updateDeviceDimension(context);
    //cambiaDescrizioneScheda(0);

    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
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
                    Icons.info,
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
                          "Info",
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
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.71,
            decoration: BoxDecoration(
              color:
                  Theme.of(context).scaffoldBackgroundColor.withOpacity(0.85),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              // boxShadow: [
              //   BoxShadow(color: Colors.deepOrangeAccent, spreadRadius: 3),
              // ],
            ),
            margin: EdgeInsets.only(
              left: 0,
              right: 0,
              top: 10,
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 15.0, left: 15, right: 15),
                child: Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: _launchMAE,
                      child: Container(
                        margin: EdgeInsets.only(top: 12, left: 15, right: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            FloatingActionButton(
                              onPressed: _launchMAE,
                              child: Icon(
                                Icons.person,
                                color: Theme.of(context).cursorColor,
                                size: 50,
                              ),
                              backgroundColor: Theme.of(context)
                                  .scaffoldBackgroundColor
                                  .withOpacity(0.74),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).accentColor,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      // boxShadow: [
                                      //   BoxShadow(color: Colors.deepOrangeAccent, spreadRadius: 3),
                                      // ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Text(
                                        "Caso Studio Tesi di Laurea Informatica 2020!\nEgidio Mario",
                                        style: GoogleFonts.lato(
                                            fontSize: 18.5,
                                            fontWeight: FontWeight.w400,
                                            color: Theme.of(context)
                                                .scaffoldBackgroundColor),
                                      ),
                                    ))),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    GestureDetector(
                      onTap: _launchDPC,
                      child: Container(
                        margin: EdgeInsets.only(top: 0, left: 15, right: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            FloatingActionButton(
                              onPressed: _launchDPC,
                              child: Image.asset(
                                'assets/images/link.png',
                              ),
                              backgroundColor: Theme.of(context)
                                  .scaffoldBackgroundColor
                                  .withOpacity(0.74),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                                child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).accentColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                // boxShadow: [
                                //   BoxShadow(color: Colors.deepOrangeAccent, spreadRadius: 3),
                                // ],
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    "I dati italiani sono dati ufficiali del Ministero della salute © distribuiti dal Dipartimento Protezione Civile con licenza CC BY 4.0.",
                                    style: GoogleFonts.lato(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor),
                                  )),
                            ))
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    GestureDetector(
                      onTap: _launchDPCDonation,
                      child: Container(
                        margin: EdgeInsets.only(top: 12, left: 15, right: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            FloatingActionButton(
                              onPressed: _launchDPCDonation,
                              child: Image.asset('assets/images/donation.png',
                                  width: 100),
                              backgroundColor: Theme.of(context)
                                  .scaffoldBackgroundColor
                                  .withOpacity(0.74),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).accentColor,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      // boxShadow: [
                                      //   BoxShadow(color: Colors.deepOrangeAccent, spreadRadius: 3),
                                      // ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Text(
                                        "Clicca qui per fare una donazione al conto corrente aperto dalla Protezione Civile!",
                                        style: GoogleFonts.lato(
                                            fontSize: 18.5,
                                            fontWeight: FontWeight.w400,
                                            color: Theme.of(context)
                                                .scaffoldBackgroundColor),
                                      ),
                                    ))),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  cambiaDescrizioneScheda(idx) {
    switch (idx) {
      case 0: //logo_vima:
        return TestoPrimaNotizia; //"Visita il nostro sito";
        break;
      case 1: //Autocertificazione
        return "Nuova autocertificazione fase due";
        break;
      case 2: //numeri verdi regionali
        return "Elenco numeri verdi regionali";
        break;
      case 3: //modulo sospensione mutui
        return "Modulo richiesta sospensione mutuo";
        break;
      default:
        return "Nuovo modello autocertificazione";
        break;
    }
    // setState(() {
    //       _testoDescrittivo="set state cambiaTestScheda";
    //     });
  }

  //*********** N.B. Le immagini devono avere height:150px e widht:300px */

  _openAlertReleaseNote() {
    return MyAlert(
      context: context,
      icona: Icon(
        Icons.note,
        size: 50,
        color: Colors.green,
      ),
      style: AlertStyle(animationType: AnimationType.shrink),
      titoloWidget: Text("Tutte le novità!"),
      descrizioneWidget: Column(
        children: DatiConfig.RELEASE_NOTE_WIDGETS,
      ),
      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        )
      ],
    ).show();
  }
}
