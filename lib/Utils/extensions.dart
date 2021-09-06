// Enum cases for mathematical operations
enum OperationalType { add, substract, multiply, divide }

// Enum cases for other functions
enum OtherFuncType { deleteOne, deleteAll, inverseSign, percent }

// Extension for OperationalType with computed variables
extension OperationalTypeExt on OperationalType {
  // String value of each mathematical operations
  String get stringValue {
    switch (this) {
      case OperationalType.add:
        return '+';
      case OperationalType.substract:
        return '-';
      case OperationalType.multiply:
        return 'x';
      case OperationalType.divide:
        return '/';
    }
  }

  // Static method to initialize OperationalType by string
  static OperationalType? init(String value) {
    if (value == OperationalType.add.stringValue) {
      return OperationalType.add;
    } else if (value == OperationalType.substract.stringValue) {
      return OperationalType.substract;
    } else if (value == OperationalType.multiply.stringValue) {
      return OperationalType.multiply;
    } else if (value == OperationalType.divide.stringValue) {
      return OperationalType.divide;
    } else {
      return null;
    }
  }
}

// Extension for OtherFuncType with computed variables
extension OtherFuncTypeExt on OtherFuncType {
  String get stringValue {
    switch (this) {
      case OtherFuncType.deleteOne:
        return 'C';
      case OtherFuncType.deleteAll:
        return 'DEL';
      case OtherFuncType.inverseSign:
        return '+/-';
      case OtherFuncType.percent:
        return '%';
    }
  }
}

// Double extension to format doubles with trailing zeroes.
extension DoubleExt on double {
  String toStringWithNoZeroes() {
    return toString().replaceAll(RegExp(r"([.]*0)(?!.*\d)"), "");
  }
}
