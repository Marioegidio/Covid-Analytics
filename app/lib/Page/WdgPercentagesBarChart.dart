import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:fluttertoast/fluttertoast.dart';

class WdgPercentagesBarChart extends StatelessWidget {
  final List<charts.Series> dataList;
  final List<String> dataStrings;
  WdgPercentagesBarChart({this.dataList, this.dataStrings}) {
    if (this.dataStrings.length < 3)
      throw FormatException("Inserire almeno tre stringhe!!");
  }

  static final int TOAST_DURATION = 4;

  Widget build(BuildContext context) {
    return charts.TimeSeriesChart(
      dataList,
      domainAxis: charts.DateTimeAxisSpec(
        viewport: charts.DateTimeExtents(
            start: DateTime.now().add(Duration(days: -45)),
            end: DateTime.now()),
        tickProviderSpec: charts.DayTickProviderSpec(increments: [15]),
      ),
      primaryMeasureAxis: new charts.NumericAxisSpec(
          tickProviderSpec:
              new charts.BasicNumericTickProviderSpec(desiredMinTickCount: 4)),
      animate: true,
      defaultRenderer: new charts.BarRendererConfig<DateTime>(),
      defaultInteractions: true,
      behaviors: [
        new charts.SelectNearest(),
        new charts.DomainHighlighter(),
        new charts.PanAndZoomBehavior(),
      ],
      selectionModels: [
        charts.SelectionModelConfig(
            changedListener: (charts.SelectionModel model) {
          if (model.selectedDatum.isNotEmpty) {
            DateTime date = model.selectedDatum.first.datum.date;

            model.selectedSeries.first.id;
            String formattedDate = formatDate(date, [dd, ' ', M, ' ', yyyy]);
            double perc = model.selectedDatum.first.datum.percentage;
            double percStr = num.parse(perc.toStringAsFixed(2));
            Fluttertoast.cancel();

            Fluttertoast.showToast(
                msg: this.dataStrings[0] +
                    formattedDate +
                    this.dataStrings[1] +
                    percStr.toString() +
                    this.dataStrings[2],
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIos: 2,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        })
      ],
    );
  }
}
