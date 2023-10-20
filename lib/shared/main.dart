import 'package:bmi/models/calculation_model.dart';
import 'package:bmi/shared/imc_calculator.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var documentsDirectory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(documentsDirectory.path);
  Hive.registerAdapter(CalculationModelAdapter());
  runApp(const IMCCalculator());
}
