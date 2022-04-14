import 'dart:core';

import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

DateTimeConverter(String dateTimeBy){

  String sdata = 'April 20, 2020';
/*
List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
 */


  int current_mon;
  List months =
  ['jan', 'feb', 'mar', 'apr', 'may','jun','jul','aug','sep','oct','nov','dec'];
print("DateFormat('yyyy-MM-dd hh:mm').format(DateTime(int.parse(dateTimeBy)))");

print(DateFormat('MMMM').format(DateTime.parse(dateTimeBy)));
print(DateFormat('yyyy').format(DateTime.parse(dateTimeBy)));
print(DateFormat('d').format(DateTime.parse(dateTimeBy)));

return (DateFormat.yMMMMd('tr_TR').format(DateTime.parse(dateTimeBy)));
/*
print("DateFormat('yyyy-MM-dd hh:mm').format(DateTime(int.parse(dateTimeBy)))");
  var now =  DateTime(int.parse(dateTimeBy));
  current_mon = now.month;
  print(months[current_mon-1]);
  return print(months[current_mon-1]);
 */


  /*
    DateTime _dateTime = DateTime(
      int.parse(sdata.substring(sdata.length - 4, sdata.length)),
      months.indexOf(sdata.split(' ')[0]) + 1,
      int.parse(sdata.substring(sdata.length - 8, sdata.length - 6)));
  print(_dateTime);
  return _dateTime;
   */

  
  
}
