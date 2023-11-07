import 'package:calculator_prj/componenets/my%20buttons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorMain extends StatefulWidget {
  const CalculatorMain({super.key});

  @override
  State<CalculatorMain> createState() => _CalculatorMainState();
}

class _CalculatorMainState extends State<CalculatorMain> {
  var userinput = "";
  var useroutput = "";
  final List button = [
    "C",
    'DEL',
    "%",
    "/",
    "9",
    "8",
    "7",
    "x",
    "6",
    "5",
    "4",
    "-",
    "3",
    "2",
    "1",
    "+",
    "0",
    ".",
    "ANS",
    "="
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
              child: Container(
                width: double.infinity,
                color: Colors.green.shade200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            userinput,
                            style: const TextStyle(fontSize: 20),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            useroutput,
                            style: const TextStyle(fontSize: 20),
                          )),
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 2,
              child: Container(
                  color: Colors.green.shade200,
                  child: GridView.builder(
                      itemCount: button.length,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4),
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return MyBottons(
                              bottonpressed: () {
                                setState(() {
                                  userinput = "";
                                });
                              },
                              bgcolor: Colors.green,
                              txt: button[index],
                              txtcolor: Colors.white);
                        } else if (index == 1) {
                          return MyBottons(
                              bottonpressed: () {
                                setState(() {
                                  userinput = userinput.substring(
                                      0, userinput.length - 1);
                                });
                              },
                              bgcolor: Colors.pink.shade600,
                              txt: button[index],
                              txtcolor: Colors.white);
                        } else if (index==button.length-1) {
                          return MyBottons(bottonpressed: (){
                            setState(() {
                              equalOperation();
                            });
                          },
                              bgcolor: Colors.green.shade900,
                              txt: button[index],
                              txtcolor: Colors.white);
                        }

                        else {
                          return MyBottons(
                              bottonpressed: () {
                                setState(() {
                                  userinput = userinput + button[index];
                                });
                              },
                              bgcolor: customButtonColor(button[index])
                                  ? Colors.green.shade900
                                  : Colors.lightGreen.shade700,
                              txt: button[index],
                              txtcolor: Colors.white);
                        }
                      })))
        ],
      ),
    );
  }

  bool customButtonColor(String a) {
    if (a == "%" || a == "/" || a == "x" || a == "-" || a == "+" || a == "=") {
      return true;
    }
    return false;
  }

 void equalOperation() {
    String finalquestion=userinput;
finalquestion=finalquestion.replaceAll('x', '*');
   Parser p = Parser();
   Expression exp = p.parse(finalquestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    useroutput =eval.toString();
 }
}
