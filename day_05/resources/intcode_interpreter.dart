import './intcode.dart';
import './opcode.dart';
import './intcode_errors.dart';

class IntcodeInterpreter {
  List<int> memory;

  int stdin;
  List<int> stdinHistory;

  int stdout;
  List<int> stdoutHistory;

  int _instructionPointer;

  IntcodeInterpreter() {
    stdinHistory = [];
    stdoutHistory = [];
  }

  /**
   * Advances the Instruction Pointer to the next opcode after 
   * an opcode has been executed.
   */
  void advancePointer(Opcode opcode) => _instructionPointer += opcode.params + 1;

  /**
   * Returns the address index defined by the value
   * at the given intcode [address].
   */
  int parseAddress(int address) => memory[address];

  /**
   * Returns the value pointed to by a given [param],
   * accounting for parameter mode.
   */
  int parseValue(Parameter param) {
    if (param.mode == 0) {
      return memory[parseAddress(param.address)];
    } else if (param.mode == 1) {
      return memory[param.address];
    } else {
      throw IntcodeInterpretationException('Unsupported parameter mode.');
    }
  }

  /**
   * Perform the addition function triggered by opcode 1.
   * 
   * Adds the values found at the next two positions and
   * writes the sum to the third position, then advances
   * the cursor to the next opcode.
   */
  void _opcodeAdd(Opcode opcode) {
    // Check indexes and validate
    List<Parameter> parameters = [];
    for (int ii = 0; ii < opcode.params; ii++) {
      parameters.add(new Parameter(opcode.parameterModes[ii], _instructionPointer + ii + 1));
    }
    parameters.forEach((parameter) => _validatePosition(parameter.address));

    // Perform the addition and write to given position
    int addendOne = parseValue(parameters[0]);
    int addendTwo = parseValue(parameters[1]);

    if (parameters[2].mode != 0) {
      throw IntcodeInterpretationException('Immediate mode not supported for addition param 3');
    }
    memory[parseAddress(parameters[2].address)] = addendOne + addendTwo;

    advancePointer(opcode);
  }

  /**
   * Perform the multiplication function triggered by opcode 2.
   * 
   * Multiplies the values found at the next two positions and
   * writes the product to the third position, then advances
   * the cursor the the next opcode.
   */
  void _opcodeMultiply(Opcode opcode) {
    // Check indexes and validate
    List<Parameter> parameters = [];
    for (int ii = 0; ii < opcode.params; ii++) {
      parameters.add(new Parameter(opcode.parameterModes[ii], _instructionPointer + ii + 1));
    }
    parameters.forEach((parameter) => _validatePosition(parameter.address));

    // Perform the multiplication and write to given position
    int factorOne = parseValue(parameters[0]);
    int factorTwo = parseValue(parameters[1]);

    if (parameters[2].mode != 0) {
      throw IntcodeInterpretationException('Immediate mode not supported for multiplication param 3');
    }
    memory[parseAddress(parameters[2].address)] = factorOne * factorTwo;

    advancePointer(opcode);
  }

  /**
   * Stores the instruction's input in the memory address
   * define by the first intcode parameter.
   */
  void _opcodeStore(Opcode opcode) {
    if (stdin == null ) {
      throw IntcodeInterpretationException('Storage operation requires input.');
    }
    Parameter storageLocation = new Parameter(opcode.parameterModes[0], _instructionPointer + 1);
    if (storageLocation.mode != 0) {
      throw IntcodeInterpretationException('Immediate mode not supported for storage operation');
    }
    _validatePosition(storageLocation.address);
    memory[parseAddress(storageLocation.address)] = stdin;

    advancePointer(opcode);
  }

  /**
   * Outputs the value designated by the opcode's first parameter.
   */
  void _opcodeOutput(Opcode opcode) {
    Parameter output = new Parameter(opcode.parameterModes[0], _instructionPointer + 1);
    _validatePosition(output.address);
    stdout = parseValue(output);
    stdoutHistory.add(parseValue(output));

    advancePointer(opcode);
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

  Intcode run(Intcode intcode, {int input=null}) {

    if (input != null) {
      stdin = input;
      stdinHistory.add(input);
    }
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
      Opcode opcode = Opcode(memory[_instructionPointer]);
      switch (opcode.instruction) {
        case 1:
          _opcodeAdd(opcode);
          break;
        case 2:
          _opcodeMultiply(opcode);
          break;
        case 3:
          _opcodeStore(opcode);
          break;
        case 4:
          _opcodeOutput(opcode);
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
