import 'dart:async';
import 'package:dips/core/routing/route_path.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final VideoPlayerController _controller;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _controller =
        VideoPlayerController.asset('assets/video/185341-875417497.mp4')
          ..initialize().then((_) {
            _controller.play();
            setState(() {});
          })
          ..setLooping(false);

    // ⏱ Navigate after 3 seconds
    _timer = Timer(const Duration(seconds: 3), () {
      goNext();
    });
  }

  void goNext() {
    if (!mounted) return;
    context.push(RoutePath.getStarted);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox.expand(
        child: _controller.value.isInitialized
            ? Stack(
                fit: StackFit.expand,
                children: [
                  // 🎥 Video
                  FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: _controller.value.size.width,
                      height: _controller.value.size.height,
                      child: VideoPlayer(_controller),
                    ),
                  ),

                  // 🖼 Overlay
                  Image.asset('assets/image/Fader.png', fit: BoxFit.cover),

                  // 🏷 Logo
                  Positioned(
                    top: 350,
                    left: 150,
                    child: Image.asset('assets/image/logo.png', width: 120),
                  ),
                ],
              )
            : const SizedBox(),
      ),
    );
  }
}
