
import 'package:encrypt/encrypt.dart';
import 'dart:convert';

mixin DataConvertor {

  static String encode(String input){
    const plainText = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit';
    final key = Key.fromUtf8('my 32 length key................');
    final iv = IV.fromLength(16);

    final encrypter = Encrypter(AES(key));

    final encrypted = encrypter.encrypt(plainText, iv: iv);
    final decrypted = encrypter.decrypt(encrypted, iv: iv);

    print(decrypted); // Lorem ipsum dolor sit amet, consectetur adipiscing elit
    print(encrypted); // R4PxiU3h8YoIRqVowBXm36ZcCeNeZ4s1OvVBTfFlZRdmohQqOpPQqD1YecJeZMAop/hZ4OxqgC1WtwvX/hP9mw==
    return "";
  }
  //
  // static String decode(String input){
  //
  // }


}