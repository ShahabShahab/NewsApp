import 'dart:io';

import 'package:code_challenge_news_app/features/splash/cubit/splash_cubit.dart';
import 'package:code_challenge_news_app/features/splash/pages/splash_page.dart';
import 'package:domain_layer/domain_layer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injection_layer/injection_layer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:resourcing/resourcing.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
  await initDependencies(
    localDateBaseDirectory: appDocumentsDir.path,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          fontFamily: NewsFonts.mainFont,
          scaffoldBackgroundColor: NewsColors.white),
      themeMode: ThemeMode.light,
      home: BlocProvider(
        create: (_) => SplashCubit(
            GetAppConfig(splashRepository: resolve<SplashRepository>())),
        child: SplashPage(),
      ),
    );
  }
}
