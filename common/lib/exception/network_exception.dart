
class NetworkException implements Exception {
  final String? _msg;

  String get msg => _msg ?? "";

  const NetworkException([this._msg]);

  @override
  String toString() => "NetworkException ($_msg)";
}