import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageNotizieUtili extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return //MaterialApp( home:
        DefaultTabController(
      length: choices.length,
      child: Scaffold(
        appBar: AppBar(
          //title: const Text('Tabbed AppBar'),
          bottom: TabBar(
            isScrollable: true,
            tabs: choices.map((Choice choice) {
              return Tab(
                text: choice.title,
                icon: Icon(choice.icon),
              );
            }).toList(),
          ),
        ),
        body: TabBarView(
          children: choices.map((Choice choice) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ChoiceCard(choice: choice),
            );
          }).toList(),
        ),
      ),
      //),
    );
  }
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'NUMERI', icon: Icons.format_list_numbered),
  const Choice(title: 'DOCUMENTI', icon: Icons.offline_bolt),
  const Choice(title: 'VARIE', icon: Icons.devices_other),
];

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key key, this.choice}) : super(key: key);

  final Choice choice;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return Card(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(choice.icon, size: 30.0, color: textStyle.color),
            Text(choice.title, style: textStyle),
          ],
        ),
      ),
    );
  }
}
