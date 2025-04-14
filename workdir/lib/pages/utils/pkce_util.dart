import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';

class PKCEUtil {
  // Allowed unreserved characters per RFC 7636.
  static const String _chars =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-._~';

  /// Generates a random code verifier of the specified [length].
  /// The code verifier must be between 43 and 128 characters.
  static String generateCodeVerifier([int length = 64]) {
    final Random random = Random.secure();
    final verifier = List.generate(length, (index) => _chars[random.nextInt(_chars.length)]).join();
    return verifier;
  }

  /// Computes the code challenge for the given [codeVerifier] by:
  /// 1. Encoding it as UTF8.
  /// 2. Taking the SHA256 digest.
  /// 3. Base64 URL‑encoding the digest and stripping any "=" padding.
  static String generateCodeChallenge(String codeVerifier) {
    final bytes = utf8.encode(codeVerifier);
    final digest = sha256.convert(bytes);
    final challenge = base64Url.encode(digest.bytes).replaceAll("=", "");
    return challenge;
  }
}