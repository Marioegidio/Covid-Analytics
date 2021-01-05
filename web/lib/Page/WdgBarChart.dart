import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class WdgBarChart extends StatelessWidget {
  final List<charts.Series> dataList;
  final List<String> dataStrings;
  bool isVerticalBar;
  int numLines;
  WdgBarChart(
      {this.dataList,
      this.dataStrings,
      this.isVerticalBar = false,
      this.numLines = 4}) {}

  static final int TOAST_DURATION = 4;

  Widget build(BuildContext context) {
    return charts.BarChart(
      dataList,
      primaryMeasureAxis: new charts.NumericAxisSpec(
          tickProviderSpec: new charts.BasicNumericTickProviderSpec(
              desiredTickCount: numLines)),
      animate: true,
      vertical: isVerticalBar,
      barRendererDecorator:
          new charts.BarLabelDecorator<String>(labelPadding: 10),
      defaultInteractions: true,
      domainAxis:
          new charts.OrdinalAxisSpec(renderSpec: new charts.NoneRenderSpec()),
      behaviors: [
        new charts.PanAndZoomBehavior(),
      ],
    );
  }
}
