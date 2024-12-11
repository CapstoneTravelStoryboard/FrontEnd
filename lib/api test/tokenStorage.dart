class TokenStorage {
  // Singleton instance
  static final TokenStorage _instance = TokenStorage._internal();

  // Private constructor
  TokenStorage._internal();

  // Factory constructor for accessing the singleton
  factory TokenStorage() => _instance;

  // In-memory token
  String? _token;

  // Save token
  void saveToken(String token) {
    _token = token;
  }

  // Read token
  String? readToken() {
    return _token;
  }

  // Delete token
  void deleteToken() {
    _token = null;
  }
}
