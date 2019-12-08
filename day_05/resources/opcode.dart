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
   * 5 - Jump to addr at param2 if param1 is not zero
   * 6 - Jump to addr at param2 if param1 is zero
   * 7 - If param1 < param2, store 1 in addr at param3, else 0
   * 8 - If param1 == param2, store 1 in addr at param3, else 0
   * 99 - Terminate program
   */
  final List<int> _validInstructions = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    99
  ];
  final Map<int, int> _operantParamCounts = {
    1: 3,
    2: 3,
    3: 1,
    4: 1,
    5: 2,
    6: 2,
    7: 3,
    8: 3
  };
  Map<int, int> get paramCounts => _operantParamCounts;
  int params;
  final Map<int, List<List<int>>> _instructionParamAllowedModes = {
    1: [
      [0,1],
      [0,1],
      [0]
    ],
    2: [
      [0,1],
      [0,1],
      [0]
    ],
    3: [
      [0]
    ],
    4: [
      [0,1]
    ],
    5: [
      [0,1],
      [0,1]
    ],
    6: [
      [0,1],
      [0,1]
    ],
    7: [
      [0,1],
      [0,1],
      [0]
    ],
    8: [
      [0,1],
      [0,1],
      [0]
    ]
  };

  Opcode(int inputCode) {
    String code = inputCode.toString();
    if (code.length == 1) {
      _instruction = int.parse(code);
    } else {
      _instruction = int.parse(code.substring(code.length-2, code.length));
    }

    if (!_validInstructions.contains(_instruction)) {
      throw OpcodeException('Invalid opcode ${inputCode}');
    }

    if (_instruction != 99) {
      params = _operantParamCounts[_instruction];

      code = code.padLeft(params+2, '0');

      _parameterModes = [];
      for (int ii = params - 1; ii >= 0; ii--) {
        _parameterModes.add(
          int.parse(code.substring(ii, ii+1))
        );
      }

      List<List<int>> allowedModes = _instructionParamAllowedModes[_instruction];

      for (int ii = 0; ii < _parameterModes.length; ii++) {
        if(!allowedModes[ii].contains(_parameterModes[ii])) {
          throw OpcodeException('Opcode created with invalid mode ${_parameterModes[ii]} for instruction ${_instruction}.');
        }
      }
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