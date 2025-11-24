import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../config/config.dart';

class AdService {
  static final AdService _instance = AdService._internal();
  factory AdService() => _instance;
  AdService._internal();

  RewardedAd? _rewardedAd;
  bool _isAdReady = false;
  bool _isLoading = false;

  bool get isAdReady => _isAdReady;

  Future<void> initialize() async {
    await MobileAds.instance.initialize();
    await loadRewardedAd();
  }

  Future<void> loadRewardedAd() async {
    if (_isLoading) return;

    _isLoading = true;
    _isAdReady = false;

    await RewardedAd.load(
      adUnitId: AppConfig.admobTestRewardedAdId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          _rewardedAd = ad;
          _isAdReady = true;
          _isLoading = false;
          _setupAdCallbacks();
        },
        onAdFailedToLoad: (LoadAdError error) {
          _rewardedAd = null;
          _isAdReady = false;
          _isLoading = false;
        },
      ),
    );
  }

  void _setupAdCallbacks() {
    _rewardedAd?.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        ad.dispose();
        _rewardedAd = null;
        _isAdReady = false;
        loadRewardedAd();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        ad.dispose();
        _rewardedAd = null;
        _isAdReady = false;
        loadRewardedAd();
      },
    );
  }

  Future<bool> showRewardedAd() async {
    if (!_isAdReady || _rewardedAd == null) {
      return false;
    }

    bool rewardGranted = false;

    await _rewardedAd!.show(
      onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
        rewardGranted = true;
      },
    );

    return rewardGranted;
  }

  void dispose() {
    _rewardedAd?.dispose();
    _rewardedAd = null;
    _isAdReady = false;
  }
}
