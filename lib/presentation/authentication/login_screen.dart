import 'dart:ui';

import 'package:dips/components/custom_button.dart';
import 'package:dips/components/custom_padding.dart';
import 'package:dips/components/custom_text_field.dart';
import 'package:dips/core/routing/route_path.dart';
import 'package:dips/presentation/authentication/authentication_provider.dart';
import 'package:dips/presentation/authentication/widget/or_divider_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';


import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isUserSelected = true;
  bool rememberMe = true;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AuthenticationProvider>();
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/image/ImageWithFallback.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(35),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10),
            child: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 24,
                ),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 28,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.20),
                      borderRadius: BorderRadius.circular(35),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.6),
                        width: 2,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset("assets/image/logo_name.png", height: 60),
                        const SizedBox(height: 12),
                        const Text(
                          "Scan. Discover. More",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Welcome Back',
                          style: TextStyle(
                            color: Color(0xFF041E41),
                            fontSize: 24,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Join thousands of agents and buyers using smart QR boards.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        const SizedBox(height: 24),

                        Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: const Color(0x33041E41),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            children: [
                              _buildToggleButton(
                                title: "User",
                                icon: Icons.person,
                                selected: isUserSelected,
                                onTap: () =>
                                    setState(() => isUserSelected = true),
                              ),
                              _buildToggleButton(
                                title: "Agent",
                                icon: Icons.badge,
                                selected: !isUserSelected,
                                onTap: () =>
                                    setState(() => isUserSelected = false),
                              ),
                            ],
                          ),
                        ),

                        CustomPadding().vPad10,
                        const Text(
                          'Login',
                          style: TextStyle(
                            color: Color(0xFF041E41),
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don’t have an account? ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                isUserSelected
                                    ? context.push(RoutePath.signUp)
                                    : context.push(RoutePath.signUpAgent);
                              },
                              child: const Text(
                                'Sign Up',
                                style: TextStyle(
                                  color: Color(0xFFE63946),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),

                        CustomPadding().vPad15,

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _label("Email"),
                            CustomPadding().vPad5,
                            CustomTextField(
                              controller: emailController,
                              hint: "example@gmail.com",
                            ),

                            CustomPadding().vPad15,

                            _label("Password"),
                            CustomPadding().vPad5,
                            CustomTextField(
                              controller: passwordController,
                              hint: "********",
                              isPassword: true,
                            ),
                          ],
                        ),

                        CustomPadding().vPad5,

                        /// 🔹 Remember + Forgot
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: rememberMe,
                                  onChanged: (v) =>
                                      setState(() => rememberMe = v ?? false),
                                ),
                                const Text(
                                  'Remember Me',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                context.push(
                                  RoutePath.forgotPassword,
                                  extra: isUserSelected,
                                );
                              },
                              child: const Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  color: Color(0xFFE63946),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),

                        CustomPadding().vPad10,
                        CustomButton(
                          onPressed: () async {
                            if (!isUserSelected) {
                              final data = await provider.login(
                                isUser: !isUserSelected,
                                email: emailController.text,
                                password: passwordController.text,
                                context: context,
                              );
                              if (data) {
                                if (context.mounted) {
                                  context.go(RoutePath.homeAgent);
                                }
                              }
                            } else {
                              final data = await provider.login(
                                isUser: isUserSelected,
                                email: emailController.text,
                                password: passwordController.text,
                                context: context,
                              );
                              if (data) {
                                if (context.mounted) {
                                  context.go(RoutePath.home);
                                }
                              }
                            }
                          },
                          title: "Login",
                        ),
                        CustomPadding().vPad10,

                        OrDivider(),

                        CustomPadding().vPad15,

                        Container(
                          width: double.infinity,

                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 1, color: Colors.white),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            shadows: [
                              BoxShadow(
                                color: Color(0x19000000),
                                blurRadius: 20,
                                offset: Offset(0, 2),
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              spacing: 10,
                              children: [
                                SvgPicture.asset("assets/icons/google.svg"),
                                Text(
                                  'Continue with Google',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: const Color(0xFF1A1C1E),
                                    fontSize: 14,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                    height: 1.40,
                                    letterSpacing: -0.14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        CustomPadding().vPad10,
                        Container(
                          width: double.infinity,

                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 1, color: Colors.white),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            shadows: [
                              BoxShadow(
                                color: Color(0x19000000),
                                blurRadius: 20,
                                offset: Offset(0, 2),
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              spacing: 10,
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/apple.svg",
                                  height: 18,
                                  width: 18,
                                ),
                                Text(
                                  'Continue with Google',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: const Color(0xFF1A1C1E),
                                    fontSize: 14,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                    height: 1.40,
                                    letterSpacing: -0.14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _label(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildToggleButton({
    required String title,
    required IconData icon,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: selected ? const Color(0xFF041E41) : Colors.transparent,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: Colors.white, size: 18),
                const SizedBox(width: 6),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
