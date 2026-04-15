class AuthService {
  Future<void> signInWithApple() async {
    // TODO: integrate sign_in_with_apple in follow-up plan.
    await Future<void>.delayed(const Duration(milliseconds: 400));
  }

  Future<void> signInWithGoogle() async {
    // TODO: integrate google_sign_in in follow-up plan.
    await Future<void>.delayed(const Duration(milliseconds: 400));
  }

  // ignore: avoid_unused_constructor_parameters
  Future<void> signInWithEmail(String email) async {
    // TODO: integrate email magic-link in follow-up plan.
    await Future<void>.delayed(const Duration(milliseconds: 400));
  }
}
