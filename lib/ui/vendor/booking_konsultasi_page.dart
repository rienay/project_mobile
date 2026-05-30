import 'package:flutter/material.dart';
import 'booking_berhasil_page.dart';

class BookingKonsultasiPage extends StatefulWidget {
  final String vendorName;

  const BookingKonsultasiPage({super.key, required this.vendorName});

  @override
  State<BookingKonsultasiPage> createState() => _BookingKonsultasiPageState();
}

class _BookingKonsultasiPageState extends State<BookingKonsultasiPage> {
  static const Color primaryPink = Color(0xFFF43F8B);

  final _namaController = TextEditingController();
  final _emailController = TextEditingController();
  final _telpController = TextEditingController();
  final _tanggalController = TextEditingController();
  final _layananController = TextEditingController();

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now.add(const Duration(days: 30)),
      firstDate: now,
      lastDate: DateTime(now.year + 5),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: primaryPink),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _tanggalController.text =
            '${picked.day} ${_monthName(picked.month)} ${picked.year}';
      });
    }
  }

  String _monthName(int m) {
    const months = [
      '',
      'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
    ];
    return months[m];
  }

  void _submitBooking() {
    if (_namaController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _telpController.text.isEmpty ||
        _tanggalController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Harap lengkapi semua field yang wajib diisi'),
          backgroundColor: primaryPink,
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BookingBerhasilPage(
          namaLengkap: _namaController.text,
          tanggalPernikahan: _tanggalController.text,
          vendorDipilih: widget.vendorName,
        ),
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool required = true,
    TextInputType keyboardType = TextInputType.text,
    VoidCallback? onTap,
    String? hint,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: primaryPink),
            const SizedBox(width: 8),
            Text(label,
                style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87)),
            if (required)
              const Text(' *',
                  style: TextStyle(color: primaryPink, fontSize: 13)),
          ],
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onTap,
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            readOnly: onTap != null,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle:
                  TextStyle(color: Colors.grey.shade400, fontSize: 13),
              filled: true,
              fillColor: Colors.grey.shade100,
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        const SizedBox(height: 18),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 32),
                  const Text(
                    'Booking Konsultasi',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close,
                        size: 22, color: Colors.black54),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Isi formulir di bawah ini untuk\nmenjadwalkan konsultasi dengan tim\nwedding planner kami',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 13, color: Colors.grey.shade500, height: 1.5),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    _buildField(
                      controller: _namaController,
                      label: 'Nama Lengkap',
                      icon: Icons.person_outline,
                    ),
                    _buildField(
                      controller: _emailController,
                      label: 'Email',
                      icon: Icons.mail_outline,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    _buildField(
                      controller: _telpController,
                      label: 'Nomor Telepon',
                      icon: Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                    ),
                    _buildField(
                      controller: _tanggalController,
                      label: 'Tanggal Pernikahan',
                      icon: Icons.calendar_month_outlined,
                      onTap: _pickDate,
                    ),
                    _buildField(
                      controller: _layananController,
                      label: 'Layanan yang Diinginkan',
                      icon: Icons.chat_bubble_outline,
                      required: false,
                      hint: 'Pilih vendor yang diinginkan',
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitBooking,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryPink,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Submit Booking',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}