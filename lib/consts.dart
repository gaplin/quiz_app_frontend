abstract class Consts {
  static const String apiUrl = String.fromEnvironment(
    'API_URL',
    defaultValue: "localhost:7125",
  );
}
