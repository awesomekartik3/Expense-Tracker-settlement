import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdService {
  // ─── TEST IDs (replace with real AdMob IDs before publishing) ───────────────
  static const String _bannerAdUnitId =
      'ca-app-pub-5520747342583144/1567159654'; // Real banner
  static const String _interstitialAdUnitId =
      'ca-app-pub-5520747342583144/2780897929'; // Real interstitial

  // ─── Singleton ───────────────────────────────────────────────────────────────
  AdService._();
  static final AdService instance = AdService._();

  InterstitialAd? _interstitialAd;
  int _interstitialLoadAttempts = 0;
  static const int _maxFailedLoadAttempts = 3;

  // ─── Initialize SDK ──────────────────────────────────────────────────────────
  Future<void> initialize() async {
    await MobileAds.instance.initialize();
    _loadInterstitialAd();
  }

  // ─── Banner Ad ───────────────────────────────────────────────────────────────
  BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: _bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    );
  }

  // ─── Interstitial Ad ─────────────────────────────────────────────────────────
  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: _interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _interstitialLoadAttempts = 0;
          _interstitialAd!.setImmersiveMode(true);
        },
        onAdFailedToLoad: (error) {
          _interstitialLoadAttempts += 1;
          _interstitialAd = null;
          if (_interstitialLoadAttempts < _maxFailedLoadAttempts) {
            _loadInterstitialAd();
          }
        },
      ),
    );
  }

  /// Shows the interstitial ad if loaded, then reloads a fresh one.
  void showInterstitialAd() {
    if (_interstitialAd == null) return;
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        _loadInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        _loadInterstitialAd();
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }

  bool get isInterstitialReady => _interstitialAd != null;
}
