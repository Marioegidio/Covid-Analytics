import 'package:charts_flutter/flutter.dart';
import 'package:covid_analytics_web/Utils/helper/FormatoNumeri.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:fluttertoast/fluttertoast.dart';

class WdgLineChartPoint extends StatelessWidget {
  final List<charts.Series> dataList;
  final List<String> dataStrings;
  final int desideredCount;
  WdgLineChartPoint(
      {this.dataList, this.dataStrings, this.desideredCount = 7}) {
    if (this.dataStrings.length < 3)
      throw FormatException("Inserire almeno tre stringhe!!");
  }

  static final int TOAST_DURATION = 4;

  Widget build(BuildContext context) {
    return charts.TimeSeriesChart(
      dataList,
      animate: true,
      dateTimeFactory: const charts.LocalDateTimeFactory(),
      primaryMeasureAxis: new charts.NumericAxisSpec(
          tickProviderSpec: new charts.BasicNumericTickProviderSpec(
              desiredTickCount: desideredCount)),
      behaviors: [
        new charts.PanAndZoomBehavior(),
      ],
      domainAxis: charts.DateTimeAxisSpec(
        viewport: charts.DateTimeExtents(
            start: DateTime.now().add(Duration(days: -50)),
            end: DateTime.now()),
        tickProviderSpec: charts.DayTickProviderSpec(increments: [15]),
      ),
      customSeriesRenderers: [
        charts.PointRendererConfig(customRendererId: 'point'),
        charts.PointRendererConfig(customRendererId: 'pointNewCases'),
        charts.PointRendererConfig(customRendererId: 'pointNewPositive'),
        charts.PointRendererConfig(customRendererId: 'pointTamponi'),
        charts.PointRendererConfig(customRendererId: 'pointNewRecovered'),
        charts.PointRendererConfig(customRendererId: 'pointNewDeaths'),
        charts.PointRendererConfig(customRendererId: 'pointNewRicoverati'),
      ],
      selectionModels: [
        charts.SelectionModelConfig(
            changedListener: (charts.SelectionModel model) {
          if (model.selectedDatum.isNotEmpty) {
            DateTime date = model.selectedDatum.first.datum.date;

            model.selectedSeries.first.id;
            String formattedDate = formatDate(date, [dd, ' ', M, ' ', yyyy]);
            int cases = model.selectedDatum.first.datum.people;
            // Fluttertoast.cancel();

            Fluttertoast.showToast(
                msg: this.dataStrings[0] +
                    formattedDate +
                    this.dataStrings[1] +
                    FormatoNumeri.formattaNumeroCompatto(cases,
                        conSegno: true) +
                    //cases.toString() +
                    this.dataStrings[2],
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        })
      ],
    );
  }
}

class DateTimeAxisSpecWorkaround extends DateTimeAxisSpec {
  const DateTimeAxisSpecWorkaround({
    RenderSpec<DateTime> renderSpec,
    DateTimeTickProviderSpec tickProviderSpec,
    DateTimeTickFormatterSpec tickFormatterSpec,
    bool showAxisLine,
  }) : super(
            renderSpec: renderSpec,
            tickProviderSpec: tickProviderSpec,
            tickFormatterSpec: tickFormatterSpec,
            showAxisLine: showAxisLine);

  @override
  configure(charts.Axis<DateTime> axis, ChartContext context,
      GraphicsFactory graphicsFactory) {
    super.configure(axis, context, graphicsFactory);
    axis.autoViewport = false;
  }
}
