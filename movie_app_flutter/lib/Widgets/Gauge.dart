import 'dart:math';

/// Gauge chart example, where the data does not cover a full revolution in the
/// chart.
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_flutter/util.dart';
class GaugeChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;
  final int strokeWidth;
  final double rating;

  GaugeChart(this.seriesList, {this.animate, this.strokeWidth, this.rating});

  /// Creates a [PieChart] with sample data and no transition.
  factory GaugeChart.withRating(double rating) {
    return new GaugeChart(
      _createSimpleData(rating),
      // Disable animations for image tests.
      animate: false,
      rating: rating,
      strokeWidth: 4,
    );
  }
  /// Create one series with sample hard coded data.
  static List<charts.Series<GaugeSegment, String>> _createSimpleData(double rating) {
    final data = [
      new GaugeSegment('rating', rating),
    ];

    return [
      new charts.Series<GaugeSegment, String>(
        id: 'Segments',
        domainFn: (GaugeSegment segment, _) => segment.segment,
        measureFn: (GaugeSegment segment, _) => segment.size,
        data: data,
        colorFn:  (_, __) => getColor(rating)
      )
    ];
  }
  

  @override
  Widget build(BuildContext context) {
    return new charts.PieChart(seriesList,
        animate: animate,
        // Configure the width of the pie slices to 30px. The remaining space in
        // the chart will be left as a hole in the center. Adjust the start
        // angle and the arc length of the pie so it resembles a gauge.
        defaultRenderer: new charts.ArcRendererConfig(
            arcWidth: strokeWidth, 
            startAngle: -1/2 * pi, 
            arcLength:  rating * 2 * pi,
            )
          );
  }
}

/// Sample data type.
class GaugeSegment {
  final String segment;
  final double size;

  GaugeSegment(this.segment, this.size);
}