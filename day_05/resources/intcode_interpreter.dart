import './intcode.dart';
import './opcode.dart';
import './intcode_errors.dart';

class IntcodeInterpreter {
  List<int> memory;

  int stdout;
  List<int> stdoutHistory;

  int _instructionPointer;

  IntcodeInterpreter() {
    stdoutHistory = [];
  }

  /**
   * Returns the address index defined by the value
   * at the given intcode [address].
   */
  int parseAddress(int address) => memory[address];

  /**
   * Perform the addition function triggered by opcode 1.
   * 
   * Adds the values found at the next two positions and
   * writes the sum to the third position, then advances
   * the cursor to the next opcode.
   */
  void _opcodeAdd(int mode) {
    // Check indexes and validate
    List<int> positions = [
      _instructionPointer + 1,
      _instructionPointer + 2,
      _instructionPointer + 3
    ];
    positions.forEach((cursorPos) => _validatePosition(cursorPos));

    // Perform the addition and write to given position
    int addendOne = memory[parseAddress(positions[0])];
    int addendTwo = memory[parseAddress(positions[1])];
    memory[parseAddress(positions[2])] = addendOne + addendTwo;

    // Step cursor to next opcode
    _instructionPointer += 4;
  }

  /**
   * Perform the multiplication function triggered by opcode 2.
   * 
   * Multiplies the values found at the next two positions and
   * writes the product to the third position, then advances
   * the cursor the the next opcode.
   */
  void _opcodeMultiply(int mode) {
    // Check indexes and validate
    List<int> positions = [
      _instructionPointer + 1,
      _instructionPointer + 2,
      _instructionPointer + 3
    ];
    positions.forEach((cursorPos) => _validatePosition(cursorPos));

    // Perform the multiplication and write to given position
    int factorOne = memory[parseAddress(positions[0])];
    int factorTwo = memory[parseAddress(positions[1])];
    memory[parseAddress(positions[2])] = factorOne * factorTwo;

    // Step cursor to next opcode
    _instructionPointer += 4;
  }

  void _opcodeStore(int mode) {
    //
  }

  void _opcodeOutput(int mode) {
    //
  }

  /**
   * For the given [cursorAddress], validate that the index exists in
   * the instance's [memory] and that the position information stored
   * in that index is also a valid index in the instance's intcode
   */
  void _validatePosition(int cursorAddress) {
    if (cursorAddress >= memory.length || cursorAddress < 0) {
      throw IntcodePositionInvalidException(
        'Attempt to read position at cursor position ${cursorAddress} failed - ' +
        '${cursorAddress} is not a valid index for memory.'
      );
    }
    int position = memory[cursorAddress];
    if (position >= memory.length || position < 0) {
      throw IntcodePositionInvalidException(
        'Position index ${position} invalid - called at cursor position ${cursorAddress}'
        );
    }
  }

  Intcode run(Intcode intcode) {

    // Intcode that has parsed will almost certainly contain
    // invalid opcodes, so this function should only ever be
    // called once.
    if (intcode.hasRun) {
      throw IntcodeRuntimeError(
        'Intcode has already run once.  Call IntcodeInterpreter.reset if intending ' +
        'to re-run the initial intcode'
      );
    }
    _instructionPointer = 0;
    bool cleanExit = false;

    execution: while (_instructionPointer < memory.length) {
      // parse the thing
      int opcode = memory[_instructionPointer];
      int mode = (opcode / 1000).floor();
      int instruction = opcode % 1000;
      switch (instruction) {
        case 1:
          _opcodeAdd(mode);
          break;
        case 2:
          _opcodeMultiply(mode);
          break;
        case 3:
          _opcodeStore(mode);
          break;
        case 4:
          _opcodeOutput(mode);
          break;
        case 99:
          cleanExit = true;
          break execution;
        default:
          throw OpcodeException(
            'Invalid opcode ${memory[_instructionPointer]} at position ${_instructionPointer}'
          );
      }
    }

    if (!cleanExit) {
      throw IntcodeInterpretationException('Intcode parsed to end with no exit opcode');
    }

    intcode.update(memory);
    Intcode output = new Intcode(memory.join(','), hasRun: true);
    reset();

    return output;
  }

  void reset() {
    memory = null;
  }

  void output(int val) {
    stdout = val;
    stdoutHistory.add(val);
  }
}
