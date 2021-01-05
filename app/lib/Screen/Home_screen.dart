import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:covid/Page/WdgDatiItalia.dart';
import 'package:covid/Page/WdgHomeProvince.dart';
import 'package:covid/Page/WdgHomeRegioni.dart';

class WdgHomeNazione extends StatefulWidget {
  static WdgHomeNazioneState stateHomeNazione;

  WdgHomeNazione() {
    if (stateHomeNazione != null && stateHomeNazione.mounted)
      stateHomeNazione.setDefaultWidget();
  }
  State<StatefulWidget> createState() =>
      stateHomeNazione = WdgHomeNazioneState();
}

class WdgHomeNazioneState extends State<WdgHomeNazione> {
  static Widget _selectedWidget = WdgDatiItalia();
  static int _selectedDataIndex = 0;

  setDefaultWidget() {
    setState(() {
      _selectedWidget = WdgDatiItalia();
      _selectedDataIndex = 0;
    });
  }

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: <Widget>[
          ExpandableNotifier(
              child: Column(children: [
            ExpandableTheme(
                data: ExpandableThemeData(
                    iconColor: Colors.white,
                    animationDuration: const Duration(milliseconds: 150)),
                child: Expandable(
                    collapsed: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        // boxShadow: [
                        //   BoxShadow(color: Colors.deepOrangeAccent, spreadRadius: 3),
                        // ],
                      ),
                      child: ExpandableButton(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_box,
                            color: Theme.of(context).accentColor,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.75,
                              child: Center(
                                child: Text(
                                  "Seleziona i dati da visualizzare",
                                  style: TextStyle(
                                    fontSize: 18.5,
                                    color: Theme.of(context).accentColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                    ),
                    expanded: Column(children: [
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
                                      child: generaSwitchVisualizzaDati(),
                                    )),
                                  ],
                                ),
                              ),
                              ExpandableButton(
                                child: Container(
                                    margin: EdgeInsets.only(top: 0, bottom: 0),
                                    width: MediaQuery.of(context).size.width,
                                    height: 40,
                                    decoration: new BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20)),
                                      shape: BoxShape.rectangle,
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                    ),
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Text(
                                                "",
                                                style: TextStyle(
                                                    fontSize: 15.5,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 3,
                                            ),
                                            Icon(
                                              Icons.keyboard_arrow_up,
                                              color:
                                                  Theme.of(context).accentColor,
                                            ),
                                          ],
                                        ))),
                              )
                            ],
                          )))
                    ]))),
          ])),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.725,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              // boxShadow: [
              //   BoxShadow(color: Colors.deepOrangeAccent, spreadRadius: 3),
              // ],
            ),
            child: _selectedWidget,
          )
        ],
      ),
    );
  }

  Widget generaSwitchVisualizzaDati() {
    final Map<int, Widget> logoWidgets = <int, Widget>{
      0: Padding(
        padding: EdgeInsets.only(bottom: 8, top: 8, left: 3, right: 3),
        child: Text("Italia",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: _selectedDataIndex == 0
                    ? Theme.of(context).backgroundColor
                    : Theme.of(context).accentColor)),
      ),
      1: Padding(
          padding: EdgeInsets.only(left: 3, right: 3),
          child: Text("Regioni",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: _selectedDataIndex == 1
                      ? Theme.of(context).backgroundColor
                      : Theme.of(context).accentColor))),
      2: Padding(
          padding: EdgeInsets.only(left: 3, right: 3),
          child: Text("Province",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: _selectedDataIndex == 2
                      ? Theme.of(context).backgroundColor
                      : Theme.of(context).accentColor))),
    };
    Widget cupe_switch;
    cupe_switch = CupertinoSlidingSegmentedControl(
      // unselectedColor: Colors.white.withOpacity(0.85),
      // selectedColor: Colors.brown.withOpacity(0.8),
      // backgroundColor: Colors.brown.withOpacity(0.8),
      thumbColor: Theme.of(context).accentColor,
      backgroundColor: Theme.of(context).backgroundColor,
      groupValue: _selectedDataIndex,
      onValueChanged: (changeFromGroupValue) {
        _selectedDataIndex = changeFromGroupValue;

        switch (_selectedDataIndex) {
          case 0:
            setState(() {
              _selectedWidget = WdgDatiItalia();
            });
            break;
          case 1:
            setState(() {
              _selectedWidget = WdgHomeRegioni();
            });
            break;
          case 2:
            setState(() {
              _selectedWidget = WdgHomeProvince();
            });
            break;
        }
      },
      children: logoWidgets,
    );
    return cupe_switch;
  }
}
