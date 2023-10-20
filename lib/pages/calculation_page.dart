import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../models/calculation_model.dart';
import '../repositories/calculation_page_repository.dart';
import 'result_page.dart';

class CalculationPage extends StatefulWidget {
  const CalculationPage({super.key});

  @override
  State<CalculationPage> createState() => _CalculationPageState();
}

class _CalculationPageState extends State<CalculationPage> {
  var result = <CalculationModel>[];
  late CalculationPageRepository calculationPageRepository;
  var calculationModel = CalculationModel.vazio();

  var nameController = TextEditingController(text: "");
  var ageController = TextEditingController(text: "");
  var heightController = TextEditingController(text: "");
  var weightController = TextEditingController(text: "");
  String resultadoAvaliacao = "";

  List<CalculationModel> results = [];

  @override
  void initState() {
    super.initState();
    obterDados();
    initializeRepository();
  }

  void obterDados() async {
    calculationPageRepository = await CalculationPageRepository.load();

    final data = calculationPageRepository.obterDados();
    if (data.isNotEmpty) {
      setState(() {
        calculationModel = data.first;
        nameController.text = calculationModel.name ?? "";
        ageController.text = calculationModel.age.toString();
        heightController.text = calculationModel.height.toString();
        weightController.text = calculationModel.weight.toString();
      });
    }
    setState(() {
      nameController.text = "";
      ageController.text = "";
      heightController.text = "";
      weightController.text = "";
      resultadoAvaliacao = "";
    });
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
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 100, 128, 169),
          title: const Text(
            'DIO - CALCULE SEU IMC',
          ),
        ),
        body: SingleChildScrollView(
            child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
            minWidth: MediaQuery.of(context).size.width,
          ),
          child: Column(children: [
            const SizedBox(height: 32),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text("Insira os dados abaixo:",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 100, 128, 169),
                  )),
            ),
            const SizedBox(height: 32),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 6,
                      ),
                      labelText: 'Nome',
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: ageController,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 6,
                      ),
                      labelText: 'Idade',
                      prefixIcon: Icon(Icons.battery_5_bar_rounded),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: heightController,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 6,
                      ),
                      labelText: 'Altura',
                      prefixIcon: Icon(Icons.stairs_outlined),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: weightController,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 8,
                      ),
                      labelText: 'Peso',
                      prefixIcon: Icon(Icons.balance),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 80),
            TextButton(
              onPressed: () async {
                if (nameController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Insira o seu nome.')),
                  );
                  return;
                }
                if (ageController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Insira a sua idade.')),
                  );
                  return;
                }
                if (heightController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Insira a sua altura.')),
                  );
                  return;
                }
                if (weightController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Insira o seu peso.')),
                  );
                  return;
                }

                double imc = double.parse(weightController.text) / (double.parse(heightController.text) * double.parse(heightController.text));

                if (imc < 16) {
                  resultadoAvaliacao = "Magreza grave";
                } else if (imc >= 16 && imc < 17) {
                  resultadoAvaliacao = "Magreza moderada";
                } else if (imc >= 17 && imc < 18.5) {
                  resultadoAvaliacao = "Magreza Leve";
                } else if (imc >= 18.5 && imc < 25) {
                  resultadoAvaliacao = "Saudável";
                } else if (imc >= 25 && imc < 30) {
                  resultadoAvaliacao = "Sobrepeso";
                } else if (imc >= 30 && imc <= 35) {
                  resultadoAvaliacao = "Obesidade grau 1";
                } else if (imc >= 35 && imc <= 40) {
                  resultadoAvaliacao = "Obesidade grau 2";
                } else if (imc >= 40) {
                  resultadoAvaliacao = "Obesidade grau 3";
                }

                final result = CalculationModel.create(nameController.text, int.parse(ageController.text), double.parse(weightController.text),
                    double.parse(heightController.text), imc, resultadoAvaliacao, DateTime.now());

                await calculationPageRepository.save(result);

                results.add(result);

                setState(() {
                  calculationModel = result;
                  nameController.text = "";
                  ageController.text = "";
                  heightController.text = "";
                  weightController.text = "";
                  resultadoAvaliacao = "";
                });

                Future.delayed(const Duration(milliseconds: 2), () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ResultPage(results: results);
                  }));
                });
              },
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.symmetric(horizontal: 150, vertical: 8)),
                shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 100, 128, 169)),
                foregroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 255, 255, 255)),
              ),
              child: const Text('CALCULAR', style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 252, 252, 252), fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 10),
            TextButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.symmetric(horizontal: 150, vertical: 8)),
                shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 100, 128, 169)),
                foregroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 255, 255, 255)),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ResultPage(results: results);
                }));
              },
              child: const Text("Resultados", style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 252, 252, 252), fontWeight: FontWeight.bold)),
            ),
          ]),
        )),
      ),
    );
  }
}
