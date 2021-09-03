enum OperationalType { add, substract, multiply, divide, equal }
enum OtherFuncType { deleteOne, deleteAll, inverseSign, percent }

extension OperationalTypeExt on OperationalType {
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
      case OperationalType.equal:
        return '=';
    }
  }

  static OperationalType? init(String value) {
    if (value == OperationalType.add.stringValue) {
      return OperationalType.add;
    } else if (value == OperationalType.substract.stringValue) {
      return OperationalType.substract;
    } else if (value == OperationalType.multiply.stringValue) {
      return OperationalType.multiply;
    } else if (value == OperationalType.divide.stringValue) {
      return OperationalType.divide;
    } else if (value == OperationalType.equal.stringValue) {
      return OperationalType.equal;
    } else {
      return null;
    }
  }
}

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

extension DoubleExt on double {
  String toStringWithNoZeroes() {
    return toString().replaceAll(RegExp(r"([.]*0)(?!.*\d)"), "");
  }
}
