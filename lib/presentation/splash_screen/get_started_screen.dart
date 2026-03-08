import 'package:dips/components/custom_button.dart';
import 'package:dips/core/routing/route_path.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


import 'package:video_player/video_player.dart';


class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  late final VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller =
        VideoPlayerController.asset('assets/video/185341-875417497.mp4')
          ..initialize().then((_) {
            if (!mounted) return;
            _controller.play();
            setState(() {});
          })
          ..setLooping(true); // optional: loop background video
  }

  @override
  void dispose() {
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
                  // 🎥 Background Video
                  FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: _controller.value.size.width,
                      height: _controller.value.size.height,
                      child: VideoPlayer(_controller),
                    ),
                  ),

                  // 🌫 Overlay Image
                  Image.asset('assets/image/Fader.png', fit: BoxFit.cover),

                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset('assets/image/logo_name.png', width: 260),
                        const SizedBox(height: 24),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: CustomButton(
                            title: 'Get Started',
                            onPressed: () {
                              context.push(RoutePath.login);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : const SizedBox(), // no loader
      ),
    );
  }
}
