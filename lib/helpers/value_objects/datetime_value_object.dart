import 'package:intl/intl.dart';

class DateTimeValueObject {
  static final dateFormat = DateFormat('dd/MM/yyyy');
  static final dateFormat2 = DateFormat('dd-MM-yy');
  static final _dateFormatDMYHM = DateFormat('dd/MM/yyyy').add_jm();
  static final _dateFormatDMYHMSMs = DateFormat('dd/MM/yyyy HH:mm:ss.SSS');
  static final _dateFormatDataBase = DateFormat('yyyy-MM-ddTHH:mm:ss.SSS');
  final DateTime _dateTime;

  DateTimeValueObject._(this._dateTime);

  factory DateTimeValueObject.fromString(String value,
      {bool withoutTime = false}) {
    if (value == null) return null;

    var dateTimeConvert = DateTime.tryParse(value) ?? dateFormat.parse(value);

    return DateTimeValueObject.fromDate(dateTimeConvert,
        withoutTime: withoutTime);
  }

  factory DateTimeValueObject.fromDate(DateTime value,
      {bool withoutTime = false}) {
    DateTime dateTimeConvert;
    if (value.year < 1900) {
      if (value.year <= DateTime.now().year - 2000) {
        dateTimeConvert = DateTime(
          value.year + 2000,
          value.month,
          value.day,
          value.hour,
          value.minute,
          value.second,
          value.millisecond,
        );
      } else {
        dateTimeConvert = DateTime(
          value.year + 1900,
          value.month,
          value.day,
          value.hour,
          value.minute,
          value.second,
          value.millisecond,
        );
      }
    } else {
      dateTimeConvert = value;
    }

    if (!withoutTime) {
      return DateTimeValueObject._(dateTimeConvert);
    } else {
      return DateTimeValueObject._(
        DateTime(
          dateTimeConvert.year,
          dateTimeConvert.month,
          dateTimeConvert.day,
        ),
      );
    }
  }

  factory DateTimeValueObject.now({bool withoutTime = false}) {
    if (!withoutTime) {
      return DateTimeValueObject._(DateTime.now());
    } else {
      return DateTimeValueObject._(
        DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
        ),
      );
    }
  }

  DateTimeValueObject copyAndAddDays(int days) => DateTimeValueObject.fromDate(
        _dateTime.add(
          Duration(
            days: days,
          ),
        ),
      );

  DateTime get toDateTime => _dateTime;

  String get toVeryShortStringDateTime => dateFormat2.format(_dateTime);

  String get toShortStringDateTime => dateFormat.format(_dateTime);

  String get toLongStringDateTime => _dateTime.toIso8601String();

  String get toLongStringDateTimeFormatedHour =>
      _dateFormatDMYHM.format(_dateTime);

  String get toLongStringDateTimeFormatedHourWithMs =>
      _dateFormatDMYHMSMs.format(_dateTime);

  String get toDateFormatDataBase => _dateFormatDataBase.format(_dateTime);

  @override
  String toString() {
    return toLongStringDateTime;
  }
}
