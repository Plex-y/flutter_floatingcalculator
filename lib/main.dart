import 'package:calculator/expandable/expand.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({this.title = ''});

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String output = "0";

  String _output = "0";
  double num1 = 0.0;
  double num2 = 0.0;
  String operand = "";

  buttonPressed(String buttonText) {
    if (buttonText == "CLEAR") {
      _output = "0";
      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } else if (buttonText == "+" ||
        buttonText == "-" ||
        buttonText == "÷" ||
        buttonText == "X") {
      num1 = double.parse(output);

      operand = buttonText;

      _output = "0";
    } else if (buttonText == ".") {
      if (_output.contains(".")) {
        print("Already conatains a decimals");
        return;
      } else {
        _output = _output + buttonText;
      }
    } else if (buttonText == "=") {
      num2 = double.parse(output);

      if (operand == "+") {
        _output = (num1 + num2).toString();
      }
      if (operand == "-") {
        _output = (num1 - num2).toString();
      }
      if (operand == "X") {
        _output = (num1 * num2).toString();
      }
      if (operand == "÷") {
        _output = (num1 / num2).toString();
      }

      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } else {
      _output = _output + buttonText;
    }

    print(_output);

    setState(() {
      output = double.parse(_output).toStringAsFixed(2);
    });
  }

  Widget buildButton(String buttonText) {
    return Expanded(
      child: TextButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blueGrey[200])),
        child: Text(
          buttonText,
          style: const TextStyle(
              fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        onPressed: () => buttonPressed(buttonText),
      ),
    );
  }

  Widget buildOperationButton(String buttonText) {
    return Expanded(
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: buttonText == '='
                ? MaterialStateProperty.all(Colors.greenAccent)
                : MaterialStateProperty.all(Colors.redAccent)),
        child: Text(
          buttonText,
          style: const TextStyle(
              fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        onPressed: () => buttonPressed(buttonText),
      ),
    );
  }

  Widget body() {
    return Column(
      children: <Widget>[
        Container(
            color: Colors.green[400],
            alignment: Alignment.centerRight,
            padding:
                const EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
            child: Text(output,
                style: const TextStyle(
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold,
                ))),
        const Expanded(
          child: Divider(),
        ),
        Column(children: [
          Row(children: [
            buildButton("7"),
            buildButton("8"),
            buildButton("9"),
            buildOperationButton("÷")
          ]),
          Row(children: [
            buildButton("4"),
            buildButton("5"),
            buildButton("6"),
            buildOperationButton("X")
          ]),
          Row(children: [
            buildButton("1"),
            buildButton("2"),
            buildButton("3"),
            buildOperationButton("-")
          ]),
          Row(children: [
            buildButton("."),
            buildButton("0"),
            buildButton("00"),
            buildOperationButton("+")
          ]),
          Row(children: [
            buildOperationButton("CLEAR"),
            buildOperationButton("="),
          ])
        ])
      ],
    );
  }

  Widget bodyCalc() {
    return Container(
      height: 250,
      width: 250,
      decoration: BoxDecoration(
          color: Colors.blueGrey,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(15)),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(15.0)),
        child: body(),
      ),
    );
  }

  Widget floatingB() {
    return FloatingActionButton(
      onPressed: () {},
      child: const Icon(Icons.abc),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(),
      floatingActionButton:
          ExpandableFab(distance: 112, children: [bodyCalc()]),
    );
  }
}
