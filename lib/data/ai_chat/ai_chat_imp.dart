
import 'package:dips/constant/app_urls.dart';
import 'package:dips/core/api_service/api_service.dart';
import 'package:dips/domain/ai_chat_repository/ai_chat_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AiChatImp implements AiChatRepository {
  ApiService _apiService = ApiService();

  @override
  Future<Map<String, dynamic>> chatAi(Map<String, dynamic> data) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final response = await _apiService.postData(
      AppUrls.chatAi,
      data,
      authToken: preferences.getString("authToken"),
    );
    return response;
  }
}
