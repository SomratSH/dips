import 'package:dips/components/custom_bg_screen.dart';
import 'package:dips/components/custom_button.dart';
import 'package:dips/components/custom_padding.dart';
import 'package:dips/components/custom_text_field.dart';
import 'package:dips/core/routing/route_path.dart';
import 'package:dips/presentation/authentication/authentication_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';


class CreateNewPasswordScreen extends StatelessWidget {
  final String email;
  final String otp;
  final bool isUser;
  const CreateNewPasswordScreen({
    super.key,
    required this.email,
    required this.otp,
    required this.isUser,
  });

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
                'Create New Password',
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
                'Your new password must be unique from those previously used.',
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
                controller: authProvider.newPassword,
                hint: "******",
                isPassword: true,
              ),
              CustomPadding().vPad20,
              CustomButton(
                onPressed: () async {
                  final response = await authProvider.createNewPassword(
                    email: email,
                    otp: otp,
                    context: context,
                    isuser: isUser,
                    newPassword: authProvider.newPassword.text,
                  );
                  if (response) {
                    if (context.mounted) {
                      context.push(RoutePath.successPasswordChanged);
                    }
                  }
                },
                title: "Save",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
