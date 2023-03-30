import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/screens/confirm_screen.dart';

import 'package:tiktok_clone/utils/constants.dart';

class AddVideoScreen extends StatelessWidget {
  const AddVideoScreen({super.key});

  pickVideo(ImageSource src, BuildContext context) async {
    final video = await ImagePicker().pickVideo(source: src);
    if (video != null) {
      Get.to(ConfirmScreen(videoFile: File(video.path), videoPath: video.path));
    }
  }

  showDialogOptions(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => SimpleDialog(
              children: [
                SimpleDialogOption(
                  onPressed: () => pickVideo(ImageSource.gallery, context),
                  child: Row(
                    children: const [
                      Icon(Icons.image),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Gallary'),
                      )
                    ],
                  ),
                ),
                SimpleDialogOption(
                  onPressed: () => pickVideo(ImageSource.camera, context),
                  child: Row(
                    children: const [
                      Icon(Icons.camera),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Camera'),
                      )
                    ],
                  ),
                ),
                SimpleDialogOption(
                  onPressed: () => Get.back(),
                  child: Row(
                    children: const [
                      Icon(Icons.cancel),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Cancel'),
                      )
                    ],
                  ),
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () => showDialogOptions(context),
          child: Container(
            width: mediaQuery.width * 0.4,
            height: mediaQuery.height * 0.05,
            color: buttonColor,
            child: const Center(
              child: Text(
                'Add Video',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
