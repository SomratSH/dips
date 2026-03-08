import 'package:dips/core/routing/app_router.dart';
import 'package:dips/provider_list.dart';
import 'package:dips/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final router = await AppRouter.createRouter();
  setupServiceLocator();
  runApp(MyApp(router: router));
}

class MyApp extends StatelessWidget {
  final GoRouter router;
  const MyApp({super.key, required this.router});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: AppProvider.provider,
      child: MaterialApp.router(
        routerConfig: router,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF041E41)),
          primaryColor: Color(0xFFE63946),
        ),
      ),
    );
  }
}
