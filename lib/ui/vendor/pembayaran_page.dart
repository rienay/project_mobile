import 'package:flutter/material.dart';
import 'konfirmasi_pembayaran_page.dart';

class PembayaranPage extends StatefulWidget {
  final String namaLengkap;
  final String vendorDipilih;
  final String tanggalPernikahan;

  const PembayaranPage({
    super.key,
    required this.namaLengkap,
    required this.vendorDipilih,
    required this.tanggalPernikahan,
  });

  @override
  State<PembayaranPage> createState() => _PembayaranPageState();
}

class _PembayaranPageState extends State<PembayaranPage> {
  static const Color primaryPink = Color(0xFFF43F8B);

  int _selectedMethod = 0;

  final _nomorKartuCtrl = TextEditingController();
  final _namaPemegangCtrl = TextEditingController();
  final _kadaluarsaCtrl = TextEditingController();
  final _cvvCtrl = TextEditingController();

  String? _selectedBank;
  String? _selectedEWallet;

  final List<String> _banks = ['BCA', 'BNI', 'BRI', 'Mandiri', 'CIMB'];
  final List<String> _eWallets = ['GoPay', 'OVO', 'Dana', 'ShopeePay', 'LinkAja'];

  Widget _methodButton(int index, IconData icon, String label) {
    final isSelected = _selectedMethod == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedMethod = index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? primaryPink : Colors.grey.shade200,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(icon,
                color: isSelected ? primaryPink : Colors.grey.shade400,
                size: 20),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: isSelected ? primaryPink : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKartuDetail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Detail Kartu',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        const SizedBox(height: 14),
        _inputLabel('Nomor Kartu', required: true),
        _textField(_nomorKartuCtrl, '1234 5678 9012 3456',
            keyboardType: TextInputType.number),
        const SizedBox(height: 12),
        _inputLabel('Nama Pemegang Kartu', required: true),
        _textField(_namaPemegangCtrl, 'Nama sesuai di kartu'),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _inputLabel('Tanggal Kadaluarsa', required: true),
                  _textField(_kadaluarsaCtrl, 'MM/YY',
                      keyboardType: TextInputType.number),
                ],
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _inputLabel('CVV', required: true),
                  _textField(_cvvCtrl, '123',
                      keyboardType: TextInputType.number, obscure: true),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTransferDetail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Transfer Bank',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        const SizedBox(height: 14),
        _inputLabel('Pilih Bank', required: true),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedBank,
              hint: Text('Pilih Bank',
                  style: TextStyle(color: Colors.grey.shade400, fontSize: 13)),
              isExpanded: true,
              items: _banks
                  .map((b) => DropdownMenuItem(
                      value: b,
                      child: Text(b, style: const TextStyle(fontSize: 13))))
                  .toList(),
              onChanged: (v) => setState(() => _selectedBank = v),
            ),
          ),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFFE8F4FD),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.info_outline,
                  color: Color(0xFF3B82F6), size: 18),
              const SizedBox(width: 10),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Setelah submit, Anda akan menerima:',
                        style: TextStyle(
                            fontSize: 12, color: Color(0xFF1E40AF))),
                    SizedBox(height: 4),
                    Text('• Nomor rekening tujuan transfer',
                        style: TextStyle(
                            fontSize: 12, color: Color(0xFF1E40AF))),
                    Text('• Kode unik pembayaran',
                        style: TextStyle(
                            fontSize: 12, color: Color(0xFF1E40AF))),
                    Text('• Batas waktu pembayaran 24 jam',
                        style: TextStyle(
                            fontSize: 12, color: Color(0xFF1E40AF))),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEWalletDetail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('E-Wallet',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        const SizedBox(height: 14),
        _inputLabel('Pilih E-Wallet', required: true),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedEWallet,
              hint: Text('Pilih E-Wallet',
                  style: TextStyle(color: Colors.grey.shade400, fontSize: 13)),
              isExpanded: true,
              items: _eWallets
                  .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e, style: const TextStyle(fontSize: 13))))
                  .toList(),
              onChanged: (v) => setState(() => _selectedEWallet = v),
            ),
          ),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFFE8F4FD),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.info_outline, color: Color(0xFF3B82F6), size: 18),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Anda akan diarahkan ke aplikasi e-wallet untuk menyelesaikan pembayaran.',
                  style:
                      TextStyle(fontSize: 12, color: Color(0xFF1E40AF)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _inputLabel(String label, {bool required = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Text(label,
              style: const TextStyle(fontSize: 13, color: Colors.black87)),
          if (required)
            const Text(' *',
                style: TextStyle(color: Color(0xFFF43F8B))),
        ],
      ),
    );
  }

  Widget _textField(
    TextEditingController ctrl,
    String hint, {
    TextInputType keyboardType = TextInputType.text,
    bool obscure = false,
  }) {
    return TextField(
      controller: ctrl,
      keyboardType: keyboardType,
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
        filled: true,
        fillColor: Colors.grey.shade100,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  String get _metodePembayaran {
    if (_selectedMethod == 0) return 'Kartu Kredit/Debit';
    if (_selectedMethod == 1) return 'Transfer Bank';
    return 'E-Wallet';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF0F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF0F5),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: Colors.black87, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pembayaran',
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'Booking untuk ${widget.namaLengkap}',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Metode Pembayaran card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Metode Pembayaran',
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 12),
                  _methodButton(
                      0, Icons.credit_card_outlined, 'Kartu Kredit/Debit'),
                  const SizedBox(height: 8),
                  _methodButton(
                      1, Icons.account_balance_outlined, 'Transfer Bank'),
                  const SizedBox(height: 8),
                  _methodButton(2,
                      Icons.account_balance_wallet_outlined, 'E-Wallet'),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Detail sesuai metode
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: _selectedMethod == 0
                  ? _buildKartuDetail()
                  : _selectedMethod == 1
                      ? _buildTransferDetail()
                      : _buildEWalletDetail(),
            ),
            const SizedBox(height: 24),

            // Konfirmasi button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => KonfirmasiPembayaranPage(
                        namaLengkap: widget.namaLengkap,
                        vendorDipilih: widget.vendorDipilih,
                        metodePembayaran: _metodePembayaran,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryPink,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  elevation: 0,
                ),
                child: const Text(
                  'Konfirmasi Pembayaran',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}