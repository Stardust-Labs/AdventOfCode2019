import './intcode_errors.dart';

class Opcode {
  int _instruction;
  int get instruction => _instruction;
  List<int> _parameterModes;
  List<int> get parameterModes => _parameterModes;

  /**
   * Instructions are:
   * 1 - Add the values in param1 and param2 and move the sum to param3
   * 2 - Multiply the values in param1 and param2 and move the product to param3
   * 3 - Move input value to param1
   * 4 - Output value at param1
   * 99 - Terminate program
   */
  final List<int> _validInstructions = [
    1,
    2,
    3,
    4,
    99
  ];
  final Map<int, int> _operantParamCounts = {
    1: 3,
    2: 3,
    3: 1,
    4: 1
  };
  Map<int, int> get paramCounts => _operantParamCounts;
  int params;

  Opcode(int inputCode) {
    String code = inputCode.toString();
    _instruction = int.parse(code.substring(code.length-2, code.length));

    if (!_validInstructions.contains(_instruction)) {
      throw OpcodeException('Invalid opcode ${inputCode}');
    }

    params = _operantParamCounts[_instruction];

    code = code.padLeft(params+2, '0');

    for (int ii = params; ii > 0; ii--) {
      _parameterModes.add(
        int.parse(code.substring(ii, ii+1))
      );
    }
  }
}

/**
 * Defines a parameter for easier passing between methods.
 */
class Parameter {
  int mode;
  int address;

  /**
   * Valid modes are:
   * 0 - Position Mode (Value represents an address in memory)
   * 1 - Immediate Mode (Value is the value to be used)
   */
  final List<int> _validModes = [
    0,
    1
  ];

  Parameter(this.mode, this.address) {
    if (!_validModes.contains(mode)) throw IntcodeRuntimeError('Invalid mode');
  }
}