import 'package:calorix_app/config/theme/app_theme.dart';
import 'package:calorix_app/utils/services/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'config/di/injector.dart';
import 'config/router/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  /*WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );*/
  await initializeApp();

  runApp(
    ProviderScope(
      child: Calorix(),
    ),
  );

}
class Calorix extends StatelessWidget {
  const Calorix({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      scaffoldMessengerKey: AppSnackbar.messengerKey,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: getIt<AppRouter>().config(),
    );
  }
}
