import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class WdgAreaLineChart extends StatelessWidget {
  final List<charts.Series> dataList;
  final List<String> dataStrings;
  WdgAreaLineChart({this.dataList, this.dataStrings}) {
    if (this.dataStrings.length < 3)
      throw FormatException("Inserire almeno tre stringhe!!");
  }

  static final int TOAST_DURATION = 4;

  Widget build(BuildContext context) {
    return charts.LineChart(
      dataList,
      defaultRenderer:
          new charts.LineRendererConfig(includeArea: true, areaOpacity: 0.13),
      primaryMeasureAxis: new charts.NumericAxisSpec(
          tickProviderSpec:
              new charts.BasicNumericTickProviderSpec(desiredTickCount: 7)),
      animate: true,
      behaviors: [
        new charts.PanAndZoomBehavior(),
        new charts.ChartTitle('Giorno n°',
            titleStyleSpec: charts.TextStyleSpec(fontSize: 12),
            behaviorPosition: charts.BehaviorPosition.bottom,
            titleOutsideJustification:
                charts.OutsideJustification.middleDrawArea),
        new charts.SeriesLegend(
          position: charts.BehaviorPosition.bottom,
          outsideJustification: charts.OutsideJustification.middle,
          horizontalFirst: true,
          // This defines the padding around each legend entry.
          cellPadding: new EdgeInsets.only(top: 8, bottom: 8.0, right: 7),
          desiredMaxRows: 4,
          // Render the legend entry text with custom styles.
          entryTextStyle: charts.TextStyleSpec(
            fontSize: 13,
            color: charts.Color.fromHex(code: "#141414"),
          ),
        )
      ],
    );
  }
}
