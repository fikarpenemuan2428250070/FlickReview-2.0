import 'dart:convert';
import 'package:http/http.dart' as http;

class NotificationService {
  static const String baseUrl = 'https://flickreview-cloude-snvo.vercel.app';

  // ================= TOPIC =================
  static Future<void> sendReviewNotification({
    required String fullname,
    required String username,
    required String movieTitle,
    required String movieYear,
    required String profileImageUrl,
    required String movieId,
    required String reviewId,
  }) async {
    final url = Uri.parse('$baseUrl/send-to-topic');

    final body = {
      "topic": "flickreview_reviews",
      "title": "FlickReview",
      "body":
          "$fullname (@$username) has written a review for $movieTitle($movieYear). Tap to read the review.",
      "profileImageUrl": profileImageUrl,
      "movieId": movieId,
      "reviewId": reviewId,
    };

    await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );
  }

  // ================= DEVICE =================
  static Future<void> sendToDevice({
    required String token,
    required String fullname,
    required String username,
    required String movieTitle,
    required String movieYear,
    required String profileImageUrl,
    required String movieId,
    required String reviewId,
  }) async {
    final url = Uri.parse('$baseUrl/send-to-device');

    final body = {
      "token": token,
      "title": "FlickReview",
      "body":
          "$fullname (@$username) has written a review for $movieTitle ($movieYear). Tap to read the review.",
      "profileImageUrl": profileImageUrl,
      "movieId": movieId,
      "reviewId": reviewId,
    };

    await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );
  }
}
