import 'dart:io';
import 'package:flutter/material.dart';
import 'package:project_mobile/helpers/api_helper.dart';
import 'package:project_mobile/ui/auth/login_page.dart';
import 'edit_profile.dart';
import 'detail_profile.dart';
import 'vendor_favorit_page.dart';
import 'riwayat_booking_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String firstName = 'Amanda';
  String lastName = 'Wijaya';
  String email = 'amandawijaya@gmail.com';
  String phone = '';
  String? photoPath;

  String get _fullName => '$firstName $lastName';

  String get _initials {
    final f = firstName.isNotEmpty ? firstName[0].toUpperCase() : '';
    final l = lastName.isNotEmpty ? lastName[0].toUpperCase() : '';
    return '$f$l';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 28),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    ProfileAvatar(
                      photoPath: photoPath,
                      initials: _initials,
                      size: 68,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _fullName,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1A1A1A),
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            email,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xFF888888),
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),
              const Divider(height: 1, color: Color(0xFFEEEEEE)),

              _MenuItem(
                label: 'Edit Profile',
                onTap: () async {
                  final result = await Navigator.push<Map<String, dynamic>>(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EditProfilePage(
                        firstName: firstName,
                        lastName: lastName,
                        email: email,
                        phone: phone,
                        photoPath: photoPath,
                      ),
                    ),
                  );
                  if (result != null) {
                    setState(() {
                      firstName = result['firstName'] ?? firstName;
                      lastName = result['lastName'] ?? lastName;
                      email = result['email'] ?? email;
                      phone = result['phone'] ?? phone;
                      photoPath = result['photoPath'];
                    });
                  }
                },
              ),

              _MenuItem(
                label: 'Detail Profile',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailProfilePage(
                        firstName: firstName,
                        lastName: lastName,
                        email: email,
                        phone: phone,
                        photoPath: photoPath,
                      ),
                    ),
                  );
                },
              ),

              _MenuItem(
                label: 'Vendor Favorit',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const VendorFavoritPage(),
                    ),
                  );
                },
              ),

              _MenuItem(
                label: 'Riwayat Booking',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => RiwayatBookingPage(
                        photoPath: photoPath,
                        initials: _initials,
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 40),
              Center(
                child: SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () => _showLogoutDialog(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF4D8D),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Logout',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Logout'),
        content: const Text('Yakin ingin keluar dari akun ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text(
              'Batal',
              style: TextStyle(color: Color(0xFF888888)),
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx); // Tutup dialog
              
              // Hapus token login lokal
              await ApiHelper.logout();
              
              if (!mounted) return;
              
              // Arahkan kembali ke halaman Login dan bersihkan riwayat navigasi
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
                (route) => false,
              );
            },
            child: const Text(
              'Logout',
              style: TextStyle(
                color: Color(0xFFFF4D8D),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


//   ProfileAvatar — support 3 kondisi:
//   1. photoPath null= tampil inisial
//   2. photoPath = file lokal = FileImage (dari image_picker)
//   3. photoPath = URL http  = NetworkImage (dari server)

class ProfileAvatar extends StatelessWidget {
  final String? photoPath;
  final String initials;
  final double size;

  const ProfileAvatar({
    super.key,
    required this.photoPath,
    required this.initials,
    this.size = 70,
  });

  @override
  Widget build(BuildContext context) {
    if (photoPath != null && photoPath!.isNotEmpty) {
      final ImageProvider imageProvider = photoPath!.startsWith('http')
          ? NetworkImage(photoPath!) as ImageProvider
          : FileImage(File(photoPath!));

      return CircleAvatar(
        radius: size / 2,
        backgroundColor: const Color(0xFFFFD6E5),
        backgroundImage: imageProvider,
      );
    }

    return CircleAvatar(
      radius: size / 2,
      backgroundColor: const Color(0xFFFFD6E5),
      child: Text(
        initials,
        style: TextStyle(
          color: const Color(0xFFE53935),
          fontWeight: FontWeight.bold,
          fontSize: size * 0.28,
          letterSpacing: 1,
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _MenuItem({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  color: Color(0xFF888888),
                  size: 22,
                ),
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Divider(height: 1, color: Color(0xFFEEEEEE)),
        ),
      ],
    );
  }
}