// Author: Apurba Talapatra Ovi
// ID: 0182410012101185
// CSE-63(E)

import 'dart:io';

void main() {
  List<String> input = stdin.readLineSync()!.split(" ");
  double p = double.parse(input[0]);
  double t = double.parse(input[1]);
  double r = double.parse(input[2]);
  double si = (p * t * r) / 100;
  print(si);
}