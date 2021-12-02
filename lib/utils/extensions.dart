
extension BoolParsing on String {
  bool parseBool() {
    if (toLowerCase() == 'true') {
      return true;
    } else if (toLowerCase() == 'false') {
      return false;
    }

    throw '"$this" can not be parsed to boolean.';
  }
}

extension IntToDouble on double{
  int parseInt() {
    double multiplier = .5;
    return (multiplier * this).round();
  }
}