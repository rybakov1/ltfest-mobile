abstract class ApiEndpoints {
  static const String baseStrapiUrl = 'http://37.46.132.144:1338'; //staging
  // static const String baseStrapiUrl = 'http://37.46.132.144:1337'; //prod

  static bool get isTestServer => baseStrapiUrl.contains(':1338');

  static String imageUrl(String? relativeUrl) {
    if (relativeUrl == null || relativeUrl.isEmpty) return '';
    return '$baseStrapiUrl$relativeUrl';
  }
}
