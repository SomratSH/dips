import 'package:dips/components/custom_bg_screen.dart';
import 'package:dips/components/custom_button.dart';
import 'package:dips/components/custom_padding.dart';
import 'package:dips/core/routing/route_path.dart';
import 'package:dips/presentation/authentication/authentication_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';


class OtpVerifyScreen extends StatefulWidget {
  final bool isUser;
  const OtpVerifyScreen({super.key, required this.isUser});

  @override
  State<OtpVerifyScreen> createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends State<OtpVerifyScreen> {
  List<TextEditingController> _controllers = [];
  List<FocusNode> _focusNodes = [];

  void _onChanged(String value, int index) {
    if (value.isNotEmpty && index < 3) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  String get _otpValue {
    return _controllers.map((controller) => controller.text).join();
  }

  @override
  void initState() {
    super.initState();
    // Initialize controllers and focus nodes for 4 OTP fields
    for (int i = 0; i < 4; i++) {
      _controllers.add(TextEditingController());
      _focusNodes.add(FocusNode());
    }
  }

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
                'Enter the verification code we just sent on your email address.',
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
                'Enter the verification code we just sent on your email address.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w400,
                ),
              ),
              CustomPadding().vPad30,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(4, (index) {
                  return Container(
                    width: 60,
                    height: 60,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: const Color(0xFF4B5563),
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: TextField(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        counterText: '',
                      ),
                      onChanged: (value) => _onChanged(value, index),
                    ),
                  );
                }),
              ),
              CustomPadding().vPad20,
              CustomButton(
                onPressed: () async {
                  final response = await authProvider.verifyOtp(
                    email: authProvider.emailController.text,
                    otp: _otpValue,
                    context: context,
                    isuser: widget.isUser,
                  );

                  if (response) {
                    if (context.mounted) {
                      context.push(
                        RoutePath.createNewPassword,
                        extra: {
                          "email": authProvider.emailController.text,
                          "otp": _otpValue,
                          "is_user" : widget.isUser as bool,
                        },
                      );
                    }
                  }
                },
                title: "Verify",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OtpBox extends StatelessWidget {
  final TextEditingController controller;
  final bool autoFocus;

  const OtpBox({super.key, required this.controller, this.autoFocus = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      child: TextField(
        controller: controller,
        autofocus: autoFocus,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: const InputDecoration(
          counterText: "",
          border: OutlineInputBorder(),
        ),
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }
}
