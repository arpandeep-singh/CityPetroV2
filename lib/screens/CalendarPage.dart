import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:velocity_x/velocity_x.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({ Key? key }) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: "Schedule".text.textStyle(TextStyle(fontSize: 16)).make(),),
      body: Container(
    child: SfCalendar(
      view: CalendarView.schedule,
      dataSource: MeetingDataSource(_getDataSource()),
      scheduleViewSettings:ScheduleViewSettings(

          //  weekHeaderSettings: WeekHeaderSettings(
          //      startDateFormat: 'dd MMM ',
          //      endDateFormat: 'dd MMM, yy',
          //      height: 50,
          //      textAlign: TextAlign.center,
          //      backgroundColor: Colors.red,
          //      weekTextStyle: TextStyle(
          //        color: Colors.white,
          //        fontWeight: FontWeight.w400,
          //        fontSize: 15,
          //      ))
               
               ),
     
      // monthViewSettings: MonthViewSettings(
      //         appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
      showCurrentTimeIndicator: false,
      showDatePickerButton: true,
      //firstDayOfWeek: 1,
      blackoutDates: [DateTime.now().add(Duration(days: 2))],
      
      //maxDate: DateTime.now(),
      //showWeekNumber: true,
      
    ),
  ));
  }
  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    final DateTime startTime =
    DateTime(today.year, today.month, today.day, 0, 0, 0);
    final DateTime endTime = startTime.add(const Duration(hours: 4));
    meetings.add(
        Meeting('Arpandeep Singh', startTime, endTime, const Color(0xFF0F8644), true),
        );
     meetings.add(
        Meeting('Arpandeep Singh', today.add(Duration(days: 1)), today.add(Duration(days: 1)), const Color(0xFF0F8644), true),
        );
      meetings.add(
        Meeting('Arpandeep Singh', today.add(Duration(days: 2)), today.add(Duration(days: 2)), const Color(0xFF0F8644), true),
        );
    return meetings;
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source){
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}