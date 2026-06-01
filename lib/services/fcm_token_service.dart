import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FcmTokenService {
  static Future<void> saveCurrentUserFcmToken() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return;

    final token = await FirebaseMessaging.instance.getToken();

    if (token == null || token.isEmpty) return;

    await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
      'fcmToken': token,
      'fcmTokenUpdatedAt': Timestamp.now(),
    });
  }
}