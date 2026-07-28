import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:http/http.dart' as http;

import 'package:flutter_dotenv/flutter_dotenv.dart';

class GoogleAuthClient extends http.BaseClient {
  final Map<String, String> _headers;
  final http.Client _client = http.Client();

  GoogleAuthClient(this._headers);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    return _client.send(request..headers.addAll(_headers));
  }
}

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: dotenv.env['GOOGLE_WEB_CLIENT_ID'],
    scopes: [
      drive.DriveApi.driveAppdataScope,
      drive.DriveApi.driveFileScope,
    ],
  );

  GoogleSignInAccount? get currentUser => _googleSignIn.currentUser;

  Future<GoogleSignInAccount?> signInSilently() async {
    try {
      return await _googleSignIn.signInSilently().timeout(
        const Duration(seconds: 3),
        onTimeout: () {
          print('Silent sign-in timed out');
          return null;
        },
      );
    } catch (e) {
      print('Error in silent sign in: $e');
      return null;
    }
  }

  Future<GoogleSignInAccount?> signIn() async {
    try {
      return await _googleSignIn.signIn();
    } catch (e) {
      print('Error signing in: $e');
      return null;
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
  }

  Future<http.Client?> getAuthenticatedClient({bool interactive = false}) async {
    // 1. Check existing currentUser in memory
    // 2. Try silent sign in (restores session from cookies/localstorage without popup)
    var user = currentUser ?? await signInSilently();
    
    // 3. Only if interactive is true or user clicked sign in, trigger interactive popup
    if (user == null && interactive) {
      user = await signIn();
    }
    
    if (user == null) return null;

    final headers = await user.authHeaders;
    return GoogleAuthClient(headers);
  }
}

