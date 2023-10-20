import 'package:hive/hive.dart';
part 'calculation_model.g.dart';

@HiveType(typeId: 0)
class CalculationModel extends HiveObject {
  @HiveField(0)
  String? name;
  @HiveField(1)
  int? age;
  @HiveField(2)
  double? weight;
  @HiveField(3)
  double? height;
  @HiveField(4)
  double? bmi;
  @HiveField(5)
  String? diagnostic;
  @HiveField(6)
  DateTime? date = DateTime.now();

  CalculationModel();

  CalculationModel.vazio() {
    name = "";
    age = 0;
    weight = 0;
    height = 0;
    bmi = 0;
    diagnostic = "";
    date = DateTime.now();
  }

  CalculationModel.create(this.name, this.age, this.weight, this.height,
      this.bmi, this.diagnostic, this.date);
}
