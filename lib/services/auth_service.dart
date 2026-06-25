import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../models/api_result.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();

  factory AuthService() {
    return _instance;
  }

  AuthService._internal();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  User? get currentUser => _auth.currentUser;

  Future<ApiResult<User?>> signUpWithEmail(String email, String password, String displayName) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await credential.user?.updateDisplayName(displayName);
      return ApiResult.success(credential.user);
    } on FirebaseAuthException catch (e) {
      return ApiResult.error('Sign-up failed: ${e.message}');
    } catch (e) {
      return ApiResult.error('Unexpected error during sign-up');
    }
  }

  Future<ApiResult<User?>> signInWithEmail(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return ApiResult.success(credential.user);
    } on FirebaseAuthException catch (e) {
      return ApiResult.error('Sign-in failed: ${e.message}');
    } catch (e) {
      return ApiResult.error('Unexpected error during sign-in');
    }
  }

  Future<ApiResult<User?>> signInWithGoogle() async {
    try {
      final googleAccount = await _googleSignIn.signIn();
      if (googleAccount == null) {
        return ApiResult.error('Google sign-in cancelled');
      }

      final googleAuth = await googleAccount.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      return ApiResult.success(userCredential.user);
    } on FirebaseAuthException catch (e) {
      return ApiResult.error('Google sign-in failed: ${e.message}');
    } catch (e) {
      return ApiResult.error('Unexpected error with Google sign-in');
    }
  }

  Future<ApiResult<User?>> signInWithApple() async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final oauthCredential = OAuthProvider('apple.com').credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      final userCredential = await _auth.signInWithCredential(oauthCredential);
      return ApiResult.success(userCredential.user);
    } on FirebaseAuthException catch (e) {
      return ApiResult.error('Apple sign-in failed: ${e.message}');
    } catch (e) {
      return ApiResult.error('Unexpected error with Apple sign-in');
    }
  }

  Future<ApiResult<void>> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return ApiResult.success(null);
    } on FirebaseAuthException catch (e) {
      return ApiResult.error('Failed to send reset email: ${e.message}');
    } catch (e) {
      return ApiResult.error('Unexpected error sending reset email');
    }
  }

  Future<ApiResult<void>> updatePhoneNumber(String phoneNumber, String smsCode, String verificationId) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      await _auth.currentUser?.linkWithCredential(credential);
      return ApiResult.success(null);
    } on FirebaseAuthException catch (e) {
      return ApiResult.error('Phone verification failed: ${e.message}');
    } catch (e) {
      return ApiResult.error('Unexpected error during phone verification');
    }
  }

  Future<void> verifyPhoneNumber(
    String phoneNumber,
    Future<void> Function(String verificationId) onCodeSent,
  ) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.currentUser?.linkWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        // Handle verification failure
      },
      codeSent: (String verificationId, int? resendToken) {
        onCodeSent(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<ApiResult<void>> updateProfile(String? displayName, String? photoUrl) async {
    try {
      if (displayName != null) {
        await _auth.currentUser?.updateDisplayName(displayName);
      }
      if (photoUrl != null) {
        await _auth.currentUser?.updatePhotoURL(photoUrl);
      }
      return ApiResult.success(null);
    } on FirebaseAuthException catch (e) {
      return ApiResult.error('Profile update failed: ${e.message}');
    } catch (e) {
      return ApiResult.error('Unexpected error updating profile');
    }
  }

  Future<ApiResult<void>> signOut() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
      return ApiResult.success(null);
    } catch (e) {
      return ApiResult.error('Sign-out failed');
    }
  }
}
