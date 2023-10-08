// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:her_record/Providers/MainProvider.dart';
import 'package:her_record/Widgets/Avatar.dart';
import 'package:provider/provider.dart';

class UI extends StatefulWidget {
  const UI({super.key});

  @override
  State<UI> createState() => _UIState();
}

class _UIState extends State<UI> {
  @override
  Widget build(BuildContext context) {
    MainProvider mainProvider =
        Provider.of<MainProvider>(context, listen: true);

    if (!mainProvider.initialized) {
      mainProvider.inicialice();
    }

    if (!mainProvider.initialized) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black,
      child: Stack(
        children: [
          const Avatar(),
          Positioned(
              bottom: 50,
              right: MediaQuery.of(context).size.width / 2 - 30,
              child: FloatingActionButton(
                onPressed: mainProvider.isLoadingVoice
                    ? () async {
                        await mainProvider.stop();
                        await mainProvider.recognize();
                        await mainProvider.sendToChatGpt();
                        await mainProvider.speak();
                      }
                    : () async {
                        await mainProvider.start();
                      },
                child: mainProvider.renderLoading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : Icon(
                        mainProvider.isLoadingVoice ? Icons.stop : Icons.mic),
              ))
        ],
      ),
    ));
  }
}
