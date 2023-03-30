import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  String username;
  String comment;
  final datePublished;
  List likes;
  String profilePhoto;
  String uid;
  String id;

  Comment(this.username, this.comment, this.datePublished, this.likes,
      this.profilePhoto, this.uid, this.id);

  Map<String, dynamic> toJson() => {
        'username': username,
        'comment': comment,
        'datePublished': datePublished,
        'likes': likes,
        'profilePhoto': profilePhoto,
        'uid': uid,
        'id': id
      };

  static Comment formJson(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    return Comment(data['username'], data['comment'], data['datePublished'],
        data['likes'], data['profilePhoto'], data['uid'], data['id']);
  }
}
