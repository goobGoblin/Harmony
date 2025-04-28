import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../pages/utils/pkce_util.dart';
import 'dart:io' show Platform;

class SoundCloudAPI {
  // SoundCloud application credentials
  final String clientId = "";
  final String clientSecret = "";

  final String redirectUri =
      Platform.isAndroid || Platform.isIOS
          ? 'myapp://soundcloud/callback'
          : 'https://eecs-582-project-74abe.web.app/callback.html';

  Future<void> connect() async {
    // Generate PKCE verifier and challenge
    final codeVerifier = PKCEUtil.generateCodeVerifier();
    final codeChallenge = PKCEUtil.generateCodeChallenge(codeVerifier);

    try {
      await authenticateWithSoundCloud(codeChallenge, codeVerifier);
      log('SoundCloud authentication successful!');
    } catch (e) {
      log('SoundCloud authentication failed: $e');
    }
  }

  /// Starts the OAuth2 flow: opens SoundCloud login, gets authorization code,
  /// and exchanges it for access/refresh tokens using PKCE.
  Future<void> authenticateWithSoundCloud(
    String codeChallenge,
    String codeVerifier,
  ) async {
    final authUrl =
        Uri.https("soundcloud.com", "/connect", {
          "client_id": clientId,
          "redirect_uri": redirectUri,
          "response_type": "code",
          "code_challenge": codeChallenge,
          "code_challenge_method": "S256",
          "display": "popup",
          "state": DateTime.now().millisecondsSinceEpoch.toString(),
        }).toString();

    try {
      // Launch browser or WebView for user to authenticate
      final result = await FlutterWebAuth2.authenticate(
        url: authUrl,
        callbackUrlScheme: "myapp",
      );

      final uri = Uri.parse(result);
      final code = uri.queryParameters['code'];

      if (code == null) {
        throw Exception("Authorization code not found in the redirect.");
      }

      log("Authorization code received: $code");
      await exchangeCodeForToken(code, codeVerifier);
    } catch (e) {
      log("SoundCloud Auth Error: $e");
      rethrow;
    }
  }

  /// Exchanges the authorization code for access and refresh tokens.
  Future<void> exchangeCodeForToken(String code, String codeVerifier) async {
    final response = await http.post(
      Uri.parse("https://api.soundcloud.com/oauth2/token"),
      headers: {"Content-Type": "application/x-www-form-urlencoded"},
      body: {
        "client_id": clientId,
        "client_secret": clientSecret,
        "grant_type": "authorization_code",
        "code": code,
        "redirect_uri": redirectUri,
        "code_verifier": codeVerifier,
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      log("Access Token: ${data['access_token']}");
      log("Refresh Token: ${data['refresh_token']}");
      log("Expires In: ${data['expires_in']} seconds");
    } else {
      log("Token exchange failed: ${response.statusCode} ${response.body}");
      throw Exception("Token exchange failed: ${response.statusCode}");
    }
  }

  /// Example: Get user info using an access token
  Future<Map<String, dynamic>?> getUserInfo(String accessToken) async {
    final response = await http.get(
      Uri.parse("https://api.soundcloud.com/me"),
      headers: {"Authorization": "Bearer $accessToken"},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      log("Failed to fetch user info: ${response.statusCode} ${response.body}");
      return null;
    }
  }
}
