abstract class Failure {
  /// ignore: avoid_unused_constructor_parameters
  const Failure([List properties = const <dynamic>[]]);
}

class ServerFailure extends Failure {
  final String? message;

  const ServerFailure(this.message);

  @override
  bool operator ==(Object other) =>
      other is ServerFailure && other.message == message;

  @override
  int get hashCode => message.hashCode;
}

class NoDataFailure extends Failure {
  @override
  bool operator ==(Object other) => other is NoDataFailure;

  @override
  int get hashCode => 0;
}

class CacheFailure extends Failure {
  @override
  bool operator ==(Object other) => other is CacheFailure;

  @override
  int get hashCode => 0;
}

class DeleteUserFailure extends Failure {
  final String code;
  final String message;

  DeleteUserFailure(this.code)
      : message = _mapErrorCodeToMessage(code),
        super([code]);

  static String _mapErrorCodeToMessage(String code) {
    switch (code) {
      case 'user-not-found':
        return 'Utente non trovato.';
      case 'wrong-password':
        return 'Password errata.';
      case 'requires-recent-login':
        return 'L\'utente deve rieffettuare il login recente.';
      default:
        return 'Errore sconosciuto: $code';
    }
  }
}

class ResetEmailFailure extends Failure {
  final String code;
  final String message;

  ResetEmailFailure(this.code)
      : message = _mapErrorCodeToMessage(code),
        super([code]);

  static String _mapErrorCodeToMessage(String code) {
    switch (code) {
      case 'invalid-email':
        return 'Email non valida.';
      case 'user-not-found':
        return 'Utente non trovato.';
      case 'requires-recent-login':
        return 'L\'utente deve rieffettuare il login recente.';
      default:
        return 'Errore sconosciuto: $code';
    }
  }
}
