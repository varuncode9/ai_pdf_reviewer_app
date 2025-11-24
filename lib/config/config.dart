class AppConfig {
  static const String API_KEY = "YOUR_API_KEY_HERE";

  static const String geminiApiUrl = "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent";

  static const String admobTestRewardedAdId = "ca-app-pub-3940256099942544/5224354917";

  static String get apiKey => API_KEY;

  static bool get isApiKeyConfigured => API_KEY != "YOUR_API_KEY_HERE" && API_KEY.isNotEmpty;
}
