// ignore_for_file: avoid_print, library_prefixes
import 'package:elevenlabs/elevenlabs.dart';
import 'package:flutter/material.dart';
import 'package:her_record/Providers/MainProvider.dart';
import 'package:dart_openai/dart_openai.dart';
import 'package:her_record/Widgets/UI.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize ElevenLabs
  OpenAI.apiKey = "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";
  await ElevenLabs.init(apiKey: "02494362668b3289ba4e5ee77dc42f37");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Voice Chatbot',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MainProvider()),
      ],
      child: const UI(),
    );
  }
}
