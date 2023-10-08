// ignore_for_file: file_names

import 'dart:io';
import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:her_record/functions/audioFunctions.dart';
import 'package:her_record/functions/chatgptFunctions.dart';
import 'package:her_record/functions/recorderFuctions.dart';
import 'package:her_record/functions/whisperFunctions.dart';
import 'package:just_audio/just_audio.dart';

class MainProvider extends ChangeNotifier {
  FlutterSoundRecorder audioRecorder = FlutterSoundRecorder();
  AudioPlayer player = AudioPlayer();

  bool isRecording = false;
  bool isLoadingVoice = false;
  bool renderLoading = false;
  bool initialized = false;

  File audioFile = File('');
  String text = '';
  String textChatGpt = '';

  List<OpenAIChatCompletionChoiceMessageModel> messages = [
    const OpenAIChatCompletionChoiceMessageModel(
      content:
          "You are a helpful chatbot. Answer must not be too long. And be kind to the user with your answer. And always answer in spanish.",
      role: OpenAIChatMessageRole.system,
    ),
  ];

  Future<void> inicialice() async {
    await inicialiceRecord(this);
    initialized = true;
    notifyListeners();
  }

  Future<void> start() async {
    await startRecorder(this);
    notifyListeners();
  }

  Future<void> stop() async {
    await stopRecorder(this);
    notifyListeners();
  }

  Future<void> recognize() async {
    await recognizeVoice(this);
    messages.add(
      OpenAIChatCompletionChoiceMessageModel(
        content: text,
        role: OpenAIChatMessageRole.user,
      ),
    );
    notifyListeners();
  }

  Future<void> sendToChatGpt() async {
    textChatGpt = await textToChatGopt(this);
    messages.add(
      OpenAIChatCompletionChoiceMessageModel(
        content: textChatGpt,
        role: OpenAIChatMessageRole.assistant,
      ),
    );
    notifyListeners();
  }

  Future<void> speak() async {
    await speakText(this);
    renderLoading = false;
    notifyListeners();
  }
}
