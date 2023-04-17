abstract class Consts {
  static const String apiUrl = String.fromEnvironment(
    'API_URL',
    defaultValue: "https://localhost:7125",
  );
}
