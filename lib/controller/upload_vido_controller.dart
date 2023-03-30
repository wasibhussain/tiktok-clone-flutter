import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/model/video_model.dart';
import 'package:tiktok_clone/utils/constants.dart';
import 'package:video_compress/video_compress.dart';

class UploadVideoController extends GetxController {
  circularLoadingIndicator() {
    return Container(
      width: 300,
      height: 100,
      color: Colors.white,
      child: const Center(child: CircularProgressIndicator()),
    );
  }

  _compressedFile(String videoPath) async {
    final compressedVideo = await VideoCompress.compressVideo(videoPath,
        quality: VideoQuality.DefaultQuality);
    return compressedVideo!.file;
  }

  _getThumbnail(String videoPath) async {
    final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
    return thumbnail;
  }

  Future<String> _uploadVideoToStorage(String id, String videoPath) async {
    Reference reference = firebaseStorage.ref().child('videos').child(id);
    UploadTask task = reference.putFile(await _compressedFile(videoPath));
    TaskSnapshot taskSnapshot = await task;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> _uploadThumbnailToStorage(String id, String videoPath) async {
    Reference reference = firebaseStorage.ref().child('thumbnails').child(id);
    UploadTask task = reference.putFile(await _getThumbnail(videoPath));
    TaskSnapshot taskSnapshot = await task;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  uploadVideo(String songName, String caption, String videoPath) async {
    try {
      String uid = firebaseAuth.currentUser!.uid;
      DocumentSnapshot userDoc =
          await firestore.collection('users').doc(uid).get();
      var allDocs = await firestore.collection('videos').get();
      int length = allDocs.docs.length;
      String videoUrl = await _uploadVideoToStorage('Video $length', videoPath);
      String thumbnail =
          await _uploadThumbnailToStorage('Image $length', videoPath);

      Video video = Video(
          username: (userDoc.data() as Map<String, dynamic>)['username'],
          uid: uid,
          videoId: 'Video $length',
          likes: [],
          commentCount: 0,
          shareCount: 0,
          songName: songName,
          caption: caption,
          videoUrl: videoUrl,
          thumbnail: thumbnail,
          profilePhoto:
              (userDoc.data() as Map<String, dynamic>)['profileImage']);

      await firestore
          .collection('videos')
          .doc('Video $length')
          .set(video.toJson());
      circularLoadingIndicator();
      Get.back();
    } catch (e) {
      Get.snackbar('Error Uploaing Video', e.toString());
    }
  }
}
