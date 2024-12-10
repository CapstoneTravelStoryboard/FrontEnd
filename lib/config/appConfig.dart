class AppConfig {
  static const String baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'https://octopus-epic-shrew.ngrok-free.app',
  );
}