import 'package:dips/components/custom_snackbar.dart';
import 'package:dips/domain/authentication/auth_repository.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationProvider extends ChangeNotifier {
  final AuthRepository _authRepository;

  AuthenticationProvider(this._authRepository);

  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  TextEditingController newPassword = TextEditingController();

  bool isLoading = false;
  Future<bool> login({
    required String email,
    required String password,
    required bool isUser,
    required BuildContext context,
  }) async {
    isLoading = true;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = isUser
        ? await _authRepository.login({
            "email": email,
            "password": password,
            // "device_token": "test-token-12345",
          })
        : await _authRepository.loginAgent({
            "email": email,
            "password": password,
          });
    if (response["access"] != null) {
      prefs.setString('authToken', response["access"]).toString();
      prefs.setString('refreshToken', response["refresh"].toString());
      prefs.setString("role", response["user"]["role"]).toString();
      notifyListeners();
      AppSnackbar.show(context, title: "Success", message: "Login Successful");
      return true;
    } else {
      debugPrint("Login failed: ${response["message"]}");
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> signUpUser({
    required String fullName,
    required String email,
    required String phone,
    required String password,
    required BuildContext context,
  }) async {
    isLoading = true;
    notifyListeners();
    final response = await _authRepository.signUp({
      "full_name": fullName,
      "email": email,
      "phone": phone,
      "password": password,
    });

    if (response["access"] != null && response["user"] != null) {
      AppSnackbar.show(context, title: "Success", message: "SignUp Successful");
      isLoading = false;
      notifyListeners();
      return true;
    } else {
      debugPrint("Singup failed: ${response["message"]}");
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> signUpAgent({
    required String fullName,
    required String email,
    required String phone,
    required String password,
    required String brandName,
    required BuildContext context,
  }) async {
    isLoading = true;
    notifyListeners();
    final response = await _authRepository.signUpAgent({
      "full_name": fullName,
      "brand_name": brandName,
      "email": email,
      "phone": phone,
      "password": password,
    });

    if (response["access"] != null && response["user"] != null) {
      AppSnackbar.show(context, title: "Success", message: "SignUp Successful");
      isLoading = false;
      notifyListeners();
      return true;
    } else {
      debugPrint("Singup failed: ${response["message"]}");
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> forgotPassoword({
    required String email,
    required BuildContext context,
    required bool isuser,
  }) async {
    print(isuser);
    isLoading = true;
    notifyListeners();
    final respnse = isuser
        ? await _authRepository.forgotPassword({"email": email})
        : await _authRepository.forgotPasswordAgent({"email": email});
    if (respnse["message"] == "OTP sent to your email.") {
      isLoading = false;
      notifyListeners();
      AppSnackbar.show(
        context,
        title: "OTP",
        message: respnse["message"],
        type: SnackType.success,
      );
      return true;
    } else {
      isLoading = false;
      notifyListeners();
      AppSnackbar.show(
        context,
        title: "OTP",
        message: respnse["message"],
        type: SnackType.error,
      );
      return false;
    }
  }

  Future<bool> verifyOtp({
    required String email,
    required String otp,
    required BuildContext context,
    required bool isuser,
  }) async {
    print(isuser);
    isLoading = true;
    notifyListeners();
    final respnse = isuser
        ? await _authRepository.verifyOtp({"email": email, "otp_code": otp})
        : await _authRepository.verifyOtpAgent({
            "email": email,
            "otp_code": otp,
          });
    if (respnse["message"] == "OTP verified.") {
      isLoading = false;
      notifyListeners();
      AppSnackbar.show(
        context,
        title: "OTP",
        message: respnse["message"],
        type: SnackType.success,
      );
      return true;
    } else {
      isLoading = false;
      notifyListeners();
      AppSnackbar.show(
        context,
        title: "OTP",
        message: respnse["message"],
        type: SnackType.error,
      );
      return false;
    }
  }

  Future<bool> createNewPassword({
    required String email,
    required String otp,
    required BuildContext context,
    required bool isuser,
    required String newPassword,
  }) async {
    print(isuser);
    isLoading = true;
    notifyListeners();
    final respnse = isuser
        ? await _authRepository.setNewPassword({
            "email": email,
            "otp_code": otp,
            "new_password": newPassword,
          })
        : await _authRepository.setNewPasswordAgent({
            "email": email,
            "otp_code": otp,
            "new_password": newPassword,
          });
    if (respnse["message"] == "Password reset successfully.") {
      isLoading = false;
      notifyListeners();
      AppSnackbar.show(
        context,
        title: "Changed Password",
        message: respnse["message"],
        type: SnackType.success,
      );
      return true;
    } else {
      isLoading = false;
      notifyListeners();
      AppSnackbar.show(
        context,
        title: "Changed Password",
        message: respnse["message"],
        type: SnackType.error,
      );
      return false;
    }
  }

  Future<void> logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('authToken');
    prefs.remove('refreshToken');
    prefs.remove("role");
    notifyListeners();
  }

  String otp = "";
  void saveOtp(String p1) {
    otp = p1;
    notifyListeners();
  }
}
