import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:keuanganku/app/common/parser.dart';
import 'package:keuanganku/app/utils/date_utils.dart';

class MySerializer extends ValueSerializer {
  final bool serializeDateTimeValuesAsString;
  const MySerializer({this.serializeDateTimeValuesAsString = true});

  @override
  T fromJson<T>(json) {
    return Parser.to<T>(json) as T;
  }

  @override
  toJson<T>(T value) {
    if (value is DateTime) {
      return serializeDateTimeValuesAsString ? value.formatToSync : value.millisecondsSinceEpoch;
    }

    if (value is bool) {
      return value ? 1 : 0;
    }

    return value;
  }
}

class ListIntConverter extends TypeConverter<List<int>, String> {
  const ListIntConverter();

  @override
  List<int> fromSql(String fromDb) {
    final parsedJson = json.decode(fromDb);
    if (parsedJson is List<dynamic>) {
      return parsedJson.whereType<int>().toList();
    }
    return [];
  }

  @override
  String toSql(List<int> value) {
    return json.encode(value);
  }
}

class ListStringConverter extends TypeConverter<List<String>, String> {
  const ListStringConverter();

  @override
  List<String> fromSql(String fromDb) {
    final parsedJson = json.decode(fromDb);
    if (parsedJson is List<dynamic>) {
      return parsedJson.whereType<String>().toList();
    }
    return [];
  }

  @override
  String toSql(List<String> value) {
    return json.encode(value);
  }
}
