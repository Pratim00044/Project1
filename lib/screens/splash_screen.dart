import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _videoController;
  bool _initialized = false;
  bool _navigated = false;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset('assets/Video/Banner.mp4')
      ..initialize().then((_) {
        if (mounted) {
          setState(() {
            _initialized = true;
          });
          _videoController.play();
        }
      });

    _videoController.addListener(_videoListener);
  }

  void _videoListener() {
    if (!_initialized || _navigated) return;

    if (_videoController.value.position >= _videoController.value.duration) {
      _navigated = true;
      _navigateToLogin();
    }
  }

  void _navigateToLogin() {
    if (mounted) {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  void dispose() {
    _videoController.removeListener(_videoListener);
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: _initialized
            ? SizedBox.expand(
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: SizedBox(
                    width: _videoController.value.size.width,
                    height: _videoController.value.size.height,
                    child: VideoPlayer(_videoController),
                  ),
                ),
              )
            : const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFFD4AF37),
                ),
              ),
      ),
    );
  }
}
