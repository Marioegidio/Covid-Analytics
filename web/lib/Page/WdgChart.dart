import 'package:date_format/date_format.dart';
//import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:fluttertoast/fluttertoast.dart';

class WdgChart extends StatelessWidget {
  final List<charts.Series> dataList;
  final List<String> dataStrings;
  WdgChart({this.dataList, this.dataStrings}) {
    if (this.dataStrings.length < 3)
      throw FormatException("Inserire almeno tre stringhe!!");
  }

  static final int TOAST_DURATION = 4;

  Widget build(BuildContext context) {
    return charts.TimeSeriesChart(
      dataList,
      animate: true,
      dateTimeFactory: const charts.LocalDateTimeFactory(),
      //behaviors: [new charts.SeriesLegend( )],
      customSeriesRenderers: [
        charts.PointRendererConfig(customRendererId: 'point'),
        charts.PointRendererConfig(customRendererId: 'pointNewCases'),
        charts.PointRendererConfig(customRendererId: 'pointNewRecovered'),
        charts.PointRendererConfig(customRendererId: 'pointNewDeaths'),
      ],
      selectionModels: [
        charts.SelectionModelConfig(
            changedListener: (charts.SelectionModel model) {
          if (model.selectedDatum.isNotEmpty) {
            DateTime date = model.selectedDatum.first.datum.date;

            model.selectedSeries.first.id;
            String selectedId = model.selectedSeries.first.id.toString();
            String formattedDate = formatDate(date, [dd, ' ', M, ' ', yyyy]);
            int cases = model.selectedDatum.first.datum.people;
            // // Fluttertoast.cancel();
            if (selectedId.compareTo("total_casesChart") == 0) {
              Fluttertoast.showToast(
                  msg: this.dataStrings[0] +
                      formattedDate +
                      " le persone contagiate risalgono a " +
                      // FormatoNumeri.formattaNumeroCompatto(cases,conSegno: true) +
                      cases.toString() +
                      ".",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0);
            } else {
              Fluttertoast.showToast(
                  msg: this.dataStrings[0] +
                      formattedDate +
                      this.dataStrings[1] +
                      cases.toString() +
                      this.dataStrings[2],
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          }
        })
      ],
    );
  }
}
