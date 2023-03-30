import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/model/user_model.dart';
import 'package:tiktok_clone/utils/constants.dart';

class SearchController extends GetxController {
  Rx<List<User>> _searchUsers = Rx<List<User>>([]);
  List<User> get searchUsers => _searchUsers.value;

  searchUser(String typedUser) async {
    _searchUsers.bindStream(firestore
        .collection('users')
        .where('username', isGreaterThanOrEqualTo: typedUser)
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      List<User> returnValue = [];
      for (var element in querySnapshot.docs) {
        returnValue.add(User.fromJson(element));
      }
      return returnValue;
    }));
  }
}
