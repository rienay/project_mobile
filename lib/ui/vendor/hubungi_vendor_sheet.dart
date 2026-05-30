import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HubungiVendorSheet extends StatelessWidget {
  final String vendorPhone;
  final String vendorEmail;
  final String vendorName;

  const HubungiVendorSheet({
    super.key,
    this.vendorPhone = '+62 812 9876 5432',
    this.vendorEmail = 'contact@vendor.com',
    this.vendorName = 'Vendor',
  });

  static const Color primaryPink = Color(0xFFF43F8B);
  static const Color whatsappGreen = Color(0xFF25D366);

  Future<void> _callPhone(BuildContext context) async {
    final cleaned = vendorPhone.replaceAll(RegExp(r'[^0-9+]'), '');
    final uri = Uri.parse('tel:$cleaned');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> _openWhatsApp(BuildContext context) async {
    final cleaned = vendorPhone
        .replaceAll(RegExp(r'[^0-9]'), '')
        .replaceFirst(RegExp(r'^0'), '62');
    final message = Uri.encodeComponent(
        'Halo, saya ingin berkonsultasi mengenai layanan wedding planner dari $vendorName');
    final uri = Uri.parse('https://wa.me/$cleaned?text=$message');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('WhatsApp tidak terinstal di perangkat ini'),
            backgroundColor: primaryPink,
          ),
        );
      }
    }
  }

  Future<void> _sendEmail(BuildContext context) async {
    final uri = Uri.parse(
        'mailto:$vendorEmail?subject=Konsultasi Wedding Planner&body=Halo, saya ingin berkonsultasi mengenai layanan $vendorName');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  static void show(
    BuildContext context, {
    String phone = '+62 812 9876 5432',
    String email = 'contact@vendor.com',
    String vendorName = 'Vendor',
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => HubungiVendorSheet(
        vendorPhone: phone,
        vendorEmail: email,
        vendorName: vendorName,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFFFF0F5),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 36),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 32),
              const Text(
                'Hubungi Vendor',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child:
                    const Icon(Icons.close, color: Colors.black54, size: 22),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Pilih metode untuk menghubungi vendor',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
          ),
          const SizedBox(height: 24),
          _contactButton(
            onTap: () => _callPhone(context),
            backgroundColor: primaryPink,
            icon: Icons.call_rounded,
            label: vendorPhone,
            textColor: Colors.white,
            iconColor: Colors.white,
          ),
          const SizedBox(height: 12),
          _contactButton(
            onTap: () => _openWhatsApp(context),
            backgroundColor: whatsappGreen,
            icon: Icons.chat_rounded,
            label: 'Chat sekarang',
            textColor: Colors.white,
            iconColor: Colors.white,
          ),
          const SizedBox(height: 12),
          _contactButton(
            onTap: () => _sendEmail(context),
            backgroundColor: Colors.white,
            icon: Icons.mail_outline_rounded,
            label: vendorEmail,
            textColor: Colors.black87,
            iconColor: primaryPink,
            hasBorder: true,
          ),
        ],
      ),
    );
  }

  Widget _contactButton({
    required VoidCallback onTap,
    required Color backgroundColor,
    required IconData icon,
    required String label,
    required Color textColor,
    required Color iconColor,
    bool hasBorder = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(30),
          border: hasBorder
              ? Border.all(color: const Color(0xFFE0E0E0), width: 1.5)
              : null,
          boxShadow: hasBorder
              ? null
              : [
                  BoxShadow(
                    color: backgroundColor.withValues(alpha: 0.35),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  )
                ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: iconColor, size: 20),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                color: textColor,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}