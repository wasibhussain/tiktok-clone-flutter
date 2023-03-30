import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/model/user_model.dart';
import 'package:tiktok_clone/utils/constants.dart';

class ProfileController extends GetxController {
  final Rx<Map<String, dynamic>> _user = Rx<Map<String, dynamic>>({});
  Map<String, dynamic> get user => _user.value;
  Rx<String> _uid = "".obs;
  updateUserId(String id) {
    _uid.value = id;
    getUserData();
  }

  getUserData() async {
    List<String> thumbnails = [];
    var myVideos = await firestore
        .collection('videos')
        .where('uid', isEqualTo: _uid.value)
        .get();
    for (int i = 0; i < myVideos.docs.length; i++) {
      thumbnails.add((myVideos.docs[i].data() as dynamic)['thumbnail']);
    }

    DocumentSnapshot userDoc =
        await firestore.collection('users').doc(_uid.value).get();
    final userData = userDoc.data() as dynamic;
    String name = userData['username'];
    String profileImage = userData['profileImage'];
    int likes = 0;
    int followers = 0;
    int following = 0;

    for (var item in myVideos.docs) {
      {
        likes += (item.data()['likes'] as List).length;
      }
      var followersDoc = firestore
          .collection('users')
          .doc(_uid.value)
          .collection('followers')
          .get();
      var followingsDoc = firestore
          .collection('users')
          .doc(_uid.value)
          .collection('following')
          .get();
    }
  }
}
