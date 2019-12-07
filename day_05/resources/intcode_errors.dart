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
