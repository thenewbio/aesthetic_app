import 'package:cloud_firestore/cloud_firestore.dart';
import '../utils/firestore_utils.dart';

class UserChat {
  String id;
  String photoUrl;
  String nickname;
  String aboutMe;
  String phoneNumber;

  UserChat(
      {required this.id,
      required this.photoUrl,
      required this.nickname,
      required this.aboutMe,
      required this.phoneNumber});
  Map<String, String> toJson() {
    return {
      FirestoreConstants.nickname: nickname,
      FirestoreConstants.aboutMe: aboutMe,
      FirestoreConstants.photoUrl: photoUrl,
      FirestoreConstants.phoneNumber: phoneNumber
    };
  }

  factory UserChat.fromDocument(DocumentSnapshot snap) {
    String aboutMe = "";
    String photoUrl = "";
    String nickname = "";
    String phoneNumber = "";

    try {
      aboutMe = snap.get(FirestoreConstants.aboutMe);
    } catch (e) {}
    try {
      photoUrl = snap.get(FirestoreConstants.photoUrl);
    } catch (e) {}
    try {
      nickname = snap.get(FirestoreConstants.nickname);
    } catch (e) {}
    try {
      phoneNumber = snap.get(FirestoreConstants.phoneNumber);
    } catch (e) {}
    return UserChat(
        id: snap.id,
        photoUrl: photoUrl,
        nickname: nickname,
        aboutMe: aboutMe,
        phoneNumber: phoneNumber);
  }
}
