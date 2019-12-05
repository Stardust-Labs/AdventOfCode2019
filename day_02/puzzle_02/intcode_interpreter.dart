class IntcodeInterpreter {
  List<int> initialIntcode;
  List<int> intcode;

  int _cursorPosition;
  bool _hasRun;

  IntcodeInterpreter(String input) {
    List<String> intvals = input.split(',');
    _hasRun = false;

    initialIntcode = [];
    intvals.forEach((intval) => initialIntcode.add(int.parse(intval)));
    intcode = List.from(initialIntcode);
  }

  /**
   * Returns the position index defined by the value
   * at the given intcode [position].
   */
  int parsePosition(int position) => intcode[position];

  /**
   * Perform the addition function triggered by opcode 1.
   * 
   * Adds the values found at the next two positions and
   * writes the sum to the third position, then advances
   * the cursor to the next opcode.
   */
  void _opcodeAdd() {
    // Check indexes and validate
    List<int> positions = [
      _cursorPosition + 1,
      _cursorPosition + 2,
      _cursorPosition + 3
    ];
    positions.forEach((cursorPos) => _validatePosition(cursorPos));

    // Perform the addition and write to given position
    int addendOne = intcode[parsePosition(positions[0])];
    int addendTwo = intcode[parsePosition(positions[1])];
    intcode[parsePosition(positions[2])] = addendOne + addendTwo;

    // Step cursor to next opcode
    _cursorPosition += 4;
  }

  /**
   * Perform the multiplication function triggered by opcode 2.
   * 
   * Multiplies the values found at the next two positions and
   * writes the product to the third position, then advances
   * the cursor the the next opcode.
   */
  void _opcodeMultiply() {
    // Check indexes and validate
    List<int> positions = [
      _cursorPosition + 1,
      _cursorPosition + 2,
      _cursorPosition + 3
    ];
    positions.forEach((cursorPos) => _validatePosition(cursorPos));

    // Perform the multiplication and write to given position
    int factorOne = intcode[parsePosition(positions[0])];
    int factorTwo = intcode[parsePosition(positions[1])];
    intcode[parsePosition(positions[2])] = factorOne * factorTwo;

    // Step cursor to next opcode
    _cursorPosition += 4;
  }

  /**
   * For the given [cursorIndex], validate that the index exists in
   * the instance's [intcode] and that the position information stored
   * in that index is also a valid index in the instance's intcode
   */
  void _validatePosition(int cursorIndex) {
    if (cursorIndex >= intcode.length || cursorIndex < 0) {
      throw IntcodePositionInvalidException(
        'Attempt to read position at cursor position ${cursorIndex} failed - ' +
        '${cursorIndex} is not a valid index for intcode.'
      );
    }
    int position = intcode[cursorIndex];
    if (position >= intcode.length || position < 0) {
      throw IntcodePositionInvalidException(
        'Position index ${position} invalid - called at cursor position ${cursorIndex}'
        );
    }
  }

  void run() {

    // Intcode that has parsed will almost certainly contain
    // invalid opcodes, so this function should only ever be
    // called once.
    if (_hasRun) {
      throw IntcodeRuntimeError(
        'Intcode has already run once.  Call IntcodeInterpreter.reset if intending ' +
        'to re-run the initial intcode'
      );
    }
    _cursorPosition = 0;
    bool cleanExit = false;

    execution: while (_cursorPosition < intcode.length) {
      // parse the thing
      int opcode = intcode[_cursorPosition];
      switch (opcode) {
        case 1:
          _opcodeAdd();
          break;
        case 2:
          _opcodeMultiply();
          break;
        case 99:
          cleanExit = true;
          break execution;
        default:
          throw OpcodeException(
            'Invalid opcode ${intcode[_cursorPosition]} at position ${_cursorPosition}'
          );
      }
    }

    if (!cleanExit) {
      throw IntcodeInterpretationException('Intcode parsed to end with no exit opcode');
    }

    _hasRun = true;
  }

  void reset() {
    _hasRun = false;
    intcode = List.from(initialIntcode);
  }
}

class IntcodeInterpretationException implements Exception {
  String message;
  IntcodeInterpretationException(this.message);
}

class IntcodePositionInvalidException implements Exception {
  String message;
  IntcodePositionInvalidException(this.message);
}

class IntcodeRuntimeError extends Error {
  String message;
  IntcodeRuntimeError(this.message);
}

class OpcodeException implements Exception {
  String message;
  OpcodeException(this.message);
}
