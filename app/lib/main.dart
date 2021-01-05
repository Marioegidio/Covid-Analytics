import 'dart:io';
import 'package:covid/Data/DatiProvince.dart';
import 'package:covid/Data/DatiRegione.dart';
import 'package:covid/Page/WdgHomeRegioni.dart';
import 'package:covid/Utils/Utility.dart';
import 'package:covid/Utils/helper/config/ConfigService.dart';
import 'package:covid/Utils/helper/config/DatiConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Data/DatiNazione.dart';
import 'Screen/Home_screen.dart';
import 'Screen/Grafici_screen.dart';
import 'Screen/Info_screen.dart';
import 'Screen/News_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'Utils/Styles/style.dart';

void main() {
  runApp(Covid19App());
}

class Covid19App extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppThemes.lightTheme, // ThemeData(primarySwatch: Colors.blue),
        darkTheme: AppThemes.darkmodeTheme,
        themeMode: ThemeMode.light,
        title: 'Covid Analitycs',
        // theme: ThemeData(primarySwatch: Colors.green),
        home: MainScreenApp());
  }
}

class MainScreenApp extends StatefulWidget {
  MainScreenApp({Key key}) : super(key: key);
  final String title = "Covid Analitycs";
  createState() => MainScreenAppState();
}

class MainScreenAppState extends State<MainScreenApp> {
  static int _selectedIndex = 0;
  static Widget selectedWidget;
  static Future<List<DatiNazione>> futureDatiNazione;
  static Future<List<DatiRegione>> futureDatiRegioni;
  static Future<List<DatiProvince>> futureDatiProvince;
  static String testo = "";
  static Widget bottomnavbar;

  static Color coloreIconeAttive = Colors.deepPurpleAccent[300];
  static Color coloreTestoIconeAttive = Colors.deepPurpleAccent[300];
  static Color coloreIconeInattive = Colors.deepPurpleAccent[50];
  static Color coloreTestoIconeInattive = Colors.deepPurpleAccent[50];

  @override
  void dispose() {
    //controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // (new DatiPopolazioneMondiale()).fromJson();//deve completare il caricamento prima di usare caricare i dati dei contagi mondiali'
    caricaConfigurazione();
    notificationSubscribe();
  }

  @override
  Widget build(BuildContext context) {
    Utility.updateDeviceDimension(context);

    return RefreshIndicator(
        onRefresh: caricaDatiFutureOnSwipeDown, child: getApplicationBody());
    // return getApplicationBody();
  }

  caricaDati() {
    WdgHomeRegioniState.datiOggiRegioniList = [];
    WdgHomeRegioniState.datiIeriRegioniList = [];

    testo = "Caricamento dati in corso ...";
    mostraToast();
    testo = "Dati caricati";

    setState(() {
      futureDatiNazione = Utility.fetchDatiNazione(DatiConfig.URL_NAZIONE);
    });
    //TODO: aggiunto il 3/apr per sincronizzare il controllo dell'invocazione dello script php
    // per copie delle fonti json su altervista
    // futureDatiNazione.then((val) {
    //   ConfigService.invocaCopiaDatiSulServer();
    // });

    setState(() {
      futureDatiRegioni = Utility.fetchDatiRegioni(DatiConfig.URL_REGIONI);
    });

    setState(() {
      futureDatiProvince = Utility.fetchDatiProvince(DatiConfig.URL_PROVINCE);
    });

    setState(() {
      selectedWidget = WdgHomeNazione();
      _selectedIndex = 0;
    });
  }

  void caricaConfigurazione() async {
    await ConfigService.fetchFileConfig().then((val) {
      caricaDati();
      //invocare dopo il caricamento dei dati. In particolare servono le date di aggiornamento delle fonti.
      //Spostato come then() sull'invocazione di fetchDatiNazione()  nella caricaDati() . C'è bisogno di aspettare il caricamento dei dati dalle fonti
      //ConfigService.invocaCopiaDatiSulServer();
      //invia i dati sulla versione al server
      // sendReport();
    });
  }

  void sendReport() {
    // Utility.sendReport(versionCode, versionName);
  }

