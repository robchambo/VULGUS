import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Replace with your real AdMob unit IDs before release.
// Get them from https://admob.google.com after creating an app.
// Also add your AdMob App ID to:
//   Android: android/app/src/main/AndroidManifest.xml
//   iOS:     ios/Runner/Info.plist
// See: https://developers.google.com/admob/flutter/quick-start
const _testAndroidUnitId = 'ca-app-pub-3940256099942544/1033173712';
const _testIosUnitId = 'ca-app-pub-3940256099942544/4411468910';
const _adsRemovedKey = 'ads_removed_v1';

class AdService {
  InterstitialAd? _ad;
  bool _shownThisSession = false;

  String get _adUnitId =>
      Platform.isAndroid ? _testAndroidUnitId : _testIosUnitId;

  void preload() {
    InterstitialAd.load(
      adUnitId: _adUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) => _ad = ad,
        onAdFailedToLoad: (_) => _ad = null,
      ),
    );
  }

  Future<bool> get adsRemoved async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_adsRemovedKey) ?? false;
  }

  Future<void> removeAds() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_adsRemovedKey, true);
  }

  Future<void> showPostGameAd() async {
    if (_shownThisSession) return;
    if (await adsRemoved) return;
    final ad = _ad;
    if (ad == null) return;

    _shownThisSession = true;
    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (a) {
        a.dispose();
        _ad = null;
        preload(); // Preload for next session.
      },
      onAdFailedToShowFullScreenContent: (a, _) {
        a.dispose();
        _ad = null;
        _shownThisSession = false;
      },
    );
    await ad.show();
  }
}

final adServiceProvider = Provider<AdService>((ref) {
  final service = AdService();
  service.preload();
  return service;
});
