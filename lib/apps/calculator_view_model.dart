import 'package:calculator_app/Utils/extensions.dart';
import 'package:flutter/material.dart';

class CalculatorChangeNotifier extends ChangeNotifier {
  // Variable list for all buttons in calculator
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
  // Current text display
  String currentStringValue = '';

  // Mathematical operation
  OperationalType? currentOperation;

  // Variable to store first operand when performing mathematical operation
  double? firstOperand;

  // Checker for a button if mathematical operation or not// for button colors
  bool isOperational(String value) {
    return OperationalType.values.map((e) => e.stringValue).contains(value);
  }

  // Method to handle other func such as percentage, inverse sign, clear one and delete all
  void performOtherFunc(String value) {
    double? doubleValue = double.tryParse(currentStringValue);

    // Conditions to handle othe functions
    if (value == OtherFuncType.deleteAll.stringValue) {
      currentStringValue = '';
      currentOperation = null;
      firstOperand = null;
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
  }

  // Method to reload UI on butto tap
  void reloadState(String value) {
    OperationalType? operation = OperationalTypeExt.init(value);

    // Perform other function if applicable
    performOtherFunc(value);

    if (value == '=') {
      // On equal button tapped with perform current operation
      currentStringValue =
          performOperation(double.tryParse(currentStringValue));
      notifyListeners();
    } else if (operation != null) {
      // to store tapped operation and first operand
      currentOperation = operation;
      if (firstOperand == null) {
        firstOperand = double.tryParse(currentStringValue) ?? 0;
        currentStringValue = '';
      }
    } else {
      // Handle numbers and decimal point inputs
      if (double.tryParse(value) != null || value == '.') {
        if (currentStringValue == '' && value == '.') {
          currentStringValue = '0.';
        } else {
          if (!(value == '.' && currentStringValue.contains('.'))) {
            currentStringValue = (currentStringValue == '0' && value != '.')
                ? value
                : (currentStringValue + value);
          }
        }
      }

      notifyListeners();
    }
  }

  // method to execute current operation
  String performOperation(double? value) {
    String result = '';
    if (currentOperation == OperationalType.add) {
      result =
          (firstOperand! + (value ?? firstOperand)!).toStringWithNoZeroes();
    } else if (currentOperation == OperationalType.substract) {
      result =
          (firstOperand! - (value ?? firstOperand)!).toStringWithNoZeroes();
    } else if (currentOperation == OperationalType.multiply) {
      result =
          (firstOperand! * (value ?? firstOperand)!).toStringWithNoZeroes();
    } else {
      result =
          (firstOperand! / (value ?? firstOperand)!).toStringWithNoZeroes();
    }

    firstOperand = null;
    currentOperation = null;

    return result;
  }
}
