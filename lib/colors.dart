import 'package:flutter/material.dart';
import 'package:notable_now/fonts.dart';

enum MyTheme implements Pastel {buttonsColor,backgroundColor,index0,index1,index2,index3}

class Pastel {
  static Color buttonsColor = const Color(0xfffadae2);
  static Color backgroundColor = const Color(0xfffff5f7);
  static Color index0 = const Color(0xffd7eeff);
  static Color index1 = const Color(0xfffaffc7);
  static Color index2 = const Color(0xffe0d7ff);
  static Color index3 = const Color(0xfffcdce4);

  static ButtonStyle getButtonStyle() {
    return ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: buttonsColor,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      /*textStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),*/
    );
  }
}

class Dark {
  static Color buttonsColor = const Color(0xfffadae2);
  static Color backgroundColor = const Color(0xfffff5f7);
  static Color index0 = const Color(0xffd7eeff);
  static Color index1 = const Color(0xfffaffc7);
  static Color index2 = const Color(0xffe0d7ff);
  static Color index3 = const Color(0xfffcdce4);

  static ButtonStyle getButtonStyle() {
    return ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: buttonsColor,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      /*textStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),*/
    );
  }

}

class Light {
  static Color buttonsColor = const Color(0xfffadae2);
  static Color backgroundColor = const Color(0xfffff5f7);
  static Color index0 = const Color(0xffd7eeff);
  static Color index1 = const Color(0xfffaffc7);
  static Color index2 = const Color(0xffe0d7ff);
  static Color index3 = const Color(0xfffcdce4);

  static ButtonStyle getButtonStyle() {
    return ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: buttonsColor,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      /*textStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),*/
    );
  }
}

