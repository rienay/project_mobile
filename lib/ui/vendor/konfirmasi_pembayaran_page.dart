import 'package:flutter/material.dart';
import 'dart:math';

class KonfirmasiPembayaranPage extends StatelessWidget {
  final String namaLengkap;
  final String vendorDipilih;
  final String metodePembayaran;

  const KonfirmasiPembayaranPage({
    super.key,
    required this.namaLengkap,
    required this.vendorDipilih,
    required this.metodePembayaran,
  });

  static const Color primaryPink = Color(0xFFF43F8B);

  String get _nomorBooking {
    final rand = Random().nextInt(90000) + 10000;
    return 'WP$rand';
  }

  @override
  Widget build(BuildContext context) {
    final nomorBooking = _nomorBooking;
    return Scaffold(
      backgroundColor: const Color(0xFFFFF0F5),
      body: SafeArea(
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.symmetric(horizontal: 28, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: primaryPink,
                ),
                child:
                    const Icon(Icons.check, color: Colors.white, size: 36),
              ),
              const SizedBox(height: 16),
              const Text(
                'Booking Berhasil!',
                style: TextStyle(
                    color: primaryPink,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                'Terima kasih telah mempercayai kami\nuntuk merencanakan hari istimewa Anda',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                    height: 1.5),
              ),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withValues(alpha: 0.06),
                        blurRadius: 12,
                        offset: const Offset(0, 4))
                  ],
                ),
                child: Column(
                  children: [
                    _infoRow(Icons.calendar_today_outlined,
                        'Nomor Booking', nomorBooking),
                    _divider(),
                    _infoRow(Icons.mail_outline, 'Konfirmasi Email',
                        'Detail booking telah dikirim\nke email Anda'),
                    _divider(),
                    _infoRow(Icons.phone_outlined,
                        'Tim Kami Akan Menghubungi',
                        'Dalam 1x24 jam\nuntuk konsultasi\nlanjutan'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: primaryPink,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.favorite, color: Colors.white, size: 16),
                        SizedBox(width: 8),
                        Text('Langkah Selanjutnya',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 13)),
                      ],
                    ),
                    SizedBox(height: 12),
                    Text('1. Cek email untuk\nkonfirmasi pembayaran',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            height: 1.4)),
                    SizedBox(height: 6),
                    Text('2. Persiapkan mood board & inspirasi',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            height: 1.4)),
                    SizedBox(height: 6),
                    Text('3. Tim kami akan jadwalkan meeting',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            height: 1.4)),
                    SizedBox(height: 6),
                    Text('4. Mari wujudkan pernikahan impian!',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            height: 1.4)),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .popUntil((route) => route.isFirst);
                  },
                  style: OutlinedButton.styleFrom(
                    side:
                        const BorderSide(color: primaryPink, width: 1.5),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    'Kembali ke Home',
                    style: TextStyle(
                        color: primaryPink,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: Colors.pink.shade50,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: primaryPink, size: 18),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 12, color: Colors.grey)),
                const SizedBox(height: 3),
                Text(subtitle,
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                        height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() => const Divider(
      height: 1,
      color: Color(0xFFF5F5F5),
      indent: 14,
      endIndent: 14);
}