import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flickreview/widgets/profile_info_item.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flickreview/l10n/app_localizations.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<int> getFavoriteCount(String uid) async {
    final prefs = await SharedPreferences.getInstance();
    final favList = prefs.getStringList("favorites_$uid") ?? [];
    return favList.length;
  }

  Widget buildAvatar(String? profileImageUrl) {
    if (profileImageUrl != null && profileImageUrl.isNotEmpty) {
      return CircleAvatar(
        radius: 50,
        backgroundImage: NetworkImage(profileImageUrl),
      );
    }

    return const CircleAvatar(
      radius: 50,
      backgroundImage: AssetImage('images/placeholder_image.png'),
    );
  }

  Future<void> confirmSignOut(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.confirm),
        content: Text(AppLocalizations.of(context)!.logoutMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(context, true),
            child: Text(AppLocalizations.of(context)!.logout),
          ),
        ],
      ),
    );

    if (result == true) {
      await FirebaseAuth.instance.signOut();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, authSnapshot) {
        final user = authSnapshot.data;

        if (authSnapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (user == null) {
          return Scaffold(
            body: SizedBox.expand(
              child: Stack(
                children: [
                  Container(
                    height: 200,
                    width: double.infinity,
                    color: isDark
                        ? const Color(0xFF1F1B2E)
                        : const Color(0xFF8B5CF6),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: EdgeInsets.only(top: 150),
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: AssetImage(
                                'images/placeholder_image.png',
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        Divider(color: Colors.deepPurple[100]),

                        const SizedBox(height: 20),

                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/signin');
                          },
                          child: Text(AppLocalizations.of(context)!.signIn),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return FutureBuilder<int>(
          future: getFavoriteCount(user.uid),

          builder: (context, favSnapshot) {
            final favoriteMovieCount = favSnapshot.data ?? 0;

            return StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(user.uid)
                  .snapshots(),

              builder: (context, userSnapshot) {
                final data = userSnapshot.data?.data() as Map<String, dynamic>?;

                final fullName = data?['fullname'] ?? '';

                final userName = data?['username'] ?? '';

                final bio = data?['bio'] ?? '';

                final profileImageUrl = data?['profileImageUrl'];

                return Scaffold(
                  body: SizedBox.expand(
                    child: Stack(
                      children: [
                        Container(
                          height: 200,
                          width: double.infinity,
                          color: isDark
                              ? const Color(0xFF1F1B2E)
                              : const Color(0xFF8B5CF6),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),

                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.topCenter,

                                child: Padding(
                                  padding: const EdgeInsets.only(top: 150),

                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.deepPurple,

                                        width: 2,
                                      ),

                                      shape: BoxShape.circle,
                                    ),

                                    child: buildAvatar(profileImageUrl),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 20),

                              Divider(color: Colors.deepPurple[100]),

                              const SizedBox(height: 4),

                              ProfileInfoItem(
                                icon: Icons.lock,

                                label: AppLocalizations.of(context)!.username,

                                value: userName,

                                iconColor: Colors.amber,
                              ),

                              const SizedBox(height: 4),

                              Divider(color: Colors.deepPurple[100]),

                              const SizedBox(height: 4),

                              ProfileInfoItem(
                                icon: Icons.person,

                                label: AppLocalizations.of(context)!.fullnameLabel,

                                value: fullName,

                                iconColor: Colors.blue,
                              ),

                              const SizedBox(height: 4),

                              Divider(color: Colors.deepPurple[100]),

                              const SizedBox(height: 4),

                              ProfileInfoItem(
                                icon: Icons.info_outline,

                                label: AppLocalizations.of(context)!.bio,

                                value: bio.isNotEmpty ? bio : '-',

                                iconColor: Colors.green,
                              ),

                              const SizedBox(height: 4),

                              Divider(color: Colors.deepPurple[100]),

                              const SizedBox(height: 4),

                              ProfileInfoItem(
                                icon: Icons.favorite,

                                label: AppLocalizations.of(context)!.favorite,

                                value: '$favoriteMovieCount ${AppLocalizations.of(context)!.favoritesCount}',

                                iconColor: Colors.red,
                              ),

                              const SizedBox(height: 4),

                              Divider(color: Colors.deepPurple[100]),

                              const SizedBox(height: 20),

                              TextButton(
                                onPressed: () => confirmSignOut(context),

                                child: Text(
                                  AppLocalizations.of(context)!.logout,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Positioned(
                          top: 16,
                          right: 16,

                          child: SafeArea(
                            child: CircleAvatar(
                              radius: 20,

                              backgroundColor: Colors.white,

                              child: IconButton(
                                padding: EdgeInsets.zero,

                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.deepPurple,
                                  size: 20,
                                ),

                                onPressed: () {
                                  Navigator.pushNamed(context, '/edit-profile');
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
