import 'package:dips/components/custom_button.dart';
import 'package:dips/components/custom_padding.dart';
import 'package:dips/components/custom_snackbar.dart';
import 'package:dips/components/custom_text_field.dart';
import 'package:dips/core/routing/route_path.dart';
import 'package:dips/presentation/authentication/authentication_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';


class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isUserSelected = true;
  bool rememberMe = true;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phomeController = TextEditingController();

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
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/image/ImageWithFallback.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
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
                      'Sign Up',
                      style: TextStyle(
                        color: Color(0xFF041E41),
                        fontSize: 24,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    CustomPadding().vPad10,

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account? ',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        GestureDetector(
                          onTap: () {
                            context.push(RoutePath.login);
                          },
                          child: const Text(
                            'Login',
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
                        /// 🔹 Email
                        _label("Full Name"),
                        CustomPadding().vPad5,
                        CustomTextField(
                          controller: nameController,
                          hint: "Lois Backent",
                        ),

                        CustomPadding().vPad15,

                        _label("Email"),
                        CustomPadding().vPad5,
                        CustomTextField(
                          controller: emailController,
                          hint: "example@gmail.com",
                        ),

                        CustomPadding().vPad15,

                        /// 🔹 Password
                        _label("Phone Number"),
                        CustomPadding().vPad5,
                        CustomTextField(
                          controller: phomeController,
                          hint: "098765432",
                        ),
                        CustomPadding().vPad15,

                        /// 🔹 Password
                        _label("Set Password"),
                        CustomPadding().vPad5,
                        CustomTextField(
                          controller: passwordController,
                          hint: "********",
                          isPassword: true,
                        ),
                      ],
                    ),

                    CustomPadding().vPad30,
                    CustomButton(
                      onPressed: () async {
                        if (nameController.text.isNotEmpty &&
                            phomeController.text.isNotEmpty &&
                            passwordController.text.isNotEmpty &&
                            emailController.text.isNotEmpty) {
                          final response = await provider.signUpUser(
                            fullName: nameController.text,
                            email: emailController.text,
                            phone: phomeController.text,
                            password: passwordController.text,
                            context: context,
                          );

                          if (response) {
                            if (context.mounted) {
                              context.go(RoutePath.login);
                            }
                          }
                        } else {
                          AppSnackbar.show(
                            context,
                            title: "Vaildation Failed",
                            message: "Fill up all field",
                            type: SnackType.warning,
                          );
                        }
                      },
                      title: "Register",
                    ),
                    CustomPadding().vPad10,
                  ],
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
