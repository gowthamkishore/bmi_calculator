import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double? bmiValue;
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  final BoxDecoration boxDecoration = BoxDecoration(
      color: Colors.grey[900],
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      boxShadow: const [
        BoxShadow(color: Colors.black38, offset: Offset(5, 5), blurRadius: 10),
        BoxShadow(color: Colors.white12, offset: Offset(-5, -5), blurRadius: 10)
      ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(33, 33, 33, 1),
      body: SafeArea(
          child: SizedBox(
        width: double.infinity,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "BMI CALCULATOR",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 42,
                ),
              ),
              Container(
                width: 360,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(8.0),
                child: bmiValue == null ? buildInputUi() : buildOutputUi(),
              ),
            ]),
      )),
    );
  }

  Widget buildInputUi() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 50,
          decoration: boxDecoration,
          child: TextField(
            cursorColor: Colors.white60,
            style: const TextStyle(color: Colors.white70),
            controller: heightController,
            decoration: const InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide.none),
                hintText: "Height in cm",
                hintStyle: TextStyle(color: Colors.white24)),
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        Container(
          height: 50,
          decoration: boxDecoration,
          child: TextField(
            cursorColor: Colors.white60,
            style: const TextStyle(color: Colors.white70),
            controller: weightController,
            decoration: const InputDecoration(
                hintText: 'Weight in Kg',
                border: OutlineInputBorder(borderSide: BorderSide.none),
                hintStyle: TextStyle(color: Colors.white24)),
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        Container(
          decoration: boxDecoration,
          child: MaterialButton(
            height: 60,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            minWidth: double.infinity,
            onPressed: calculateBMI,
            child: Text(
              "CALCULATE BMI",
              style: TextStyle(
                  color: Colors.green[200],
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
  }

  Widget buildOutputUi() {
    double indicatorValue = bmiValue!;
    if (indicatorValue >= 30.0) {
      indicatorValue = 29.99;
    } else if (indicatorValue <= 18.5) {
      indicatorValue = 18.6;
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: double.infinity,
          height: 50,
          alignment: Alignment.center,
          decoration: boxDecoration,
          child: Text(
            "BMI : ${bmiValue!.toStringAsFixed(1)}",
            style: TextStyle(color: Colors.white70, fontSize: 28),
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        Container(
          height: 50,
          decoration: boxDecoration,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(colors: [
                  Colors.lightBlue.withOpacity(0.75),
                  Colors.green.withOpacity(0.75),
                  Colors.yellow.withOpacity(0.75),
                  Colors.red.withOpacity(0.75)
                ])),
            child: LinearPercentIndicator(
              barRadius: Radius.circular(10),
              lineHeight: 12,
              linearGradient:
                  LinearGradient(colors: [Colors.purple, Colors.purple[300]!]),
              animation: true,
              percent: ((indicatorValue - 18.5) * 8.70 / 100),
            ),
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        Container(
          decoration: boxDecoration,
          child: MaterialButton(
            height: 60,
            shape: const RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            minWidth: double.infinity,
            onPressed: checkAnother,
            child: Text(
              "CHECK ANOTHER",
              style: TextStyle(
                  color: Colors.green[200],
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
  }

  void calculateBMI() {
    //bmi =  Formula: weight (kg) / [height (m)]^2
    try {
      double h = double.tryParse(heightController.text)! / 100;
      double w = double.tryParse(weightController.text)!;

      setState(() {
        bmiValue = w / (h * h);
      });
    } catch (e) {
      showDialog(
          context: context,
          builder: (_) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              backgroundColor: Colors.grey[900],
              child: Container(
                  padding: EdgeInsets.all(25),
                  child: const Text(
                    "Invalid values for height or weight",
                    style: TextStyle(color: Colors.redAccent, fontSize: 18),
                  )),
            );
          });
    }
  }

  void checkAnother() {
    setState(() {
      heightController.text = "";
      weightController.text = "";
      bmiValue = null;
    });
  }
}
