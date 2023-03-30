import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/controller/auth_controller.dart';
import 'package:tiktok_clone/model/video_model.dart';
import 'package:tiktok_clone/utils/constants.dart';

class VideoController extends GetxController {
  final AuthController authController = Get.put(AuthController());
  final Rx<List<Video>> _videoList = Rx<List<Video>>([]);
  List<Video> get videoList => _videoList.value;

  @override
  void onInit() {
    super.onInit();
    _videoList.bindStream(firestore
        .collection('videos')
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      List<Video> returnValue = [];
      for (var element in querySnapshot.docs) {
        returnValue.add(Video.fromJson(element));
      }
      return returnValue;
    }));
  }

  likeVideo(String id) async {
    DocumentSnapshot? doc = await firestore.collection('videos').doc(id).get();
    var uid = authController.user!.uid;
    if ((doc.data() as dynamic)['likes'].contains(uid)) {
      await firestore.collection('videos').doc(id).update({
        'likes': FieldValue.arrayRemove([uid]),
      });
    } else {
      await firestore.collection('videos').doc(id).update({
        'likes': FieldValue.arrayUnion([uid]),
      });
    }
  }
}
