import 'package:flutter/material.dart';
import 'package:gemini_api/Home/Service/class_service.dart';
import 'package:gemini_api/Intro_page.dart';
import 'package:gemini_api/gemini_service.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(MessageAdapter());
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => ClassService())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Echo MIND',
      home: IntroPage(),
    );
  }
}
