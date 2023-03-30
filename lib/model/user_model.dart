import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String uid;
  String name;
  String email;
  String profileImage;

  User(
      {required this.uid,
      required this.name,
      required this.email,
      required this.profileImage});

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "username": name,
        "email": email,
        "profileImage": profileImage
      };

  static User fromJson(DocumentSnapshot snapshot) {
    var snapshotData = snapshot.data() as Map<String, dynamic>;
    return User(
        uid: snapshotData['uid'],
        name: snapshotData['username'],
        email: snapshotData['email'],
        profileImage: snapshotData['profileImage']);
  }
}
