// ignore_for_file: file_names

import 'package:dart_openai/dart_openai.dart';
import 'package:her_record/Providers/MainProvider.dart';

Future<String> textToChatGopt(MainProvider provider) async {
  OpenAIChatCompletionModel chatCompletion = await OpenAI.instance.chat.create(
    model: "gpt-3.5-turbo",
    maxTokens: 200,
    messages: provider.messages,
  );

  return chatCompletion.choices.first.message.content;
}
