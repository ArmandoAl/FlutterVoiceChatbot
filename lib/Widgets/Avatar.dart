import 'package:flutter/material.dart';
import 'package:her_record/Providers/MainProvider.dart';
import 'package:provider/provider.dart';

class Avatar extends StatefulWidget {
  const Avatar({super.key});

  @override
  State<Avatar> createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  @override
  Widget build(BuildContext context) {
    MainProvider mainProvider =
        Provider.of<MainProvider>(context, listen: true);
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          //put this color 0xF5F5F5F5
          color: const Color.fromARGB(245, 0, 0, 0),
          image: DecorationImage(
            image: mainProvider.currentImage,
            fit: BoxFit.cover,
          )),
    );
  }
}
