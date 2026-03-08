import 'package:dips/components/custom_bg_screen.dart';
import 'package:dips/components/custom_button.dart';
import 'package:dips/components/custom_padding.dart';
import 'package:dips/core/routing/route_path.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';



class SuccessPasswordScreen extends StatelessWidget {
  const SuccessPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBgScreen(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle_outline,
                size: 100,
                color: const Color(0xFF041E41),
              ),
              const SizedBox(height: 20),
              Text(
                'Password Changed !',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF041E41),
                  fontSize: 24,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w700,
                ),
              ),
              CustomPadding().vPad20,
              Text(
                'Don\'t worry! Please enter the email address linked with your account.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF041E41),
                  fontSize: 14,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w400,
                ),
              ),

              CustomPadding().vPad20,
              CustomButton(
                onPressed: () {
                  context.go(RoutePath.login);
                },
                title: "Close",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
