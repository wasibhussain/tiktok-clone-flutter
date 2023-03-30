import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/model/user_model.dart' as model;
import 'package:tiktok_clone/screens/home_screen.dart';
import 'package:tiktok_clone/screens/login_screen.dart';
import 'package:tiktok_clone/utils/constants.dart';

class AuthController extends GetxController {
  late Rx<File?> _pickedImage;
  late Rx<User?> _user;
  User? get user => _user.value;
  File? get profilePhoto => _pickedImage.value;

  @override
  void onReady() {
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, _selectInitialScreen);
  }

  _selectInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(LogInScreen());
    } else {
      Get.offAll(const HomeScreen());
    }
  }

  void pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _pickedImage = Rx<File?>(File(pickedFile.path));
    }
  }

  Future<String> _uploadToStorage(File image) async {
    Reference reference = firebaseStorage
        .ref()
        .child('profileImage')
        .child(firebaseAuth.currentUser!.uid);
    UploadTask uploadTask = reference.putFile(image);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  void register(String name, String email, String password, File? image) async {
    try {
      if (name.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        UserCredential credential =
            await firebaseAuth.createUserWithEmailAndPassword(
                email: email.trim(), password: password);
        String downloadUrl = await _uploadToStorage(image);
        model.User user = model.User(
            uid: credential.user!.uid,
            name: name,
            email: email,
            profileImage: downloadUrl);
        firestore
            .collection('users')
            .doc(credential.user!.uid)
            .set(user.toJson());
      } else {
        Get.snackbar('Regiter Failed', 'Please enter all credientials');
      }
    } catch (e) {
      Get.snackbar('Something went wrong', e.toString());
      print(e.toString());
    }
  }

  void login(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email.trim(), password: password);
        print('Succes');
      } else {
        Get.snackbar('Login Failed', 'Please enter valid email and password');
      }
    } catch (e) {
      Get.snackbar('Something went wrong', e.toString());
      print(e.toString());
    }
  }
}
