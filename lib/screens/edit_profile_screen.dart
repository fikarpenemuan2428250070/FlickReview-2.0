import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flickreview/services/cloudinary_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flickreview/l10n/app_localizations.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _bioController = TextEditingController();

  final User? user = FirebaseAuth.instance.currentUser;
  final ImagePicker _picker = ImagePicker();

  bool isLoading = false;

  String oldUsername = '';
  String? profileImageUrl;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    if (user == null) return;

    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .get();

      final data = doc.data();

      if (data != null) {
        setState(() {
          _nameController.text = data['fullname'] ?? '';
          _usernameController.text = data['username'] ?? '';
          _bioController.text = data['bio'] ?? '';
          oldUsername = data['username'] ?? '';
          profileImageUrl = data['profileImageUrl'];
        });
      }
    } catch (e) {
      debugPrint("LOAD PROFILE ERROR: $e");
    }
  }

  Future<void> _pickProfileImage(ImageSource source) async {
    if (user == null) return;

    final l10n = AppLocalizations.of(context)!;

    try {
      final XFile? pickedImage = await _picker.pickImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (pickedImage == null) return;

      setState(() {
        isLoading = true;
      });

      final file = File(pickedImage.path);

      final imageUrl = await CloudinaryService.uploadProfileImage(file);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .update({'profileImageUrl': imageUrl});

      setState(() {
        profileImageUrl = imageUrl;
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.profileImageUpdated)),
      );
    } catch (e) {
      debugPrint("UPLOAD IMAGE ERROR: $e");

      final l10n = AppLocalizations.of(context)!;

      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.profileImageUploadFailed)));
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> _deleteProfileImage() async {
    if (user == null) return;

    final l10n = AppLocalizations.of(context)!;

    try {
      setState(() {
        isLoading = true;
      });

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .update({'profileImageUrl': null});

      setState(() {
        profileImageUrl = null;
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.profileImageDeleted)),
      );
    } catch (e) {
      debugPrint("DELETE PROFILE IMAGE ERROR: $e");

      final l10n = AppLocalizations.of(context)!;

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.profileImageDeleteFailed)),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  void _showImageOptions() {
    final l10n = AppLocalizations.of(context)!;

    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: Text(l10n.takeFromCamera),
              onTap: () {
                Navigator.pop(context);
                _pickProfileImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: Text(l10n.chooseFromGallery),
              onTap: () {
                Navigator.pop(context);
                _pickProfileImage(ImageSource.gallery);
              },
            ),
            if (profileImageUrl != null && profileImageUrl!.isNotEmpty)
              ListTile(
                leading: const Icon(Icons.delete),
                title: Text(l10n.deleteProfilePhoto),
                onTap: () {
                  Navigator.pop(context);
                  _deleteProfileImage();
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    if (profileImageUrl != null && profileImageUrl!.isNotEmpty) {
      return CircleAvatar(
        radius: 55,
        backgroundImage: NetworkImage(profileImageUrl!),
      );
    }

    return const CircleAvatar(
      radius: 55,
      backgroundImage: AssetImage('images/placeholder_image.png'),
    );
  }

  Future<void> _saveProfile() async {
    if (user == null) return;

    final l10n = AppLocalizations.of(context)!;

    final newName = _nameController.text.trim();
    final newUsername = _usernameController.text.trim().toLowerCase();
    final newBio = _bioController.text.trim();

    if (newName.isEmpty || newUsername.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.fullnameRequired)),
      );
      return;
    }

    if (!RegExp(r'^[a-z0-9_\.]+$').hasMatch(newUsername)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.usernameFormat),
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      if (newUsername != oldUsername) {
        final newUsernameRef = FirebaseFirestore.instance
            .collection('usernames')
            .doc(newUsername);

        final oldUsernameRef = FirebaseFirestore.instance
            .collection('usernames')
            .doc(oldUsername);

        final usernameDoc = await newUsernameRef.get();

        if (usernameDoc.exists) {
          setState(() {
            isLoading = false;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.usernameAlreadyInUse)),
          );

          return;
        }

        final batch = FirebaseFirestore.instance.batch();

        batch.set(newUsernameRef, {
          'uid': user!.uid,
          'username': newUsername,
          'email': user!.email,
          'updatedAt': Timestamp.now(),
        });

        if (oldUsername.isNotEmpty) {
          batch.delete(oldUsernameRef);
        }

        batch.update(
          FirebaseFirestore.instance.collection('users').doc(user!.uid),
          {
            'fullname': newName,
            'username': newUsername,
            'bio': newBio,
            'updatedAt': Timestamp.now(),
          },
        );

        await batch.commit();

        oldUsername = newUsername;
      } else {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .update({
              'fullname': newName,
              'username': newUsername,
              'bio': newBio,
              'updatedAt': Timestamp.now(),
            });
      }

      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.profileUpdated)));

      Navigator.pop(context, true);
    } catch (e) {
      debugPrint("SAVE PROFILE ERROR: $e");

      final l10n = AppLocalizations.of(context)!;

      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.failedToUpdateProfile)));
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.editProfile)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.deepPurple, width: 2),
                  ),
                  child: _buildAvatar(),
                ),
                CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.deepPurple,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: isLoading ? null : _showImageOptions,
                    icon: const Icon(
                      Icons.camera_alt,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: l10n.fullnameLabel),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: l10n.username),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: _bioController,
              decoration: InputDecoration(labelText: l10n.bio),
              maxLines: 3,
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading ? null : _saveProfile,
                child: isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(l10n.saveChanges),
              ),
            ),
          ],
        ),
      ),
    );
  }
}