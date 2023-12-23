import 'dart:math';
void main() {
  Random acak = Random();
  int randomSixDigit = acak.nextInt(900000) + 100000;
  print('Angka acak dengan 6 digit: $randomSixDigit');
}