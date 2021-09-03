import 'package:calculator_app/Utils/extensions.dart';
import 'package:flutter/material.dart';

class CalculatorChangeNotifier extends ChangeNotifier {
  List<String> keypads = [
    'C',
    '+/-',
    '%',
    'DEL',
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    'x',
    '1',
    '2',
    '3',
    '-',
    '0',
    '.',
    '=',
    '+'
  ];

  String currentStringValue = '';
  OperationalType? currentOperation;

  bool isOperational(String value) {
    return OperationalType.values.map((e) => e.stringValue).contains(value);
  }

  void executeOtherFunc(String value) {
    double? doubleValue = double.tryParse(currentStringValue);

    if (value == OtherFuncType.deleteAll.stringValue) {
      currentStringValue = '';
    } else if (value == OtherFuncType.deleteOne.stringValue) {
      if (currentStringValue != '') {
        currentStringValue =
            currentStringValue.substring(0, currentStringValue.length - 1);
      }
    } else if (value == OtherFuncType.inverseSign.stringValue) {
      currentStringValue = ((doubleValue ?? 0) * -1).toStringWithNoZeroes();
    } else if (value == OtherFuncType.percent.stringValue) {
      currentStringValue = ((doubleValue ?? 0) / 100).toStringWithNoZeroes();
    }

    notifyListeners();
  }

  void reloadState(String value) {
    double? doubleValue = double.tryParse(value);

    if (doubleValue != null || value == ".") {
      if (currentStringValue == '' && value == '.') {
        currentStringValue = '0.';
      } else {
        currentStringValue += value;
      }
    } else {
      currentOperation = OperationalTypeExt.init(value);
    }

    executeOtherFunc(value);

    notifyListeners();
  }

  void executeOperatio(String value) {
    if (currentOperation == OperationalType.add) {}
  }
}
