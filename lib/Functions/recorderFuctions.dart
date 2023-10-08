// ignore_for_file: file_names, avoid_print

import 'dart:io';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:her_record/Providers/MainProvider.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> inicialiceRecord(MainProvider provider) async {
  final status = await Permission.microphone.request();
  if (status != PermissionStatus.granted) {
    throw RecordingPermissionException('Microphone permission not granted');
  }
  await provider.audioRecorder.openRecorder();

  provider.audioRecorder
      .setSubscriptionDuration(const Duration(milliseconds: 100));
}

Future<void> startRecorder(MainProvider provider) async {
  provider.isLoadingVoice = true;

  if (!provider.isLoadingVoice) return;

  await provider.audioRecorder.startRecorder(
    toFile: 'test.mp4',
    codec: Codec.aacMP4,
  );
}

Future<void> stopRecorder(MainProvider provider) async {
  final path = await provider.audioRecorder.stopRecorder();
  final audioFile = File(path!);

  provider.audioFile = audioFile;
  provider.isLoadingVoice = false;
  provider.renderLoading = true;
}
