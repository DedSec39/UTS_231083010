import 'package:flutter/material.dart';
import 'pdam.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pembayaran PDAM',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PdamScreen(),
    );
  }
}

class PdamScreen extends StatefulWidget {
  @override
  _PdamScreenState createState() => _PdamScreenState();
}

class _PdamScreenState extends State<PdamScreen> {
  final TextEditingController _kodePembayaranController = TextEditingController();
  final TextEditingController _namaPelangganController = TextEditingController();
  String _jenisPelanggan = "UMUM";
  final TextEditingController _tanggalController = TextEditingController();
  final TextEditingController _meterBulanIniController = TextEditingController();
  final TextEditingController _meterBulanLaluController = TextEditingController();

  double? _totalBayar;

  void _hitungTotalBayar() {
    try {
      final pdam = Pdam(
        kodePembayaran: _kodePembayaranController.text,
        namaPelanggan: _namaPelangganController.text,
        jenisPelanggan: _jenisPelanggan,
        tanggal: _tanggalController.text,
        meterBulanIni: double.tryParse(_meterBulanIniController.text) ?? 0,
        meterBulanLalu: double.tryParse(_meterBulanLaluController.text) ?? 0,
      );

      setState(() {
        _totalBayar = pdam.totalBayar;
      });
    } catch (e) {
      setState(() {
        _totalBayar = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Input tidak valid! Pastikan semua field diisi dengan benar.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pembayaran PDAM"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _kodePembayaranController,
              decoration: InputDecoration(labelText: "Kode Pembayaran"),
            ),
            TextField(
              controller: _namaPelangganController,
              decoration: InputDecoration(labelText: "Nama Pelanggan"),
            ),
            DropdownButtonFormField<String>(
              value: _jenisPelanggan,
              decoration: InputDecoration(labelText: "Jenis Pelanggan"),
              items: ["UMUM", "SILVER", "GOLD"].map((jenis) {
                return DropdownMenuItem(
                  value: jenis,
                  child: Text(jenis),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _jenisPelanggan = value!;
                });
              },
            ),
            TextField(
              controller: _tanggalController,
              decoration: InputDecoration(labelText: "Tanggal"),
            ),
            TextField(
              controller: _meterBulanIniController,
              decoration: InputDecoration(labelText: "Meter Bulan Ini"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _meterBulanLaluController,
              decoration: InputDecoration(labelText: "Meter Bulan Lalu"),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _hitungTotalBayar,
              child: Text("Hitung Total Bayar"),
            ),
            SizedBox(height: 20),
            if (_totalBayar != null)
              Text(
                "Total Bayar: Rp ${_totalBayar!.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }
}
