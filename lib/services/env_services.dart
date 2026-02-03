import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvSetupService {
  static String get pexelsApiKey => dotenv.env['PEXELS_API_KEY'] ?? '';
  static Future<void> loadEnv() async {
    await dotenv.load(fileName: ".env");
  }
}
