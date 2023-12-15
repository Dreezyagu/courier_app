import 'package:flutter/services.dart';

/// A collection of common validators that can be reused
class Validators {
  static final emailPattern = RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@"
    r"[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}"
    r"[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}"
    r"[a-zA-Z0-9])?)+$",
  );

  static Validator notEmpty() {
    return (String? value) {
      return (value!.isEmpty) ? "This field cannot be empty." : null;
    };
  }

  static List<TextInputFormatter> nameCheck() {
    return [FilteringTextInputFormatter.allow(RegExp(r"^[a-zA-Z\s\'|-]+$"))];
  }

  static Validator minLength(int minLength) {
    return (String? value) {
      if ((value!.length) < minLength) {
        return "Must contain a minimum of $minLength characters.";
      }
      return null;
    };
  }

  static Validator matchLength(int minLength) {
    return (String? value) {
      if ((value!.length) != minLength) {
        return "Must contain $minLength numbers.";
      }
      return null;
    };
  }

  static Validator matchValue(String matchValue, [String? patternName]) {
    return (String? value) {
      if (value != matchValue) {
        return "Must match the ${patternName ?? "password provided."}";
      }
      return null;
    };
  }

  static Validator matchPattern(Pattern pattern, [String? patternName]) {
    return (String? value) {
      if ((pattern.allMatches(value!).isEmpty)) {
        return "Please enter a valid ${patternName ?? "value"}.";
      }
      return null;
    };
  }

  static Validator email() {
    return matchPattern(emailPattern, "email");
  }

  static Validator password([int minimumLength = 8]) => multipleAnd([
        containsUpper("Password"),
        containsLower("Password"),
        containsNumber("Password"),
        containsSpecialChar("Password"),
        minLength(minimumLength),
      ], shouldTrim: false);

  static Validator containsUpper([String? fieldName]) {
    return (String? value) {
      if (value!.containsUpper()) return null;
      return "${fieldName ?? 'Field'} must contain at least one uppercase character.";
    };
  }

  static Validator containsLower([String? fieldName]) {
    return (String? value) {
      if (value!.containsLower()) return null;
      return "${fieldName ?? 'Field'} must contain at least one lowercase character.";
    };
  }

  static Validator containsNumber([String? fieldName]) {
    return (String? value) {
      if (value!.containsNumber()) return null;
      return "${fieldName ?? 'Field'} must contain at least one number.";
    };
  }

  static Validator containsSpecialChar([String? fieldName]) {
    return (String? value) {
      if (value!.containsSpecialChar()) return null;
      return "${fieldName ?? 'Field'} must contain at least one special character.";
    };
  }

  /// Creates a validator that if the combination of multiple validators.
  ///
  /// The provided validators are applied in the order in which
  /// they're specified in the list.
  static Validator multipleAnd(List<Validator> validators,
      {bool shouldTrim = true}) {
    return (String? value) {
      value = shouldTrim ? value!.trim() : value;
      for (Validator validator in validators) {
        final result = validator(value);
        if (result != null) return result;
      }
      return null;
    };
  }

  /// Creates a validator that if the combination of multiple validators.
  ///
  /// The provided validators are applied in the order in which
  /// they're specified in the list.
  static Validator multipleOr(List<Validator> validators,
      {required String message, bool shouldTrim = true}) {
    return (String? value) {
      value = shouldTrim ? value!.trim() : value;
      for (Validator validator in validators) {
        final result = validator(value);
        if (result == null) return result;
      }
      return message;
    };
  }
}

typedef Validator = String? Function(String? value);

extension CharacterValidation on String {
  bool containsUpper() {
    for (var i = 0; i < length; i++) {
      var code = codeUnitAt(i);
      if (code >= 65 && code <= 90) return true;
    }
    return false;
  }

  bool containsLower() {
    for (var i = 0; i < length; i++) {
      var code = codeUnitAt(i);
      if (code >= 97 && code <= 122) return true;
    }
    return false;
  }

  bool containsSpecialChar() {
    for (var i = 0; i < length; i++) {
      if ("#?!@\$ %^&*-".contains(this[i])) return true;
    }
    return false;
  }

  bool containsNumber() {
    for (var i = 0; i < length; i++) {
      var code = codeUnitAt(i);
      if (code >= 48 && code <= 57) return true;
    }
    return false;
  }
}