  Future<void> caricaDatiFutureOnSwipeDown() async {
    testo = "Caricamento dati in corso ...";
    // mostraToast();
    // testo = "Dati caricati";
    setState(() {
      futureDatiNazione = Utility.fetchDatiNazione(DatiConfig.URL_NAZIONE);
    });
    setState(() {
      futureDatiRegioni = Utility.fetchDatiRegioni(DatiConfig.URL_REGIONI);
    });
    setState(() {
      futureDatiProvince = Utility.fetchDatiProvince(DatiConfig.URL_PROVINCE);
    });
    futureDatiProvince.then((onValue) => {mostraToast()});

    WdgHomeRegioniState.datiOggiRegioniList = [];
    WdgHomeRegioniState.datiIeriRegioniList = [];
  }

  mostraToast() {
    Fluttertoast.cancel();
    return Fluttertoast.showToast(
        msg: testo,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        textColor: Colors.white,
        fontSize: 16.0);
    //return null;
  }

  mostraToastSocial(msg) {
    Fluttertoast.cancel();
    return Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIos: 1,
        textColor: Colors.white,
        fontSize: 18.3);
    //return null;
  }

  _showVersionDialog(context) async {
    await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Platform.isIOS
            ? new CupertinoAlertDialog(
                title: Text("title"),
                content: Text("message"),
                actions: <Widget>[
                  FlatButton(
                    child: Text("btnLabel"),
                    onPressed: () => {},
                  ),
                  FlatButton(
                    child: Text("btnLabelCancel"),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              )
            : new AlertDialog(
                title: Text("title",
                    style: GoogleFonts.lato(
                        fontSize: 16.7, fontWeight: FontWeight.w700)),
                content: Text("message",
                    style: GoogleFonts.lato(
                        fontSize: 14.8, fontWeight: FontWeight.w500)),
                actions: <Widget>[
                  FlatButton(
                      child: Container(
                          padding: EdgeInsets.all(7),
                          color: Colors.green,
                          child: Text("btnLabel",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400))),
                      onPressed: () => {Navigator.pop(context)}),
                  FlatButton(
                    child: Text("btnLabelCancel"),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              );
      },
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Errore nell\'apertura $url';
    }
  }

  //*************************************************
  //questo contiene tutto il corpo dell'applicazione
  Widget getApplicationBody() {
    return Scaffold(
        appBar: AppBar(
            title: Text(
              widget.title,
              style: TextStyle(
                color: Theme.of(context).accentColor,
              ),
            ),
            actions: <Widget>[
              DateTime.now().hour == 18
                  ? IconButton(icon: Icon(Icons.refresh), onPressed: caricaDati)
                  : SizedBox()
              /*IconButton(
                icon: Icon(Icons.info_outline),
                onPressed: () {
                  setState(() {
                    selectedWidget = WdgHomeInfo();
                  });
                },
              ),*/
            ]),
        backgroundColor: Theme.of(context).backgroundColor,
        body: selectedWidget,
        //drawer: guiDrawer(), //WdgMainDrawer(),

        bottomNavigationBar: _getBottomNAvigationBar());
  }

  Widget _getBottomNAvigationBar() {
    return BottomNavigationBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: coloreTestoIconeAttive,
      unselectedItemColor: coloreTestoIconeInattive,
      currentIndex: _selectedIndex,
      onTap: (_index) {
        setState(() {
          _selectedIndex = _index;
          switch (_selectedIndex) {
            case 0:
              selectedWidget = WdgHomeNazione();
              break;
            case 1:
              selectedWidget = WdgGraficiHome();
              break;
            case 2:
              selectedWidget = WdgHomeNews();
              break;
            case 3:
              selectedWidget = WdgHomeInfo();
              break;
            default: //sembra inutile ma mettiamolo per sicurezza
              selectedWidget = WdgHomeNazione();
              break;
          }
        });
      },
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(Icons.home, color: coloreIconeInattive),
            title: Text('Home'),
            activeIcon: Icon(Icons.home, color: coloreIconeAttive)),
        BottomNavigationBarItem(
            icon: Icon(Icons.show_chart, color: coloreIconeInattive),
            title: Text('Statistiche'),
            activeIcon: Icon(Icons.show_chart, color: coloreIconeAttive)),
        BottomNavigationBarItem(
            icon: Icon(Icons.rss_feed, color: coloreIconeInattive),
            title: Text('Notizie'),
            activeIcon: Icon(Icons.rss_feed, color: coloreIconeAttive)),
        BottomNavigationBarItem(
            icon: Icon(Icons.info_outline, color: coloreIconeInattive),
            title: Text('Info'),
            activeIcon: Icon(Icons.info_outline, color: coloreIconeAttive)),
      ],
    );
  }

  void notificationSubscribe() {}
}
