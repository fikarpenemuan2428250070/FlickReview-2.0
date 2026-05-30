import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flickreview/widgets/profile_info_item.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        title: const Text('Konfirmasi'),
        content: const Text('Apakah kamu yakin ingin keluar dari akun ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Keluar'),
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
                          child: const Text('Sign In'),
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
                                label: 'Username',
                                value: userName,
                                iconColor: Colors.amber,
                              ),

                              const SizedBox(height: 4),
                              Divider(color: Colors.deepPurple[100]),
                              const SizedBox(height: 4),

                              ProfileInfoItem(
                                icon: Icons.person,
                                label: 'Fullname',
                                value: fullName,
                                iconColor: Colors.blue,
                              ),

                              const SizedBox(height: 4),
                              Divider(color: Colors.deepPurple[100]),
                              const SizedBox(height: 4),

                              ProfileInfoItem(
                                icon: Icons.info_outline,
                                label: 'Bio',
                                value: bio.isNotEmpty ? bio : '-',
                                iconColor: Colors.green,
                              ),

                              const SizedBox(height: 4),
                              Divider(color: Colors.deepPurple[100]),
                              const SizedBox(height: 4),

                              ProfileInfoItem(
                                icon: Icons.favorite,
                                label: 'Favorite',
                                value: '$favoriteMovieCount Item(s)',
                                iconColor: Colors.red,
                              ),

                              const SizedBox(height: 4),
                              Divider(color: Colors.deepPurple[100]),
                              const SizedBox(height: 20),

                              TextButton(
                                onPressed: () => confirmSignOut(context),
                                child: const Text('Sign Out'),
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
