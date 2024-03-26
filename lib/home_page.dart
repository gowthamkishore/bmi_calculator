import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double? bmiValue;
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bmiValue == null ? buildInputUi() : buildOutputUi(),
    );
  }

  Widget buildInputUi() {
    return Column(
      children: [
        TextField(
          controller: heightController,
          decoration: InputDecoration(hintText: "Height in cm"),
        ),
        TextField(
          controller: weightController,
          decoration: InputDecoration(hintText: 'Weight in Kg'),
        ),
        MaterialButton(
          color: Colors.greenAccent,
          onPressed: calculateBMI,
          child: Text("Calculate BMI"),
        )
      ],
    );
  }

  Widget buildOutputUi() {
    return Column(
      children: [
        Text("$bmiValue"),
        MaterialButton(
          color: Colors.greenAccent,
          onPressed: checkAnother,
          child: Text("Check Another"),
        )
      ],
    );
  }

  void calculateBMI() {
    //bmi =  Formula: weight (kg) / [height (m)]^2
    double h = double.tryParse(heightController.text)! / 100;
    double w = double.tryParse(weightController.text)!;

    setState(() {
      bmiValue = w / (h * h);
    });
  }

  void checkAnother() {
    setState(() {
      heightController.text = "";
      weightController.text = "";
      bmiValue = null;
    });
  }
}
