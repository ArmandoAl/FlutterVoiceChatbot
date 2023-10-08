// ignore_for_file: file_names, avoid_print
import 'dart:typed_data';
import 'package:her_record/Providers/MainProvider.dart';
import 'package:just_audio/just_audio.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

Future speakText(MainProvider provider) async {
  try {
    final player = AudioPlayer();
    final bytes = await _fetch(provider.textChatGpt);
    player.setAudioSource(MyCustomSource(bytes));
    player.play();
  } catch (ex) {
    print('Error: $ex');
  }
}

Future<Uint8List> _fetch(String text) async {
  const voiceId = 'd8hRaxoDmTxv8uqh2Cxo';
  const url = 'https://api.elevenlabs.io/v1/text-to-speech/$voiceId';
  final response = await http.post(
    Uri.parse(url),
    headers: {
      'xi-api-key': "02494362668b3289ba4e5ee77dc42f37",
      'Content-Type': 'application/json',
      'accept': 'audio/mpeg',
    },
    body: convert.json.encode({
      "text": text,
      "model_id": "eleven_multilingual_v2",
      "voice_settings": {
        "stability": 0.4,
        "similarity_boost": 0,
      },
    }),
  );
  if (response.statusCode != 200) {
    throw Exception('Eleven Labs API Failed.');
  }
  return response.bodyBytes;
}

class MyCustomSource extends StreamAudioSource {
  final List<int> bytes;
  MyCustomSource(this.bytes);

  @override
  Future<StreamAudioResponse> request([int? start, int? end]) async {
    start ??= 0;
    end ??= bytes.length;
    return StreamAudioResponse(
      sourceLength: bytes.length,
      contentLength: end - start,
      offset: start,
      stream: Stream.value(bytes.sublist(start, end)),
      contentType: 'audio/mpeg',
    );
  }
}
