
import 'package:charts_common/common.dart';
import 'package:yaml/yaml.dart';
import 'dart:io';
import 'package:charts_flutter/flutter.dart' as charts;
Map loadYamlFileSync(String path) {
  File file = new File(path);
  if (file?.existsSync() == true) {
    return loadYaml(file.readAsStringSync());
  }
  return null;
}

Future<Map> loadYamlFile(String path) async{
  File file = new File(path);
  if ((await file?.exists()) == true) {
    String content = await file.readAsString();
    return loadYaml(content);
  }
  return null;
}


Color getColor(double rating) {
    if (rating <= 0.5) {
      return charts.MaterialPalette.red.shadeDefault;
    } else if (rating > 0.5 && rating < 0.7) {
      return charts.MaterialPalette.yellow.shadeDefault;
    }
    return charts.MaterialPalette.green.shadeDefault;
}