import 'package:flutter/material.dart';
import 'profile_page.dart' show ProfileAvatar;
import 'edit_profile.dart' show profileInputDecoration;

class DetailProfilePage extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String? photoPath;

  const DetailProfilePage({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.phone = '',
    this.photoPath,
  });

  String get _initials {
    final f = firstName.isNotEmpty ? firstName[0].toUpperCase() : '';
    final l = lastName.isNotEmpty ? lastName[0].toUpperCase() : '';
    return '$f$l';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 48,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Color(0xFF1A1A1A), size: 22),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'Detail Profile',
          style: TextStyle(
            color: Color(0xFF1A1A1A),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: photoPath != null && photoPath!.isNotEmpty
                  ? Stack(
                      clipBehavior: Clip.none,
                      children: [
                        ProfileAvatar(
                          photoPath: photoPath,
                          initials: _initials,
                          size: 90,
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            width: 28,
                            height: 28,
                            decoration: const BoxDecoration(
                              color: Color(0xFFE53935),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 15,
                            ),
                          ),
                        ),
                      ],
                    )
                  : ProfileAvatar(
                      photoPath: null,
                      initials: _initials,
                      size: 90,
                    ),
            ),

            const SizedBox(height: 32),

            Row(
              children: [
                Expanded(
                  child: _ReadOnlyField(label: 'First Name', value: firstName),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _ReadOnlyField(label: 'Last Name', value: lastName),
                ),
              ],
            ),

            const SizedBox(height: 16),
            _ReadOnlyField(label: 'E-mail', value: email),
            const SizedBox(height: 16),

            const Text(
              'Country',
              style: TextStyle(
                fontSize: 13,
                color: Color(0xFF888888),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 6),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFDDDDDD)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Indonesia',
                    style: TextStyle(fontSize: 14, color: Color(0xFF1A1A1A)),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: Color(0xFF888888),
                    size: 22,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            const Text(
              'Phone Number',
              style: TextStyle(
                fontSize: 13,
                color: Color(0xFF888888),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 13,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFDDDDDD)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    children: [
                      Text('🇮🇩', style: TextStyle(fontSize: 18)),
                      SizedBox(width: 6),
                      Text(
                        '+62',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF1A1A1A),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFDDDDDD)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      phone.isNotEmpty ? phone : '8888001112',
                      style: TextStyle(
                        fontSize: 14,
                        color: phone.isNotEmpty
                            ? const Color(0xFF1A1A1A)
                            : const Color(0xFFCCCCCC),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ReadOnlyField extends StatelessWidget {
  final String label;
  final String value;

  const _ReadOnlyField({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: Color(0xFF888888),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFDDDDDD)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            value,
            style: const TextStyle(fontSize: 14, color: Color(0xFF1A1A1A)),
          ),
        ),
      ],
    );
  }
}