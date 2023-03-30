import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/utils/constants.dart';

import '../model/comment_model.dart';

class CommentController extends GetxController {
  final Rx<List<Comment>> _comment = Rx<List<Comment>>([]);
  List<Comment> get comments => _comment.value;

  String postId = "";

  updatePostId(String id) {
    postId = id;
    getComment();
  }

  getComment() async {
    _comment.bindStream(firestore
        .collection('videos')
        .doc(postId)
        .collection('comments')
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      List<Comment> returnValue = [];
      for (var element in querySnapshot.docs) {
        returnValue.add(
          Comment.formJson(element),
        );
      }

      return returnValue;
    }));
  }

  postComment(String commentText) async {
    try {
      if (commentText.isNotEmpty) {
        DocumentSnapshot userDoc = await firestore
            .collection('users')
            .doc(firebaseAuth.currentUser!.uid)
            .get();
        var allDocs = await firestore
            .collection('videos')
            .doc(postId)
            .collection('comments')
            .get();
        int length = allDocs.docs.length;
        Comment comment = Comment(
            (userDoc.data()! as dynamic)['username'],
            commentText.trim(),
            DateTime.now(),
            [],
            (userDoc.data()! as dynamic)['profileImage'],
            (userDoc.data()! as dynamic)['uid'],
            "comment $length");
        await firestore
            .collection('videos')
            .doc(postId)
            .collection('comments')
            .doc('comment $length')
            .set(comment.toJson());
        // DocumentSnapshot doc =
        //     await firestore.collection('videos').doc(postId).get();
        await firestore.collection('videos').doc(postId).update({
          'commentCount': length + 1,
        });
      }
    } catch (e) {
      Get.snackbar('Error While Commenting', e.toString());
    }
  }

  likeComment(String id) async {
    var uid = firebaseAuth.currentUser!.uid;
    DocumentSnapshot doc = await firestore
        .collection('videos')
        .doc(postId)
        .collection('comments')
        .doc(id)
        .get();

    if ((doc.data() as dynamic)['likes'].contains(uid)) {
      await firestore
          .collection('videos')
          .doc(postId)
          .collection('comments')
          .doc(id)
          .update({
        'likes': FieldValue.arrayRemove([uid]),
      });
    } else {
      await firestore
          .collection('videos')
          .doc(postId)
          .collection('comments')
          .doc(id)
          .update({
        'likes': FieldValue.arrayUnion([uid]),
      });
    }
  }
}
