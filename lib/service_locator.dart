import 'package:dips/data/agent/agent_imp.dart';
import 'package:dips/data/ai_chat/ai_chat_imp.dart';
import 'package:dips/data/auth/auth_imp.dart';
import 'package:dips/data/profile/profile_imp.dart';
import 'package:dips/data/properity/home_imp.dart';
import 'package:dips/domain/agent_repository/agent_repository.dart';
import 'package:dips/domain/ai_chat_repository/ai_chat_repository.dart';
import 'package:dips/domain/authentication/auth_repository.dart';
import 'package:dips/domain/profile/profile_repository.dart';
import 'package:dips/domain/property/home_repository.dart';
import 'package:get_it/get_it.dart';


final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerLazySingleton<AuthRepository>(() => AuthImp());
  getIt.registerLazySingleton<ProfileRepository>(() => ProfileImp());
  getIt.registerLazySingleton<AiChatRepository>(() => AiChatImp());
  getIt.registerLazySingleton<HomeRepository>(() => HomeImp());
   getIt.registerLazySingleton<AgentRepository>(() => AgentImp());
  // Repository

  // // Providers / Controllers
  // getIt.registerFactory<LoginProvider>(() => LoginProvider());
  // getIt.registerFactory<SignupProvider>(
  //   () => SignupProvider(getIt<AuthRepository>()),
  // );
  // getIt.registerFactory<ChangePasswordProvider>(() => ChangePasswordProvider());
  // getIt.registerFactory<MenuListProvider>(() => MenuListProvider());
  // getIt.registerFactory<DriverMenuProvider>(() => DriverMenuProvider());
  // getIt.registerFactory<DriverSettingsProvider>(() => DriverSettingsProvider());
}
