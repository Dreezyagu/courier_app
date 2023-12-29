import 'dart:math';

import 'package:flutter/material.dart';

extension CustomContext on BuildContext {
  Orientation orientation() => MediaQuery.of(this).orientation;
  double height([double percent = 1]) {
    return orientation() == Orientation.portrait
        ? MediaQuery.of(this).size.height * percent
        : MediaQuery.of(this).size.width * percent;
  }

  double width([double percent = 1]) {
    {
      return orientation() == Orientation.landscape
          ? MediaQuery.of(this).size.height * percent
          : MediaQuery.of(this).size.width * percent;
    }
  }
}

extension StringExtension on String {
  String timeDigits() => padLeft(2, '0');

  String capitalize() {
    if (isEmpty) {
      return this;
    } else {
      return "${this[0].toUpperCase()}${substring(1)}";
    }
  }

  String commalise() {
    return replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
  }

  String capitalizeAllWord() {
    var result = this[0].toUpperCase();
    for (int i = 1; i < length; i++) {
      if (this[i - 1] == " ") {
        result = result + this[i].toUpperCase();
      } else {
        result = result + this[i];
      }
    }
    return result;
  }

}

extension TruncateDoubles on num {
  double truncateToDecimalPlaces(int fractionalDigits) =>
      (this * pow(10, fractionalDigits)).truncate() / pow(10, fractionalDigits);
}
