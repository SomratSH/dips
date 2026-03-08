abstract class AuthRepository {
  Future<Map<String, dynamic>> signUp(Map<String, dynamic> body);
  Future<Map<String, dynamic>> signUpAgent(Map<String, dynamic> body);

  Future<Map<String, dynamic>> login(Map<String, String> map);
  Future<Map<String, dynamic>> loginAgent(Map<String, String> map);

  Future<Map<String, dynamic>> forgotPassword(Map<String, String> map);
  Future<Map<String, dynamic>> forgotPasswordAgent(Map<String, String> map);

  Future<Map<String, dynamic>> verifyOtp(Map<String, String> map);
  Future<Map<String, dynamic>> verifyOtpAgent(Map<String, String> map);

  Future<Map<String, dynamic>> setNewPassword(Map<String, String> map);
  Future<Map<String, dynamic>> setNewPasswordAgent(Map<String, String> map);
}
