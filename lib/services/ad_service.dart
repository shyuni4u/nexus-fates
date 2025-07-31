import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../utils/log.dart';

// Mock ad classes for development
class MockReward {
  final int amount;
  final String type;
  
  MockReward(this.amount, this.type);
}

class AdService {
  static final AdService _instance = AdService._internal();
  factory AdService() => _instance;
  AdService._internal();

  bool _isInitialized = false;
  bool _rewardedAdLoaded = false;
  bool _interstitialAdLoaded = false;

  // Mock ad configuration
  static const int _mockAdLoadDelay = 1; // seconds
  static const int _mockAdShowDelay = 3; // seconds
  static const double _mockAdFailureRate = 0.1; // 10% failure rate for realism

  Future<void> initialize() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _isInitialized = true;
    logger.i('DEV MODE: Using mock ad service');
    
    _loadRewardedAd();
    _loadInterstitialAd();
  }

  void _loadRewardedAd() async {
    await Future.delayed(Duration(seconds: _mockAdLoadDelay));
    
    // Simulate occasional ad load failures
    if (Random().nextDouble() < _mockAdFailureRate) {
      logger.w('DEV MODE: Mock rewarded ad failed to load');
      _rewardedAdLoaded = false;
      
      // Retry after delay
      Future.delayed(const Duration(seconds: 5), _loadRewardedAd);
      return;
    }
    
    _rewardedAdLoaded = true;
    logger.d('DEV MODE: Mock rewarded ad loaded successfully');
  }

  void _loadInterstitialAd() async {
    await Future.delayed(Duration(seconds: _mockAdLoadDelay));
    
    // Simulate occasional ad load failures
    if (Random().nextDouble() < _mockAdFailureRate) {
      logger.w('DEV MODE: Mock interstitial ad failed to load');
      _interstitialAdLoaded = false;
      
      // Retry after delay
      Future.delayed(const Duration(seconds: 5), _loadInterstitialAd);
      return;
    }
    
    _interstitialAdLoaded = true;
    logger.d('DEV MODE: Mock interstitial ad loaded successfully');
  }

  Future<bool> showRewardedAd() async {
    if (!_rewardedAdLoaded) {
      logger.w('DEV MODE: Rewarded ad not ready');
      return false;
    }

    logger.d('DEV MODE: Showing mock rewarded ad...');
    
    // Simulate ad display time
    await Future.delayed(Duration(seconds: _mockAdShowDelay));
    
    // Simulate user completing the ad (90% completion rate)
    final bool adCompleted = Random().nextDouble() > 0.1;
    
    if (adCompleted) {
      logger.i('DEV MODE: User completed rewarded ad - granting reward');
      _rewardedAdLoaded = false; // Ad consumed
      _loadRewardedAd(); // Load next ad
      return true;
    } else {
      logger.d('DEV MODE: User skipped rewarded ad');
      _rewardedAdLoaded = false; // Ad consumed
      _loadRewardedAd(); // Load next ad
      return false;
    }
  }

  Future<void> showInterstitialAd() async {
    if (!_interstitialAdLoaded) {
      logger.w('DEV MODE: Interstitial ad not ready');
      return;
    }

    logger.d('DEV MODE: Showing mock interstitial ad...');
    
    // Simulate ad display time
    await Future.delayed(const Duration(seconds: 2));
    
    logger.d('DEV MODE: Interstitial ad dismissed');
    _interstitialAdLoaded = false; // Ad consumed
    _loadInterstitialAd(); // Load next ad
  }

  // Show mock ad dialog for visual feedback during development
  Future<bool> showMockRewardedAdDialog(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return MockAdDialog(
          adType: 'Rewarded Video',
          onAdCompleted: () {
            Navigator.of(context).pop(true);
            _rewardedAdLoaded = false;
            _loadRewardedAd();
          },
          onAdSkipped: () {
            Navigator.of(context).pop(false);
            _rewardedAdLoaded = false;
            _loadRewardedAd();
          },
        );
      },
    ) ?? false;
  }

  Future<void> showMockInterstitialAdDialog(BuildContext context) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return MockAdDialog(
          adType: 'Interstitial',
          onAdCompleted: () {
            Navigator.of(context).pop();
            _interstitialAdLoaded = false;
            _loadInterstitialAd();
          },
          showSkipButton: false,
        );
      },
    );
  }

  // Getters for ad availability
  bool get isRewardedAdReady => _rewardedAdLoaded;
  bool get isInterstitialAdReady => _interstitialAdLoaded;
  bool get isInitialized => _isInitialized;

  void dispose() {
    _rewardedAdLoaded = false;
    _interstitialAdLoaded = false;
    logger.d('DEV MODE: Mock ad service disposed');
  }
}

// Mock ad dialog widget for visual feedback
class MockAdDialog extends StatefulWidget {
  final String adType;
  final VoidCallback onAdCompleted;
  final VoidCallback? onAdSkipped;
  final bool showSkipButton;

  const MockAdDialog({
    super.key,
    required this.adType,
    required this.onAdCompleted,
    this.onAdSkipped,
    this.showSkipButton = true,
  });

  @override
  State<MockAdDialog> createState() => _MockAdDialogState();
}

class _MockAdDialogState extends State<MockAdDialog> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progressAnimation;
  Timer? _adTimer;
  int _remainingSeconds = 5;
  bool _canSkip = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );
    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    
    _controller.forward();
    
    _adTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _remainingSeconds--;
        if (_remainingSeconds <= 2) _canSkip = true;
        if (_remainingSeconds <= 0) {
          timer.cancel();
          widget.onAdCompleted();
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _adTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black87,
      child: Container(
        padding: const EdgeInsets.all(20),
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.tv,
              color: Colors.white,
              size: 48,
            ),
            const SizedBox(height: 16),
            Text(
              'Mock ${widget.adType} Ad',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'This is a development placeholder',
              style: TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 24),
            AnimatedBuilder(
              animation: _progressAnimation,
              builder: (context, child) {
                return Column(
                  children: [
                    LinearProgressIndicator(
                      value: _progressAnimation.value,
                      backgroundColor: Colors.grey[600],
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$_remainingSeconds seconds remaining',
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (widget.showSkipButton && _canSkip)
                  TextButton(
                    onPressed: widget.onAdSkipped,
                    child: const Text(
                      'Skip Ad',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                if (!widget.showSkipButton)
                  const Spacer(),
                TextButton(
                  onPressed: _remainingSeconds <= 0 ? widget.onAdCompleted : null,
                  child: Text(
                    _remainingSeconds <= 0 ? 'Continue' : 'Please wait...',
                    style: TextStyle(
                      color: _remainingSeconds <= 0 ? Colors.blue : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}