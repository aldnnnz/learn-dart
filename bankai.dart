import 'dart:io';
import 'dart:math';
import 'package:csv/csv.dart';

void main(){

  File akunBank = File('akun.csv');
  String csv = akunBank.readAsStringSync();
  List<List<dynamic>> akun = CsvToListConverter().convert(csv);
  bool lanjut = true;
  do {
    tampilMenu(); //fungsi unruk menampilkan menu
    stdout.write('\npilih (1-4)? : '); // output 
    int pilih = int.parse(stdin.readLineSync()!); //variabel pilih yang nantinya akan menerima inputan dari yang kita ketikkan
    switch (pilih) {
      case 1:
       buatAkun(akun); //fungsi ini nantinya membuat list nama dan saldo yang disimpan di list akun
        break;
      case 2:
        deposit(akun); //fungsi ini akan menambah jumlah saldo di list akun
        break;
      case 3:
        tarikSaldo(akun); // fungsi ini akan mengurangi saldo di list akun
        break;
      case 4:
        cekSaldo(akun); //fungsi ini menampilkan atau cek saldo penggunanya
        break;
      case 5:
        transfer(akun); // fungsi ini nantinya mengurangi saldo peengirim dan menambah saldo penerima
      default: 'tidak valid';
    }
    String bankCsv = const ListToCsvConverter().convert(akun);
    akunBank.writeAsStringSync(bankCsv);
    stdout.write('\nkembali ke menu? (Y/N) : ');
    String? menu = stdin.readLineSync();
    if (menu == 'n') { // jika inputan dari menu adalah 'n' maka perulangan berhenti
      lanjut = false;
    } 
  } while (lanjut);
  
}
void tampilMenu(){
  print(
      '\n+===================================+'
      '\n|    Selamat datang di Bank Krut    |'  
      '\n+===================================+'
      '\n|  [1] Buat akun                    |'
      '\n|  [2] Deposit                      |'
      '\n|  [3] Tarik tunai                  |'
      '\n|  [4] Cek saldo                    |'
      '\n|  [5] Transfer                     |'
      '\n+===================================+');
}
void buatAkun(akun){
  stdout.write('masukkan nama anda : ');
  String? nama = stdin.readLineSync(); //variabel ini berisi inputan nama 
  stdout.write('masukkan jumlah saldo awal anda : ');
  double jml = double.parse(stdin.readLineSync()!); //variabel ini berisi inputan saldo awalid
  Random acak = Random();
  int id = acak.nextInt(900000) + 100000;
  List tambah = [id, nama, jml]; //inputan dari variabel nama dan jml ditampung di list tambah
  akun.add(tambah); //menambahkan akun baru di list akun
  print('akun berhasil dibuat atas nama $nama dan no ID $id dengan jumlah saldo Rp.$jml'); //mencetak konfirmasi pembuatan akun
}
void deposit(akun){
  stdout.write('masukkan no ID anda : ');
  int id = int.parse(stdin.readLineSync()!);
  stdout.write('masukkan nominalnya : ');
  double jml = double.parse(stdin.readLineSync()!);
  for (var depo in akun ){
    if (depo[0] == id) {
      depo[2] += jml;
      print('deposit berhasil dengan jumlah Rp.$jml'
      '\njumlah tabungan anda sekarang adalah Rp.${depo[2]}');
    }
  }
}
void tarikSaldo(akun){
  stdout.write('masukkan no ID anda : ');
  int id = int.parse(stdin.readLineSync()!);
  stdout.write('masukkan nominalnya : ');
  double jml = double.parse(stdin.readLineSync()!);
  for (var kurang in akun ){
    if (kurang[0] == id) {
      kurang[2] -= jml;
      print('tarik tunai berhasil no $id dengan jumlah Rp.$jml'
      '\njumlah tabungan anda sekarang adalah Rp.${kurang[2]}');}
  }
}
void cekSaldo(akun){
  stdout.write('masukkan no ID : ');
  int id = int.parse(stdin.readLineSync()!);
  for (var cek in akun) {
    if (cek[0] == id) {
      print('Saldo untuk akun $id adalah Rp.${cek[2]}');
      return;}
  }
  print('Akun tidak ditemukan.');
}
void transfer(akun){
  stdout.write('masukkan no ID anda : ');
  int pengirim = int.parse(stdin.readLineSync()!);
  stdout.write('masukkan no ID anda : ');
  int penerima = int.parse(stdin.readLineSync()!);
  stdout.write('masukkan nominalnya : ');
  double jml = double.parse(stdin.readLineSync()!);
  for (var tf in akun ){
    if (tf[0] == pengirim) {
      tf[2] -= jml;}
    if (tf[0] == penerima) {
        tf[2] += jml;
        print('transfer berhasil dirkirim ke $penerima atas id $pengirim dengan jumlah Rp.$jml');}
  }
}