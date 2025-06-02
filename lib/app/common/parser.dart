import 'dart:convert';

import 'package:get/get_utils/get_utils.dart';

class Parser {
  static T? to<T>(dynamic value) {
    String runtimeType = '${(<T>[]).runtimeType}';

    if (value == null) {
      return value;
    } else if (value is T) {
      return value;
    } else if (runtimeType == 'List<List<String>>' ||
        runtimeType == 'List<List<String?>>' ||
        runtimeType == 'List<List<String>?>') {
      return toList<String>(value) as T;
    } else if (runtimeType == 'List<List<int>>' ||
        runtimeType == 'List<List<int?>>' ||
        runtimeType == 'List<List<int>?>') {
      return toList<int>(value) as T;
    } else if (runtimeType == 'List<List<double>>' ||
        runtimeType == 'List<List<double?>>' ||
        runtimeType == 'List<List<double>?>') {
      return toList<double>(value) as T;
    } else if (runtimeType == 'List<List<DateTime>>' ||
        runtimeType == 'List<List<DateTime?>>' ||
        runtimeType == 'List<List<DateTime>?>') {
      return toList<DateTime>(value) as T;
    } else if (runtimeType == 'List<List<bool>>' ||
        runtimeType == 'List<List<bool?>>' ||
        runtimeType == 'List<List<bool>?>') {
      return toList<bool>(value) as T;
    } else if (runtimeType == 'List<String>' || runtimeType == 'List<String?>' || runtimeType == 'List<String>?') {
      return toStringValue(value) as T;
    } else if (runtimeType == 'List<int>' || runtimeType == 'List<int?>' || runtimeType == 'List<int>?') {
      return toInt(value) as T;
    } else if (runtimeType == 'List<double>' || runtimeType == 'List<double?>' || runtimeType == 'List<double>?') {
      return toDouble(value) as T;
    } else if (runtimeType == 'List<DateTime>' ||
        runtimeType == 'List<DateTime?>' ||
        runtimeType == 'List<DateTime>?') {
      return toDateTime(value) as T;
    } else if (runtimeType == 'List<bool>' || runtimeType == 'List<bool?>' || runtimeType == 'List<bool>?') {
      return toBool(value) as T;
    } else {
      return value;
    }
  }

  static num toNum(dynamic value) {
    if (value == null) {
      return value;
    } else if (value is num) {
      return value;
    } else if (value is String) {
      return num.tryParse(value.numericOnly()) ?? 0;
    }
    return 0;
  }

  static int? toInt(dynamic value) {
    if (value == null) {
      return value;
    } else if (value is int) {
      return value;
    } else if (value is double) {
      return value.toInt();
    } else if (value is String) {
      return int.tryParse(value.numericOnly()) ?? double.tryParse(value.numericOnly())?.toInt() ?? 0;
    } else {
      return 0;
    }
  }

  static double? toDouble(dynamic value) {
    if (value == null) {
      return value;
    } else if (value is double) {
      return value;
    } else if (value is int) {
      return value.toDouble();
    } else if (value is String) {
      // var tmp = value.numericOnly();
      return double.tryParse(value) ?? 0.0;
    } else {
      return 0.0;
    }
  }

  static DateTime? toDateTime(dynamic value) {
    if (value == null) {
      return value;
    } else if (value is DateTime) {
      return value.toLocal();
    } else if (value is String) {
      try {
        if (value.trim() == '') return null;
        return DateTime.parse(value).toLocal();
      } catch (_) {
        return DateTime(1999, 1, 1).toLocal();
      }
    } else if (value is int) {
      if (value.toString().length <= 10) {
        return DateTime.fromMillisecondsSinceEpoch(value * 1000).toLocal();
      } else if (value.toString().length <= 13) {
        return DateTime.fromMillisecondsSinceEpoch(value).toLocal();
      } else if (value.toString().length <= 16) {
        return DateTime.fromMicrosecondsSinceEpoch(value).toLocal();
      } else {
        throw ArgumentError("Invalid timestamp format.");
      }
    }
    // else if (value is Timestamp) {
    //   return value.toDate().toLocal();
    // }
    else {
      throw ArgumentError("Unsupported input type.");
    }
  }

  static T? toModel<T>(dynamic value, {T Function(Map<String, dynamic>)? parser}) {
    if (value is T) {
      return value;
    } else if (value == null || parser == null) {
      return null;
    } else if (value is String) {
      return parser(jsonDecode(value));
    } else {
      return parser(value);
    }
  }

  static List<T>? toModels<T>(dynamic value, {required T Function(Map<String, dynamic>) parser}) {
    if (value is List<T>) {
      return value;
    } else if (value == null) {
      return null;
    }

    var tmp = value is String ? jsonDecode(value) : value;

    if (tmp is! List) {
      return null;
    }
    // return [];
    return tmp.map((e) {
      return parser(e is String ? jsonDecode(e) : e as Map<String, dynamic>);
    }).toList();
  }

  static bool? toBool(dynamic value) {
    if (value == null) {
      return value;
    } else if (value is bool) {
      return value;
    } else if (value is int) {
      return value != 0;
    } else if (value is double) {
      return value != 0.0;
    } else if (value is String) {
      int? tmpInt = int.tryParse(value);
      if (tmpInt != null) {
        return tmpInt == 1 ? true : false;
      }
      return value.toLowerCase() == 'true';
    } else {
      return false;
    }
  }

  static String? toStringValue(dynamic value) {
    if (value == null) {
      return value;
    } else {
      return value.toString();
    }
  }

  static List<T> toList<T>(dynamic value) {
    if (value is String && value.isNotEmpty) {
      value = value.replaceAll(RegExp(r'[{}]'), '');
      value = value.split(',');
    }
    if (value is List) {
      return value.map<T>((e) {
        if (e is T) {
          return e;
        } else if (T == String) {
          return toStringValue(e) as T;
        } else if (T == int) {
          return toInt(e) as T;
        } else if (T == double) {
          return toDouble(e) as T;
        } else if (T == DateTime) {
          return toDateTime(e) as T;
        } else if (T == bool) {
          return toBool(e) as T;
        } else {
          return e as T;
        }
      }).toList();
    } else {
      return [];
    }
  }

  static Map<String, dynamic> toMap(dynamic value) {
    if (value is Map<String, dynamic>) {
      return value;
    } else {
      return {};
    }
  }

  static List<int> parseToIntList(dynamic input) {
    List<int> result = [];

    if (input is List) {
      for (var item in input) {
        if (item is int) {
          result.add(item);
        } else if (item is String) {
          int? parsedInt = int.tryParse(item);
          if (parsedInt != null) {
            result.add(parsedInt);
          }
        }
      }
    } else if (input is String) {
      try {
        // Remove leading and trailing brackets if present
        if (input.startsWith("[") && input.endsWith("]")) {
          input = input.substring(1, input.length - 1);
        }

        // Split the input string by commas
        List<String> items = input.split(",");

        for (var item in items) {
          int? parsedInt = int.tryParse(item.trim());
          if (parsedInt != null) {
            result.add(parsedInt);
          }
        }
      } catch (e) {
        throw ("Error parsing input: $e");
      }
    }

    return result;
  }
}
