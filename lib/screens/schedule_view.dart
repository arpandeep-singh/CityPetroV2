///Dart imports
import 'dart:math';

///Package imports
import 'package:flutter/material.dart';

///calendar import
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:velocity_x/velocity_x.dart';

///Local import

/// Widget class of Schedule view calendar
class ScheduleViewCalendar extends StatefulWidget {
  /// Creates Schedule view calendar
  const ScheduleViewCalendar({Key? key}) : super(key: key);

  @override
  _ScheduleViewCalendarState createState() => _ScheduleViewCalendarState();
}

class _ScheduleViewCalendarState extends State<ScheduleViewCalendar> {
  _ScheduleViewCalendarState();

  late _DataSource events;
  List<Appointment> appts = [];

  @override
  void initState() {
    events = _DataSource(_getAppointments());
    super.initState();
    //getSchedule();
  }

  void getSchedule() {
    Future.delayed(Duration(milliseconds: 0)).then((value) {
      setState(() {
        appts = _getAppointments();
        events = _DataSource(appts);
      });
    });
  }

  /// Method that creates the collection the data source for calendar, with
  /// required information.
  List<Appointment> _getAppointments() {
    final List<String> subjectCollection = <String>[];
    subjectCollection.add('General Meeting');
    subjectCollection.add('Plan Execution');
    subjectCollection.add('Project Plan');
    subjectCollection.add('Consulting');
    subjectCollection.add('Support');
    subjectCollection.add('Development Meeting');
    subjectCollection.add('Project Completion');
    subjectCollection.add('Release updates');
    subjectCollection.add('Performance Check');

    final List<Color> colorCollection = <Color>[];
    colorCollection.add(const Color(0xFF0F8644));
    colorCollection.add(const Color(0xFF8B1FA9));
    colorCollection.add(const Color(0xFFD20100));
    colorCollection.add(const Color(0xFFFC571D));
    colorCollection.add(const Color(0xFF36B37B));
    colorCollection.add(const Color(0xFF01A1EF));
    colorCollection.add(const Color(0xFF3D4FB5));
    colorCollection.add(const Color(0xFFE47C73));
    colorCollection.add(const Color(0xFF636363));
    colorCollection.add(const Color(0xFF0A8043));

    final Random random = Random();
    final DateTime rangeStartDate =
        DateTime.now().add(const Duration(days: -(365 ~/ 2)));
    final DateTime rangeEndDate = DateTime.now().add(const Duration(days: 365));
    final List<Appointment> appointments = <Appointment>[];
    for (DateTime i = rangeStartDate;
        i.isBefore(rangeEndDate);
        i = i.add(Duration(days: 1))) {
      final DateTime date = i;
      final DateTime startDate =
          DateTime(date.year, date.month, date.day, 5, 0, 0);
      appointments.add(Appointment(
          subject: "Arpandeep Singh",
          notes: "T-150",
          startTime: startDate,
          endTime: startDate.add(Duration(hours: 12)),
          color: colorCollection[random.nextInt(9)],
          isAllDay: false,
          location: ""));
    }
    return appointments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "SCHEDULE".text.textStyle(TextStyle(fontSize: 16)).make(),
      ),
      body: 
          Container(
              //color: model.cardThemeColor,
              child: getScheduleViewCalendar(
                  events: events, scheduleViewBuilder: scheduleViewBuilder)),
    );
  }

  /// returns the calendar widget based on the properties passed
  SfCalendar getScheduleViewCalendar(
      {_DataSource? events, dynamic scheduleViewBuilder}) {
    return SfCalendar(
      showDatePickerButton: true,
      scheduleViewSettings: ScheduleViewSettings(),
      scheduleViewMonthHeaderBuilder: scheduleViewBuilder,
      view: CalendarView.schedule,
      blackoutDates: [DateTime.now().add(Duration(days: 2))],
      dataSource: events,
      // timeSlotViewSettings:
      //     TimeSlotViewSettings(timelineAppointmentHeight: 200),
      appointmentBuilder: appointmentBuilder,
    );
  }

  Widget appointmentBuilder(BuildContext context,
      CalendarAppointmentDetails calendarAppointmentDetails) {
    final Appointment appointment =
        calendarAppointmentDetails.appointments.first;
    return 1 == 2
        ? Container(
            decoration: BoxDecoration(
              //color: Colors.red.withOpacity(0.1),
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
            ),
            width: calendarAppointmentDetails.bounds.width,
            alignment: Alignment.centerLeft,
            //height: calendarAppointmentDetails.bounds.height,
            child: Text(
              '',
              style: TextStyle(
                fontSize: 12,
              ),
            ).px12().py(5),
          )
        : Container(
            decoration: BoxDecoration(
              color: context.accentColor.withOpacity(0.1),
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
            ),
            width: calendarAppointmentDetails.bounds.width,
            //height: calendarAppointmentDetails.bounds.height,
            child: Text(
              '${appointment.subject}\n${appointment.notes}',
              style: TextStyle(fontSize: 12),
            ).px12().py(5),
          );
  }

  Widget scheduleViewBuilder(
      BuildContext buildContext, ScheduleViewMonthHeaderDetails details) {
    final String monthName = _getMonthDate(details.date.month);
    return Stack(
      children: <Widget>[
        Image(
            image: ExactAssetImage('assets/images/' + monthName + '.png'),
            fit: BoxFit.cover,
            width: details.bounds.width,
            height: details.bounds.height),
        Positioned(
          left: 55,
          right: 0,
          top: 20,
          bottom: 0,
          child: Text(
            monthName + ' ' + details.date.year.toString(),
            style: const TextStyle(fontSize: 18),
          ),
        )
      ],
    );
  }
}

String _getMonthDate(int month) {
  if (month == 01) {
    return 'January';
  } else if (month == 02) {
    return 'February';
  } else if (month == 03) {
    return 'March';
  } else if (month == 04) {
    return 'April';
  } else if (month == 05) {
    return 'May';
  } else if (month == 06) {
    return 'June';
  } else if (month == 07) {
    return 'July';
  } else if (month == 08) {
    return 'August';
  } else if (month == 09) {
    return 'September';
  } else if (month == 10) {
    return 'October';
  } else if (month == 11) {
    return 'November';
  } else {
    return 'December';
  }
}

/// An object to set the appointment collection data source to collection, and
/// allows to add, remove or reset the appointment collection.
class _DataSource extends CalendarDataSource {
  _DataSource(List<Appointment> source) {
    appointments = source;
  }
}
