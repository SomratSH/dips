import 'package:dips/core/routing/route_path.dart';
import 'package:dips/presentation/agent/add_properties/add_properites_agent.dart';
import 'package:dips/presentation/agent/all_properties/all_properties_agent.dart';
import 'package:dips/presentation/agent/home/home_agent.dart';
import 'package:dips/presentation/agent/landing_page/landing_page_agent.dart';
import 'package:dips/presentation/agent/notification/notification_page.dart';
import 'package:dips/presentation/agent/offer/offer_agent.dart';
import 'package:dips/presentation/agent/offer/offer_details.dart';
import 'package:dips/presentation/agent/profile/edit_agent_profile.dart';
import 'package:dips/presentation/agent/profile/leads_screen.dart';
import 'package:dips/presentation/agent/profile/profile_agent.dart';
import 'package:dips/presentation/authentication/create_new_password_screen.dart';
import 'package:dips/presentation/authentication/forgot_password.dart';
import 'package:dips/presentation/authentication/login_screen.dart';
import 'package:dips/presentation/authentication/otp_verify_screen.dart';
import 'package:dips/presentation/authentication/signup_screen.dart';
import 'package:dips/presentation/authentication/singup_agent_screen.dart';
import 'package:dips/presentation/authentication/success_password_screen.dart';
import 'package:dips/presentation/chatbot/chatbot_page.dart';
import 'package:dips/presentation/common/privacy_policy.dart';
import 'package:dips/presentation/common/terms_condition.dart';
import 'package:dips/presentation/splash_screen/get_started_screen.dart';
import 'package:dips/presentation/splash_screen/splash_screen.dart';
import 'package:dips/presentation/user/favourite/favourite_screen.dart';
import 'package:dips/presentation/user/home/home_screen.dart';
import 'package:dips/presentation/user/home/property_details_screen.dart';
import 'package:dips/presentation/user/home/qr_scanner_screen.dart';
import 'package:dips/presentation/user/home/scanner_result_screen.dart';
import 'package:dips/presentation/user/landing_page/landing_screen.dart';
import 'package:dips/presentation/user/profile/edit_account_screen.dart';
import 'package:dips/presentation/user/profile/my_properties_screen.dart';
import 'package:dips/presentation/user/profile/profile_screen.dart';
import 'package:dips/presentation/user/search/search_screen.dart';
import 'package:go_router/go_router.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AppRouter {
  static Future<GoRouter> createRouter() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    final role = prefs.getString('role');

    final inital = (token != null && token.isNotEmpty)
        ? (role == 'buyer' ? RoutePath.home : RoutePath.homeAgent)
        : RoutePath.login;
    return GoRouter(
      initialLocation: inital,
      debugLogDiagnostics: true,
      routes: [
        GoRoute(
          path: RoutePath.splash,
          name: 'splash',
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path: RoutePath.getStarted,
          name: 'get-started',
          builder: (context, state) => const GetStartedScreen(),
        ),

        // //authentication
        GoRoute(
          path: RoutePath.login,
          name: 'login',
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: RoutePath.signUp,
          name: 'signUp',
          builder: (context, state) => const SignupScreen(),
        ),
        GoRoute(
          path: RoutePath.signUpAgent,
          name: 'signUp-agent',
          builder: (context, state) => const SingupAgentScreen(),
        ),
        GoRoute(
          path: RoutePath.forgotPassword,
          name: 'forgotPassword',
          builder: (context, state) {
            final data = state.extra as bool;
            return ForgotPassword(isUser: data);
          },
        ),
        GoRoute(
          path: RoutePath.verifyOtp,
          name: 'verifyOtp',
          builder: (context, state) {
            final data = state.extra as bool;
            return OtpVerifyScreen(isUser: data);
          },
        ),
        GoRoute(
          path: RoutePath.createNewPassword,
          name: 'createNewPassword',
          builder: (context, state) {
            final data = state.extra as Map<String, dynamic>;

            final String email = data["email"];
            final String otp = data["otp"];
            final bool isUser = data["is_user"];

            return CreateNewPasswordScreen(
              email: email,
              otp: otp,
              isUser: isUser,
            );
          },
        ),

        GoRoute(
          path: RoutePath.successPasswordChanged,
          name: 'successPassowrdChanges',
          builder: (context, state) => const SuccessPasswordScreen(),
        ),
        GoRoute(
          path: RoutePath.editProfile,
          name: 'editProfile',
          builder: (context, state) => const EditAccountScreen(),
        ),
        GoRoute(
          path: RoutePath.myProperties,
          name: 'myProperties',
          builder: (context, state) => const MyPropertiesScreen(),
        ),
        GoRoute(
          path: RoutePath.myPropertiesDetails,
          name: 'myPropertiesDetails',
          builder: (context, state) => const PropertyDetailScreen(),
        ),
        GoRoute(
          path: RoutePath.scanner,
          name: 'scanner',
          builder: (context, state) => const QRScanScreen(),
        ),

        GoRoute(
          path: RoutePath.resultScanner,
          name: 'resultScanner',
          builder: (context, state) => const ScannerResultScreen(),
        ),
        GoRoute(
          path: RoutePath.privacyPolicy,
          name: 'privacyPolicy',
          builder: (context, state) => const PrivacyPolicyScreen(),
        ),
        GoRoute(
          path: RoutePath.termsCondition,
          name: 'termsCondition',
          builder: (context, state) => const TermsCondition(),
        ),
        GoRoute(
          path: RoutePath.leads,
          name: 'leads',
          builder: (context, state) => const LeadsScreen(),
        ),

        //user landing page
        ShellRoute(
          builder: (context, state, child) => LandingScreen(child: child),
          routes: [
            GoRoute(
              path: RoutePath.home,
              builder: (context, state) => const HomeScreen(),
            ),
            GoRoute(
              path: RoutePath.seaerch,
              builder: (context, state) => const SearchScreen(),
            ),
            GoRoute(
              path: RoutePath.favourite,
              builder: (context, state) => const FavouriteScreen(),
            ),
            GoRoute(
              path: RoutePath.profile,
              builder: (context, state) => const ProfileScreen(),
            ),
          ],
        ),

        //agent portion
        ShellRoute(
          builder: (context, state, child) => LandingPageAgent(child: child),
          routes: [
            GoRoute(
              path: RoutePath.homeAgent,
              builder: (context, state) => const HomeAgent(),
            ),
            GoRoute(
              path: RoutePath.allProperties,
              builder: (context, state) => AllPropertiesAgent(),
            ),
            GoRoute(
              path: RoutePath.offer,
              builder: (context, state) => const OfferAgent(),
            ),
            GoRoute(
              path: RoutePath.profileAgent,
              builder: (context, state) => const ProfileAgent(),
            ),
          ],
        ),

        GoRoute(
          path: RoutePath.addProperties,
          builder: (context, state) => const AddProperitesAgent(),
        ),
        GoRoute(
          path: RoutePath.editAgentProfile,
          builder: (context, state) => const EditAgentProfile(),
        ),
        GoRoute(
          path: RoutePath.notification,
          builder: (context, state) => const NotificationsScreen(),
        ),
        GoRoute(
          path: RoutePath.offerDetails,
          builder: (context, state) => const OfferDetails(),
        ),
        GoRoute(
          path: RoutePath.chatbot,
          builder: (context, state) => const ChatBotScreen(),
        ),
      ],
    );
  }
}
