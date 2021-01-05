import 'dart:convert';
//import 'dart:html';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;
import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:html_unescape/html_unescape.dart';

class WdgHomeNews extends StatefulWidget {
  WdgHomeNews() : super();

  final String title = 'Notizie';

  @override
  WdgHomeNewsState createState() => WdgHomeNewsState();
}

class WdgHomeNewsState extends State<WdgHomeNews> {
  //static const String FEED_URL ='https://cors-anywhere.herokuapp.com/https://www.ansa.it/sito/notizie/cronaca/cronaca_rss.xml';
  //static const String FEED_URL ='https://cors-anywhere.herokuapp.com/https://www.google.com/alerts/feeds/16186956874873691834/16030131716534047623';
  static const String FEED_URL =
      'https://cors-anywhere.herokuapp.com/https://tg24.sky.it/rss/tg24_flipboard.cronaca.xml';
  //static const String FEED_URL ='https://cors-anywhere.herokuapp.com/https://www.affaritaliani.it/static/rss/rssGadget.aspx?idchannel=1';
  //static const String FEED_URL ='https://cors-anywhere.herokuapp.com/https://www.fanpage.it/feed/';
  //static const String FEED_URL ='https://cors-anywhere.herokuapp.com/https://news.google.com/rss?gl=US&hl=en-US&ceid=US:en';
  //static const String FEED_URL ='https://cors-anywhere.herokuapp.com/https://www.repubblica.it/rss/cronaca/rss2.0.xml';
  //static const String FEED_URL ='https://cors-anywhere.herokuapp.com/https://www.tgcom24.mediaset.it/rss/cronaca.xml';

  static const int MAX_NUM_FEEDS = 50;
  static const int MAX_LEN_DESCR = 5000; //max numero caratteri
  static const double fontSizeRss_titolo = 14.0;
  static const double fontSizeRss_sottotitolo = 14.0;
  static const double fontSizeRss_testo = 14.0;

  RssFeed _feed; // RSS Feed Object
  static const String loadingMessage = 'Caricamento notizie...';
  static const String feedLoadErrorMessage = 'Errore caricamento notizie.';
  static const String feedOpenErrorMessage = 'Errore lettura notizia.';
  static const String placeholderImg =
      'images/no_images_temp.png'; //trovare una immagine vuota da caricare quando non c'è
  Color colorRssHeading = Colors.deepPurpleAccent;
  Color colorRssBorder = Colors.green;
  Color colorRssBackground = Colors.black;

  HtmlUnescape unescape = HtmlUnescape();

  GlobalKey<RefreshIndicatorState> _refreshKey;

  updateFeed(feed) {
    setState(() {
      _feed = feed;
    });
  }

