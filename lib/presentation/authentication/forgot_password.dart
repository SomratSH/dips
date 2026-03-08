import 'package:dips/components/custom_bg_screen.dart';
import 'package:dips/components/custom_button.dart';
import 'package:dips/components/custom_padding.dart';
import 'package:dips/components/custom_text_field.dart';
import 'package:dips/core/routing/route_path.dart';
import 'package:dips/presentation/authentication/authentication_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';


class ForgotPassword extends StatelessWidget {
  final bool isUser;
  const ForgotPassword({super.key, required this.isUser});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthenticationProvider>();
    return Scaffold(
      body: CustomBgScreen(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/image/logo_name.png", height: 60),
              const SizedBox(height: 12),
              const Text(
                "Scan. Discover. More",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              const SizedBox(height: 20),
              Text(
                ' Forgot Password?',
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
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w400,
                ),
              ),
              CustomPadding().vPad20,
              CustomTextField(
                controller: authProvider.emailController,
                hint: "abc@gmail.com",
              ),
              CustomPadding().vPad20,
              CustomButton(
                onPressed: () async {
                  if (authProvider.emailController.text.isNotEmpty) {
                    final response = await authProvider.forgotPassoword(
                      email: authProvider.emailController.text,
                      context: context,
                      isuser: isUser,
                    );
                    if (response) {
                      if (context.mounted) {
                        context.push(RoutePath.verifyOtp, extra: isUser);
                      }
                    }
                  }
                },
                title: "Sent",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
