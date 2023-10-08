// ignore_for_file: avoid_print, file_names
import 'package:dart_openai/dart_openai.dart';
import 'package:her_record/Providers/MainProvider.dart';

Future<void> recognizeVoice(MainProvider provider) async {
  final result = await OpenAI.instance.audio.createTranscription(
    file: provider.audioFile,
    model: "whisper-1",
    responseFormat: OpenAIAudioResponseFormat.json,
  );

  provider.text = result.text;
}
