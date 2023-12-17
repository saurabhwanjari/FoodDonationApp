import 'package:cloud_firestore/cloud_firestore.dart';

class DateTimeFormat {
  //Getting date
  static String getFormatedDate(Timestamp timestamp) {
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch);
    
    //date logic
    int dayValue = dateTime.day;
    int monthValue = dateTime.month;

    String day =
        dayValue >= 10 ? dayValue.toString() : '0${dayValue.toString()}';

    String month =
        dayValue >= 10 ? monthValue.toString() : '0${monthValue.toString()}';

    String date = '$day-$month-${dateTime.year}';

    return date;
  }

  //Getting time
  static String getFormatedTime(Timestamp timestamp) {
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch);
    // time logic
    int hourValue = dateTime.hour;
    String hour =
        hourValue >= 10 ? hourValue.toString() : '0${hourValue.toString()}';
    
    //Logic to get 12 hours time format
    if(hourValue > 12) {
      int hr = hourValue - 12;
      hour = hr.toString();
    }
    
    int minuteValue = dateTime.minute;
    String minute = minuteValue >= 10
        ? minuteValue.toString()
        : '0${minuteValue.toString()}';

    String ampm = hourValue >= 12 ? 'PM' : 'AM';

    String time = '$hour:$minute $ampm';

    return time;
  }
}