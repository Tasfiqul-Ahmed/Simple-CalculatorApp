import 'package:flutter/material.dart';
import 'package:myapp/buttons.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var userQuestion = '';
  var userAnswer = '';

  final List buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    'x',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    '.',
    'ANS',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.deepPurple[100],
        body: Column(
          children: [
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(height: 50),
                Container(
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      userQuestion,
                      style: const TextStyle(fontSize: 20),
                    )),
                Container(
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(
                      userAnswer,
                      style: const TextStyle(fontSize: 20),
                    ))
              ],
            )),
            Expanded(
                flex: 2,
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                    ),
                    itemCount: buttons.length,
                    itemBuilder: (BuildContext context, int index) {
                      // Suggested code may be subject to a license. Learn more: ~LicenseLog:2316959020.
                      if (index == 0) {
                        return MyButton(
                          buttonPressed: () {
                            setState(() {
                              userQuestion = '';
                              userAnswer = '';
                            });
                          },
                          buttonText: buttons[index],
                          color: Colors.green,
                          textColor: Colors.white,
                        );
                      } else if (index == 1) {
                        return MyButton(
                          buttonPressed: () {
                            setState(() {
                              userQuestion = userQuestion.substring(
                                  0, userQuestion.length - 1);
                            });
                          },
                          buttonText: buttons[index],
                          color: Colors.red,
                          textColor: Colors.white,
                        );
                      } else if (index == buttons.length - 1) {
                        return MyButton(
                          buttonPressed: () {
                            setState(() {
                              equalPressed();
                            });
                          },
                          buttonText: buttons[index],
                          color: Colors.deepPurple,
                          textColor: Colors.white,
                        );
                      } else {
                        return MyButton(
                          buttonPressed: () {
                            setState(() {
                              userQuestion += buttons[index];
                            });
                          },
                          color: isOperated(buttons[index])
                              ? Colors.deepPurple
                              : Colors.deepPurple[50],
                          textColor: isOperated(buttons[index])
                              ? Colors.white
                              : Colors.deepPurple,
                          buttonText: buttons[index],
                        );
                      }
                    })),
          ],
        ),
      ),
    );
  }

  bool isOperated(String x) {
    if (x == '%' || x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  void equalPressed() {
    if (userQuestion.contains('/0')) {
      userAnswer = 'Error';
      return;
    } else if (userQuestion.contains('++') ||
        userQuestion.contains('+-') ||
        userQuestion.contains('+/') ||
        userQuestion.contains('+%') ||
        userQuestion.contains('+x') ||
        userQuestion.contains('+.') ||
        userQuestion.contains('--') ||
        userQuestion.contains('-+') ||
        userQuestion.contains('-.') ||
        userQuestion.contains('-/') ||
        userQuestion.contains('-%') ||
        userQuestion.contains('-x') ||
        userQuestion.contains('xx') ||
        userQuestion.contains('x/') ||
        userQuestion.contains('x.') ||
        userQuestion.contains('x-') ||
        userQuestion.contains('x%') ||
        userQuestion.contains('x+') ||
        userQuestion.contains('%%') ||
        userQuestion.contains('%+') ||
        userQuestion.contains('%-') ||
        userQuestion.contains('%/') ||
        userQuestion.contains('%x') ||
        userQuestion.contains('%.') ||
        userQuestion.contains('//') ||
        userQuestion.contains('/+') ||
        userQuestion.contains('/-') ||
        userQuestion.contains('/%') ||
        userQuestion.contains('/x') ||
        userQuestion.contains('/.') ||
        userQuestion.endsWith('+') ||
        userQuestion.endsWith('-') ||
        userQuestion.endsWith('x') ||
        userQuestion.endsWith('/') ||
        userQuestion.endsWith('%')){
      userAnswer = 'Error';
      return;
    }  else {
      String finalQuestion = userQuestion;
      finalQuestion = finalQuestion.replaceAll('x', '*');

      Parser p = Parser();
      Expression exp = p.parse(finalQuestion);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);

      userAnswer = eval.toString();
    }
  }
}
