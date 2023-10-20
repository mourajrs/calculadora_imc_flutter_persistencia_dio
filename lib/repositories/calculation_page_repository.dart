import 'package:bmi/models/calculation_model.dart';
import 'package:hive/hive.dart';

class CalculationPageRepository {
  static late Box _box;
  final keyCalculationModel = "key_calculationModel";

  CalculationPageRepository._create();

  static Future<CalculationPageRepository> load() async {
    if (Hive.isBoxOpen("key_calculationModel")) {
      _box = Hive.box("key_calculationModel");
    } else {
      _box = await Hive.openBox("key_calculationModel");
    }

    return CalculationPageRepository._create();
  }

  save(CalculationModel calculationModel) {
    _box.add(calculationModel);
  }

  List<CalculationModel> obterDados() {
    return _box.values.cast<CalculationModel>().toList();
  }
}
