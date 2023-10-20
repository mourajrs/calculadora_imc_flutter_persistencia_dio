import 'dart:convert';
import 'dart:io';

class Utilities {
  static String readString() {
    return stdin.readLineSync(encoding: utf8) ?? "";
  }

  static String readStringWithText(String text) {
    return readString();
  }

  static int? readIntWithText(String text) {
    var value = readString();
    try {
      return int.tryParse(value);
    } catch (e) {
      return null;
    }
  }

  static double? readDouble() {
    var value = readString();
    try {
      return double.tryParse(value);
    } catch (e) {
      return null;
    }
  }

  static double? readDoubleWithText(String text) {
    return readDouble();
  }
}
