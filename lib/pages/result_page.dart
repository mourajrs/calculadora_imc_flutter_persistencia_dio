import 'package:bmi/models/calculation_model.dart';
// import 'package:bmi/pages/calculation_page.dart';
import 'package:bmi/repositories/calculation_page_repository.dart';

// import 'package:bmi/models/person.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ResultPage extends StatefulWidget {
  final List<CalculationModel> results;
  const ResultPage({Key? key, required this.results}) : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  List<CalculationModel> results = [];
  late CalculationPageRepository calculationPageRepository;

  @override
  void initState() {
    super.initState();
    initializeRepository();
  }

  Future<void> initializeRepository() async {
    calculationPageRepository = await CalculationPageRepository.load();
    results = calculationPageRepository.obterDados();
    results.sort((a, b) => b.date!.compareTo(a.date!));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey.shade50,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 100, 128, 169),
          title: const Text(
            'Resultado do IMC',
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, index) {
              final dateFormat = DateFormat("dd/MM/yyyy HH:mm:ss");
              final formattedDate = dateFormat.format(results[index].date!);
              return Card(
                color: const Color.fromARGB(255, 255, 255, 255),
                child: ListTile(
                  title: Text(results[index].name ?? ""),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Idade: ${results[index].age}", style: const TextStyle(fontWeight: FontWeight.w800)),
                      Text("Altura: ${results[index].height}", style: const TextStyle(fontWeight: FontWeight.w800)),
                      Text("Peso: ${results[index].weight}", style: const TextStyle(fontWeight: FontWeight.w800)),
                      Text("IMC: ${results[index].bmi!.toStringAsFixed(2)}", style: const TextStyle(fontWeight: FontWeight.w800)),
                      Text("Diagnóstico:  ${results[index].diagnostic}", style: const TextStyle(fontWeight: FontWeight.w800)),
                      Text("Data: $formattedDate", style: const TextStyle(fontWeight: FontWeight.w800))
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
