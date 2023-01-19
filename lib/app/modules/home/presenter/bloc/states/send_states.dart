// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class SendStates {}

class InititalSend extends SendStates {}

class LoadingSend extends SendStates {}

class SuccessSend extends SendStates {}

class AllColetasAlreadyBeenSent extends SendStates {}

class ErrorSend extends SendStates {
  final String message;

  ErrorSend({
    required this.message,
  });
}
