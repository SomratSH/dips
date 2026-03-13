import 'package:dips/presentation/agent/home/home_agent_provider.dart';
import 'package:dips/presentation/authentication/authentication_provider.dart';
import 'package:dips/presentation/chatbot/chatbot_provider.dart';
import 'package:dips/presentation/user/home/home_provider.dart';
import 'package:dips/presentation/user/profile/profile_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

final getIt = GetIt.instance;

class AppProvider {
  static List<SingleChildWidget> get provider => [
    ChangeNotifierProvider(create: (_) => AuthenticationProvider(getIt())),
    ChangeNotifierProvider(
      create: (_) => ProfileProvider(getIt())..getProfileData(),
    ),
    ChangeNotifierProvider(create: (_) => ChatbotProvider(getIt())),
    ChangeNotifierProvider(
      create: (_) => HomeProvider(getIt())
        ..getPropertyType()
        ..getPropertyList()
        ..getFavourite(),
    ),

    //agent
      ChangeNotifierProvider(create: (_) => HomeAgentProvider(getIt())..getAgentProfile()..getDashboard()..getPropertyList()..getAgentProfile()..getPropertyType()..fetchOfferData()..getNotification()..fetchLeadsData()..getMyPropertyList()),
  ];
}
