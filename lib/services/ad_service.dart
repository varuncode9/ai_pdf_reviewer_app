import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../config/config.dart';

class AdService {
  static final AdService _instance = AdService._internal();
  factory AdService() => _instance;
  AdService._internal();

  RewardedAd? _rewardedAd;
  bool _isAdReady = false;
  bool _isLoading = false;
  bool _isShowing = false;

  bool get isAdReady => _isAdReady;

  Future<void> initialize() async {
    try {
      await MobileAds.instance.initialize();
      await Future.delayed(const Duration(seconds: 1));
      await loadRewardedAd();
    } catch (e) {
      print('AdMob initialization error: $e');
    }
  }

  Future<void> loadRewardedAd() async {
    if (_isLoading || _isAdReady) return;

    _isLoading = true;
    _isAdReady = false;

    try {
      await RewardedAd.load(
        adUnitId: AppConfig.admobTestRewardedAdId,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            _rewardedAd = ad;
            _isAdReady = true;
            _isLoading = false;
            _setupAdCallbacks();
            print('Ad loaded successfully');
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('Ad load failed: ${error.message}');
            _rewardedAd?.dispose();
            _rewardedAd = null;
            _isAdReady = false;
            _isLoading = false;
            Future.delayed(const Duration(seconds: 3), () {
              loadRewardedAd();
            });
          },
        ),
      );
    } catch (e) {
      print('Ad load exception: $e');
      _isLoading = false;
      _isAdReady = false;
    }
  }

  void _setupAdCallbacks() {
    _rewardedAd?.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) {
        print('Ad shown successfully');
        _isShowing = true;
      },
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        print('Ad dismissed');
        ad.dispose();
        _rewardedAd = null;
        _isAdReady = false;
        _isShowing = false;
        loadRewardedAd();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        print('Ad failed to show: ${error.message}');
        ad.dispose();
        _rewardedAd = null;
        _isAdReady = false;
        _isShowing = false;
        loadRewardedAd();
      },
    );
  }

  Future<bool> showRewardedAd() async {
    if (!_isAdReady || _rewardedAd == null || _isShowing) {
      print('Cannot show ad. Ready: $_isAdReady, IsNull: ${_rewardedAd == null}, Showing: $_isShowing');
      return false;
    }

    _isShowing = true;
    bool rewardGranted = false;

    try {
      await _rewardedAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
          print('Reward earned!');
          rewardGranted = true;
        },
      );
      print('Ad show completed, reward: $rewardGranted');
    } catch (e) {
      print('Error showing ad: $e');
      rewardGranted = false;
      _isShowing = false;
    }

    return rewardGranted;
  }

  void dispose() {
    _rewardedAd?.dispose();
    _rewardedAd = null;
    _isAdReady = false;
    _isShowing = false;
  }
}
