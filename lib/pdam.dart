class Pdam {
  final String kodePembayaran;
  final String namaPelanggan;
  final String jenisPelanggan;
  final String tanggal;
  final double meterBulanIni;
  final double meterBulanLalu;
  late final double totalBayar;

  Pdam({
    required this.kodePembayaran,
    required this.namaPelanggan,
    required this.jenisPelanggan,
    required this.tanggal,
    required this.meterBulanIni,
    required this.meterBulanLalu,
  }) {
    totalBayar = _hitungTotalBayar();
  }

  double _hitungTotalBayar() {
    double meterPakai = meterBulanIni - meterBulanLalu;
    double biayaPerMeter = 0.0;

    // Penentuan biaya per meter berdasarkan jenis pelanggan dan jumlah meter pakai
    if (jenisPelanggan == "GOLD") {
      if (meterPakai <= 10) {
        biayaPerMeter = 5000;
      } else if (meterPakai <= 20) {
        biayaPerMeter = 10000;
      } else {
        biayaPerMeter = 20000;
      }
    } else if (jenisPelanggan == "SILVER") {
      if (meterPakai <= 10) {
        biayaPerMeter = 4000;
      } else if (meterPakai <= 20) {
        biayaPerMeter = 8000;
      } else {
        biayaPerMeter = 10000;
      }
    } else if (jenisPelanggan == "UMUM") {
      if (meterPakai <= 10) {
        biayaPerMeter = 2000;
      } else if (meterPakai <= 20) {
        biayaPerMeter = 3000;
      } else {
        biayaPerMeter = 5000;
      }
    }

    // Hitung Total Bayar
    return meterPakai * biayaPerMeter;
  }

  @override
  String toString() {
    return 'Kode Pembayaran: $kodePembayaran, Nama Pelanggan: $namaPelanggan, '
           'Jenis Pelanggan: $jenisPelanggan, Tanggal: $tanggal, '
           'Meter Pakai: ${meterBulanIni - meterBulanLalu}, '
           'Total Bayar: Rp $totalBayar';
  }
}
