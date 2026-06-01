import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flickreview/firebase_options.dart';

import 'package:flickreview/screens/change_password_screen.dart';
import 'package:flickreview/screens/edit_profile_screen.dart';
import 'package:flickreview/screens/favorite_screen.dart';
import 'package:flickreview/screens/home_screen.dart';
import 'package:flickreview/screens/profile_screen.dart';
import 'package:flickreview/screens/setting_screen.dart';
import 'package:flickreview/screens/sign_in_screen.dart';
import 'package:flickreview/screens/sign_up_screen.dart';
import 'package:flickreview/screens/auth_gate.dart';

import 'dart:convert';
import 'package:flickreview/screens/review_screen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

import 'theme/theme_controller.dart';
import 'helper/locale_provider.dart';

import 'l10n/app_localizations.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ================= FIREBASE INIT =================
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );
  await FirebaseMessaging.instance.subscribeToTopic('flickreview_reviews');
  final token = await FirebaseMessaging.instance.getToken();
  FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return;

    await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
      'fcmToken': newToken,
      'fcmTokenUpdatedAt': Timestamp.now(),
    });
  });

  debugPrint("FCM TOKEN:");
  debugPrint(token);
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (response) {
      final payload = response.payload;

      if (payload == null || payload.isEmpty) return;

      final data = jsonDecode(payload) as Map<String, dynamic>;

      openReviewFromNotification(data);
    },
  );
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    final title = message.data['title'] ?? 'FlickReview';
    final body = message.data['body'] ?? '';
    final profileImageUrl = message.data['profileImageUrl'] ?? '';

    final avatarBitmap = await getAvatarBitmap(profileImageUrl);

    await flutterLocalNotificationsPlugin.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'flickreview_channel',
          'FlickReview Notifications',
          importance: Importance.max,
          priority: Priority.high,
          largeIcon: avatarBitmap,
        ),
      ),
      payload: jsonEncode({
        'movieId': message.data['movieId'] ?? '',
        'reviewId': message.data['reviewId'] ?? '',
      }),
    );
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    openReviewFromNotification(message.data);
  });

  final initialMessage = await FirebaseMessaging.instance.getInitialMessage();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeController()),

        ChangeNotifierProvider(create: (_) => LocaleProvider()),
      ],

      child: const MyApp(),
    ),
  );

  if (initialMessage != null) {
    Future.delayed(const Duration(milliseconds: 500), () {
      openReviewFromNotification(initialMessage.data);
    });
  }
}

Future<void> openReviewFromNotification(Map<String, dynamic> data) async {
  final movieId = data['movieId'];
  final reviewId = data['reviewId'];

  if (movieId == null || reviewId == null) return;
  if (movieId.toString().isEmpty || reviewId.toString().isEmpty) return;

  final reviewDoc = await FirebaseFirestore.instance
      .collection('movie_reviews')
      .doc(movieId)
      .collection('reviews')
      .doc(reviewId)
      .get();

  if (!reviewDoc.exists) return;

  final reviewData = reviewDoc.data() as Map<String, dynamic>;
  reviewData['reviewId'] = reviewDoc.id;

  navigatorKey.currentState?.push(
    MaterialPageRoute(builder: (_) => ReviewScreen(reviewData: reviewData)),
  );
}

Future<ByteArrayAndroidBitmap?> getAvatarBitmap(String imageUrl) async {
  if (imageUrl.isEmpty) return null;

  try {
    final response = await http.get(Uri.parse(imageUrl));

    if (response.statusCode == 200) {
      return ByteArrayAndroidBitmap(response.bodyBytes);
    }
  } catch (e) {
    debugPrint("AVATAR NOTIFICATION ERROR: $e");
  }

  return null;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      locale: context.watch<LocaleProvider>().locale,

      localizationsDelegates: const [
        AppLocalizations.delegate,

        GlobalMaterialLocalizations.delegate,

        GlobalWidgetsLocalizations.delegate,

        GlobalCupertinoLocalizations.delegate,
      ],

      supportedLocales: const [Locale('en'), Locale('id'), Locale('ja')],

      debugShowCheckedModeBanner: false,

      title: 'FlickReview',

      // ================= LIGHT THEME =================
      theme: ThemeData(
        brightness: Brightness.light,

        useMaterial3: true,

        scaffoldBackgroundColor: Colors.white,

        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),

        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.deepPurple,

          iconTheme: IconThemeData(color: Colors.deepPurple),

          titleTextStyle: TextStyle(
            color: Colors.deepPurple,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        iconTheme: const IconThemeData(color: Colors.deepPurple),

        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,

          selectedItemColor: Colors.deepPurple,

          unselectedItemColor: Colors.deepPurple,

          elevation: 0,

          showUnselectedLabels: true,
        ),
      ),

      // ================= DARK THEME =================
      darkTheme: ThemeData(
        brightness: Brightness.dark,

        useMaterial3: true,

        scaffoldBackgroundColor: const Color(0xFF1F1B2E),

        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF8B5CF6),

          surface: Color(0xFF8B5CF6),

          onPrimary: Colors.white,

          onSurface: Colors.white,
        ),

        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF8B5CF6),

          foregroundColor: Colors.white,

          iconTheme: IconThemeData(color: Colors.white),
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF8B5CF6),

            foregroundColor: Colors.white,

            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        drawerTheme: const DrawerThemeData(backgroundColor: Color(0xFF1F1B2E)),

        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF8B5CF6),

          selectedItemColor: Colors.white,

          unselectedItemColor: Color(0xFF1F1B2E),

          showUnselectedLabels: true,
        ),

        cardTheme: const CardThemeData(color: Color(0xFF8B5CF6)),

        dialogTheme: const DialogThemeData(backgroundColor: Color(0xFF1F1B2E)),
      ),

      // ================= THEME MODE =================
      themeMode: context.watch<ThemeController>().themeMode,

      // ================= HOME =================
      home: const AuthGate(),

      // ================= ROUTES =================
      routes: {
        '/signin': (context) => const SignInScreen(),

        '/signup': (context) => const SignUpScreen(),

        '/edit-profile': (context) => const EditProfileScreen(),

        '/setting': (context) => const SettingScreen(),

        '/change-password': (context) => const ChangePasswordScreen(),
      },
    );
  }
}

// ================= MAIN SCREEN =================
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),

    FavoriteScreen(),

    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],

      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(canvasColor: Colors.transparent),

        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),

            topRight: Radius.circular(20),
          ),

          child: BottomNavigationBar(
            currentIndex: _currentIndex,

            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },

            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.home),

                label: AppLocalizations.of(context)!.home,
              ),

              BottomNavigationBarItem(
                icon: const Icon(Icons.favorite),

                label: AppLocalizations.of(context)!.favorite,
              ),

              BottomNavigationBarItem(
                icon: const Icon(Icons.person),

                label: AppLocalizations.of(context)!.profile,
              ),
            ],

            showUnselectedLabels: true,
          ),
        ),
      ),
    );
  }
}
