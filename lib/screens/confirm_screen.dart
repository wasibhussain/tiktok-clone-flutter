import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/controller/upload_vido_controller.dart';
import 'package:tiktok_clone/widgets/text_input_field.dart';
import 'package:video_player/video_player.dart';

class ConfirmScreen extends StatefulWidget {
  File videoFile;
  String videoPath;
  ConfirmScreen({super.key, required this.videoFile, required this.videoPath});

  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  late VideoPlayerController videoPlayerController;
  final TextEditingController songNameController = TextEditingController();
  final TextEditingController captionController = TextEditingController();
  final UploadVideoController uploadVideoController =
      Get.put(UploadVideoController());
  @override
  void initState() {
    super.initState();
    setState(() {
      videoPlayerController = VideoPlayerController.file(widget.videoFile);
    });
    videoPlayerController.initialize();
    videoPlayerController.play();
    videoPlayerController.setLooping(true);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    videoPlayerController.dispose();
    uploadVideoController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: mediaQuery.width,
              height: mediaQuery.height / 1.5,
              child: VideoPlayer(videoPlayerController),
            ),
            const SizedBox(height: 30),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: mediaQuery.width - 20,
                    child: TextInputFeild(
                        controller: songNameController,
                        labelText: 'Song Name',
                        icon: Icons.music_note),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: mediaQuery.width - 20,
                    child: TextInputFeild(
                        controller: captionController,
                        labelText: 'Caption',
                        icon: Icons.closed_caption),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                      onPressed: () => uploadVideoController.uploadVideo(
                          songNameController.text,
                          captionController.text,
                          widget.videoPath),
                      child: const Text(
                        'Share',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
