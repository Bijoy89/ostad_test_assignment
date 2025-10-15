import 'package:flutter/material.dart';
import 'package:flutter_calculator/widget/buildButton.dart';

class Calculator_App extends StatefulWidget {
  const Calculator_App({super.key});

  @override
  State<Calculator_App> createState() => _Calculator_AppState();
}

class _Calculator_AppState extends State<Calculator_App> {
  String _output='0';
  String _input='0';
  String _ope='';
  double num1=0;
  double num2=0;
  //String operand='';

  void buttonPress(String value){
    print("value ==$value");

    setState(() {
      if(value=='C'){
        _output = '0';
        _input='0';
        _ope='';
        num1=0;
        num2=0;
      }
      else if(value == "="){
        if(_ope.isNotEmpty && _input.isNotEmpty){
          num2=double.parse(_input);
          double result=0;
          switch(_ope){
            case '+':
              result=num1+num2;
              break;
            case '-':
              result=num1-num2;
              break;
            case '*':
              result=num1*num2;
              break;
            case '/':
              result=num2!=0 ? num1/num2:double.nan;
              break;


          }
          _output = result.isNaN ? 'Error' : result.toString();
          if (_output.endsWith('.0')) _output = _output.replaceAll('.0', '');
          _input = _output;
          _ope = '';
        }
      } else if (['+', '-', '*', '/'].contains(value)) {
        if (_input.isNotEmpty) {
          num1 = double.tryParse(_input) ?? 0;
          _ope = value;
          _input = '';
        }
      } else if (value == '.') {
        if (!_input.contains('.')) {
          _input += _input.isEmpty ? '0.' : '.';
          _output = _input;
        }
      } else {
        if (_input == '0' || _input.isEmpty) {
          _input = value;
        } else {
          _input += value;
        }
        _output = _input;
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                child: Text(
                      _output,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 80,
                      fontWeight: FontWeight.bold,
                    ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Row(
              children: [
                BuildButton(text: 'C', color: Colors.grey.shade400, textColor: Colors.black, onClick: () => buttonPress('C')),
                BuildButton(text: 'AC', color: Colors.grey.shade400, textColor: Colors.black, onClick: () {}),
                BuildButton(text: '%', color: Colors.grey.shade400, textColor: Colors.black, onClick: () {}),
                BuildButton(text: '/', color: Colors.orange, onClick: () => buttonPress('/')),
              ],
            ),
            Row(
              children: [
                BuildButton(text: '7', color: Colors.grey.shade800, onClick: () => buttonPress('7')),
                BuildButton(text: '8', color: Colors.grey.shade800, onClick: () => buttonPress('8')),
                BuildButton(text: '9', color: Colors.grey.shade800, onClick: () => buttonPress('9')),
                BuildButton(text: '*', color: Colors.orange, onClick: () => buttonPress('*')),
              ],
            ),
            Row(
              children: [
                BuildButton(text: '4', color: Colors.grey.shade800, onClick: () => buttonPress('4')),
                BuildButton(text: '5', color: Colors.grey.shade800, onClick: () => buttonPress('5')),
                BuildButton(text: '6', color: Colors.grey.shade800, onClick: () => buttonPress('6')),
                BuildButton(text: '-', color: Colors.orange, onClick: () => buttonPress('-')),
              ],
            ),
            Row(
              children: [
                BuildButton(text: '1', color: Colors.grey.shade800, onClick: () => buttonPress('1')),
                BuildButton(text: '2', color: Colors.grey.shade800, onClick: () => buttonPress('2')),
                BuildButton(text: '3', color: Colors.grey.shade800, onClick: () => buttonPress('3')),
                BuildButton(text: '+', color: Colors.orange, onClick: () => buttonPress('+')),
              ],
            ),
            Row(
              children: [
                BuildButton(text: '0', color: Colors.grey.shade800, flex: 2, onClick: () => buttonPress('0')),
                BuildButton(text: '.', color: Colors.grey.shade800, onClick: () => buttonPress('.')),
                BuildButton(text: '=', color: Colors.orange, onClick: () => buttonPress('=')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
