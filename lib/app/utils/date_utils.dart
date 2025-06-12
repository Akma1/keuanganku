import 'package:drift/drift.dart';
import 'package:intl/intl.dart' as intl;

extension DateTimeUtils on DateTime {
  Value toValue() {
    return Value(this);
  }

  bool isSameDay(DateTime? other) {
    if (other == null) {
      return false;
    }
    return year == other.year && month == other.month && day == other.day;
  }

  bool get isUnderFiveMinutes {
    //kurang dari 5 menit yang lalu
    return DateTime.now().difference(this).inMinutes <= 5;
  }

  bool get isToday {
    return intl.DateFormat.yMd().format(this) == intl.DateFormat.yMd().format(DateTime.now());
  }

  bool get isThisYear {
    return intl.DateFormat.y().format(this) == intl.DateFormat.y().format(DateTime.now());
  }

  DateTime get startOfDay => DateTime(year, month, day, 0, 0, 0).toLocal();
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59).toLocal();

  DateTime get startOfMonth => DateTime(year, month, 1).toLocal();
  DateTime get endOfMonth => DateTime(year, month + 1, 0, 23, 59, 59).toLocal();

  DateTime get startOfYear => DateTime(year, 1, 1).toLocal();
  DateTime get endOfYear => DateTime(year + 1, 1, 0, 23, 59, 59).toLocal();

  DateTime get startOfWeek => DateTime(year, month, day - weekday).toLocal();
  DateTime get endOfWeek => DateTime(year, month, day - weekday + 6).toLocal();

  String get formatDateTimeLocal => intl.DateFormat.yMMMd().add_Hm().format(this);
  String get formatLocal => intl.DateFormat.yMMMd().format(this);
  String get formattedDateShort => intl.DateFormat('dd/MM/yy').format(this);
  String get formattedDate => intl.DateFormat('yyyy-MM-dd').format(this);
  String get formatLongDate => intl.DateFormat.yMMMMEEEEd().format(this);
  String get formatLongDateTime => intl.DateFormat.yMMMMEEEEd().add_Hm().format(this);
  String get formattedTime => intl.DateFormat('HH:mm').format(this);
  String get formattedTimes => intl.DateFormat('HH:mm:ss').format(this);
  String get formatCode => intl.DateFormat('yyyyMMdd').format(this);
  String get formatCodeYearMonth => intl.DateFormat('yyyyMM').format(this);
  String get formatCodeYear => intl.DateFormat('yyyy').format(this);
  String get formatPrintLabel => intl.DateFormat('dd MMM yy, HH:mm').format(this);
  String get formatPrintLabelLong => intl.DateFormat('dd MMMM yy, HH:mm').format(this);

  String get formatToSync => intl.DateFormat('yyyy-MM-dd HH:mm:ss').format(this);

  //subdays
  DateTime get subDay => DateTime(year, month, day - 1).toLocal();
  DateTime get subWeek => DateTime(year, month, day - 7).toLocal();
  DateTime get subMonth => DateTime(year, month - 1, day).toLocal();
  DateTime subDays(int sub) {
    return subtract(Duration(days: sub));
  }

  DateTime subMonths(int sub) {
    if (month - sub < 1) {
      return DateTime(year - 1, month - sub + 12, day).toLocal();
    }
    return DateTime(year, month - sub, day).toLocal();
  }

  DateTime get subYear => DateTime(year - 1, month, day).toLocal();
  DateTime subYears(int sub) => DateTime(year - sub, month, day).toLocal();

  //adddays
  DateTime get addDay => DateTime(year, month, day + 1).toLocal();
  DateTime get addWeek => DateTime(year, month, day + 7).toLocal();
  DateTime get addMonth => DateTime(year, month + 1, day).toLocal();
  DateTime get addYear => DateTime(year + 1, month, day).toLocal();

  DateTime firstOfYear() => DateTime(year, 1, 1).toLocal();
  DateTime lastOfYear() => DateTime(year + 1, 1, 0).toLocal();
  DateTime firstOfMonth() => DateTime(year, month, 1).toLocal();
  DateTime lastOfMonth() => DateTime(year, month + 1, 0).toLocal();
}
