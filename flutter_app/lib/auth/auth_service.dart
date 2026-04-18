import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  final FirebaseAuth _auth;
  AuthRepository(this._auth);

  User? get currentUser => _auth.currentUser;
  bool get isAnonymous => _auth.currentUser?.isAnonymous ?? true;
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// Sign in anonymously — called on first launch.
  Future<User?> signInAnonymously() async {
    final cred = await _auth.signInAnonymously();
    return cred.user;
  }

  /// Sign in with Google — upgrades anonymous account if possible.
  Future<User?> signInWithGoogle() async {
    final googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) return null; // user cancelled

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // If currently anonymous, link the credential to upgrade the account.
    if (_auth.currentUser?.isAnonymous ?? false) {
      try {
        final result = await _auth.currentUser!.linkWithCredential(credential);
        return result.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'credential-already-in-use') {
          // Credential belongs to another account — sign in to that one instead.
          await _auth.signOut();
          final result = await _auth.signInWithCredential(credential);
          return result.user;
        }
        rethrow;
      }
    }

    final result = await _auth.signInWithCredential(credential);
    return result.user;
  }

  Future<void> signOut() async {
    await GoogleSignIn().signOut();
    await _auth.signOut();
    // Re-create anonymous session so data still syncs.
    await signInAnonymously();
  }

  Future<void> deleteAccount() async {
    await _auth.currentUser?.delete();
  }
}

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepository(FirebaseAuth.instance),
);

final authStateProvider = StreamProvider<User?>(
  (ref) => ref.watch(authRepositoryProvider).authStateChanges,
);