  // Method to navigate to the URL of a RSS feed item (selezionata).
  Future<void> openFeed(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: false,
      );
      return;
    }
    //updateTitle(feedOpenErrorMessage);
  }

  // Method to load the RSS data.
  load() async {
    //updateTitle(loadingMessage);
    loadFeed().then((result) {
      if (null == result || result.toString().isEmpty) {
        // Notify user of error.
        //updateTitle(feedLoadErrorMessage);
        return;
      }
      // If there is no error, load the RSS data into the _feed object.
      updateFeed(result);
      // Reset the title.
      //updateTitle("Feed");
    });
  }

  // Method to get the RSS data from the provided URL in the FEED_URL variable.
  Future<RssFeed> loadFeed() async {
    try {
      final client = http.Client();
      final response = await client.get(FEED_URL);
      String body = utf8.decode(response.bodyBytes);
      //print("----");
      //print("loadFeed: "+ body.toString().substring(2000,5000));
      return RssFeed.parse(body); //response.body
    } catch (e) {
      // handle any exceptions here
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    _refreshKey = GlobalKey<RefreshIndicatorState>();
    //updateTitle(widget.title);
    load();
  }

  // Method to check if the RSS feed is empty.
  isFeedEmpty() {
    return null == _feed || null == _feed.items;
  }

  // TODO 15: Create method to load the UI and RSS data.
  // Method for the pull to refresh indicator and the actual ListView UI/Data.
  body() {
    return isFeedEmpty()
        ? Center(
            child: RefreshProgressIndicator(),
          )
        : RefreshIndicator(
            backgroundColor: Color.fromARGB(0, 255, 255, 255),
            color: Color.fromARGB(0, 0, 0, 0),
            key: _refreshKey,
            child: list(),
            onRefresh: () => load(),
          );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
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
                    Icons.rss_feed,
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
                          "Notizie (Fonte Sky News)",
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
            child: body(),
          )
        ],
      ),
    ));
  }

  // TODO 16: Create the UI for the ListView and plug in the retrieved RSS data.
  // ==================== ListView Components ====================

  // ListView
  // Consists of two main widgets. A Container Widget displaying info about the
  // RSS feed and the ListView containing the RSS Data. Both contained in a
  // Column Widget.
  list() {
    //print(_feed.image.url);
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
              //child: Column(children: generateNewsCards(_feed)),
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.all(5.0),
                itemCount: min(_feed.items.length, MAX_NUM_FEEDS),
                itemBuilder: (BuildContext context, int index) {
                  final item = _feed.items[index];

                  return Container(
                    margin: EdgeInsets.only(
                      bottom: 5.0,
                      left: 5.0,
                      right: 5.0,
                    ),
                    child: Card(
                      margin: EdgeInsets.all(3),
                      elevation: 4,
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: ExpansionTile(
                        initiallyExpanded: false,
                        title: ListTile(
                          contentPadding: EdgeInsets.all(1),
                          title: titolo(item),
                          subtitle: sottotitolo(item),
                        ),
                        children: <Widget>[
                          contenuto(item), //!contenutoPresente? Text(""):
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ]);
  }

  // Method that returns the Text Widget for the title of our RSS data.
  titolo(RssItem item) {
    String titolo = "";
    try {
      titolo = item.title;
    } catch (e) {}
    return Padding(
        padding: const EdgeInsets.only(bottom: 6, top: 10),
        child: Text(
          unescape.convert(titolo),
          style: TextStyle(
              fontSize: 18.5,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).accentColor),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ));
  }

  // Method that returns the Text Widget for the RSS data.
  sottotitolo(RssItem item) {
    String sottotitolo = "";
    try {
      sottotitolo = item.description;
    } catch (e) {}
    return //Row(
        //         children: <Widget>[
        //           Flexible(
        //         child:
        Html(
      data: sottostringa(sottotitolo,
          MAX_LEN_DESCR), //+"<a href='"+item.guid+"'>"+item.guid+"</a><br>", //lasciare caratteri speciali HTML
      useRichText: true,
      //padding: EdgeInsets.all(8.0),
      linkStyle: const TextStyle(
        color: Colors.black,
        decorationColor: Colors.black,
        decoration: TextDecoration.none,
      ),
      onLinkTap: (url) {
        //print("Opening $url...");
        openFeed(url);
      },
      onImageTap: (src) {
        //print(src);
      },
      //Must have useRichText set to false for this to work
      customRender: (node, children) {
        if (node is dom.Element) {
          switch (node.localName) {
            case "custom_tag":
              return Column(children: children);
          }
        }
        return null;
      },
      customTextAlign: (dom.Node node) {
        if (node is dom.Element) {
          switch (node.localName) {
            case "p":
              return TextAlign.justify;
          }
        }
        return null;
      },
      customTextStyle: (dom.Node node, TextStyle baseStyle) {
        if (node is dom.Element) {
          switch (node.localName) {
            case "p":
              return baseStyle.merge(TextStyle(
                  color: Theme.of(context).cursorColor,
                  height: 2,
                  fontSize: fontSizeRss_sottotitolo));
          }
        }
        return baseStyle;
      },
      //       )
      // )]
    );
  }

  contenuto(RssItem item) {
    String contenuto = "";
    try {
      contenuto = item.content.value +
          "<br><a href='" +
          item.guid +
          "'>" +
          item.guid +
          "</a>";
    } catch (e) {
      contenuto = "<br><a href='" + item.guid + "'>" + item.guid + "</a>";
    }
    try {
      return SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.only(
            left: 17.0, right: 20.0, bottom: 5.0, top: 3.0),
        child: Html(
          data: contenuto, //lasciare caratteri speciali HTML
          useRichText: true,
          //padding: EdgeInsets.all(8.0),
          linkStyle: const TextStyle(
              color: Colors.deepPurple,
              decorationColor: Colors.deepPurpleAccent,
              decoration: TextDecoration.none,
              fontSize: 14),
          onLinkTap: (url) {
            print("Opening $url...");
            openFeed(url);
          },
          onImageTap: (src) {
            print(src);
          },
          //Must have useRichText set to false for this to work
          customRender: (node, children) {
            if (node is dom.Element) {
              switch (node.localName) {
                case "custom_tag":
                  return Column(children: children);
              }
            }
            return null;
          },
          customTextAlign: (dom.Node node) {
            if (node is dom.Element) {
              switch (node.localName) {
                case "p":
                  return TextAlign.left;
              }
            }
            return null;
          },
          customTextStyle: (dom.Node node, TextStyle baseStyle) {
            if (node is dom.Element) {
              switch (node.localName) {
                case "p":
                  return baseStyle.merge(TextStyle(
                    color: Theme.of(context).cursorColor,
                    height: 2,
                    fontSize: 14,
                  ));
              }
            }
            return baseStyle;
          },
        ),

        // Text(unescape.convert(item.content.value.toString()),
        //                 style: TextStyle(fontSize: 15.5, fontWeight: FontWeight.bold),
        //             )
      ));
    } catch (e) {
      return SingleChildScrollView(
          child: Text(
        "<br><a href='" + item.guid + "'>" + item.guid + "</a>",
        style: TextStyle(
            fontSize: 15.5,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurpleAccent),
      ));
    }
  }

  // Method that returns Icon Widget.
  rightIcon() {
    return Icon(
      Icons.keyboard_arrow_right,
      color: colorRssBorder,
      size: 30.0,
    );
  }

  // Custom box decoration for the Container Widgets.
  BoxDecoration customBoxDecoration() {
    return BoxDecoration(
      border: Border.all(
        color: colorRssBorder, // border color
        width: 1.0,
      ),
    );
  }

//verificare se c'è una funzione predefinita
  String sottostringa(String testo, int maxLen) {
    try {
      return testo.substring(0, maxLen);
    } catch (e) {
      return testo;
    }
  }
}
