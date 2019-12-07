class Intcode {
  List<int> initialCode;
  List<int> code;

  bool _hasRun;
  bool get hasRun => _hasRun;

  Intcode(String input, {hasRun=false}) {
    List<String> intvals = input.split(',');
    _hasRun = hasRun;

    initialCode = [];
    intvals.forEach((intval) => initialCode.add(int.parse(intval)));
    code = List.from(initialCode);
  }

  void update(List<int> newCode) {
    code = List.from(newCode);
    _hasRun = true;
  }
}