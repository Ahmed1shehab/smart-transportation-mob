import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:member/config/app_text_styles.dart';
import 'package:member/core/helper/colors_manager.dart';
import 'package:member/features/home/presentation/views/tabs/students/widgets/show_driver_info_dialog.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final Map<DateTime, String> statusMap = {
    DateTime.now().subtract(Duration(days: 1)): 'attended',
    DateTime.now(): 'today',
    DateTime.now().add(Duration(days: 4)): 'absent',
    DateTime.now().add(Duration(days: 7)): 'parent',
  };

  Color? _getMarkerColor(DateTime day) {
    final key = DateTime.utc(day.year, day.month, day.day);
    switch (statusMap[key]) {
      case 'today':
        return Color(0XFF735BF2);
      case 'attended':
        return Color(0XFF6FB677);
      case 'absent':
        return Color(0XFFEB5144);
      case 'parent':
        return Color(0XFF5073FF);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Calendar",
          style: AppTextStyles.heading.copyWith(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        leading: const BackButton(),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    children: const [
                      Text("Attendance", style: TextStyle(color: Colors.blue)),
                      Text("  - Upcoming Days  "),
                    ],
                  ),
                  Row(
                    children: const [
                      Text(
                        "Previous Trip Info",
                        style: TextStyle(color: Colors.blue),
                      ),
                      Text(" - Past Days"),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // التاريخ فقط بدون زر "2 weeks"
            Text(
              DateFormat.yMMMM().format(_focusedDay),
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),

            TableCalendar(
              firstDay: DateTime.now().subtract(const Duration(days: 30)),
              lastDay: DateTime.now().add(const Duration(days: 30)),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                final yesterday = DateTime.now().subtract(Duration(days: 1));
                final normalizedYesterday = DateTime(
                  yesterday.year,
                  yesterday.month,
                  yesterday.day,
                );

                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;

                  if (isSameDay(selectedDay, normalizedYesterday)) {
                    showDriverInfoDialog(context);
                  }
                });
              },
              calendarFormat: CalendarFormat.month, // ثبات العرض على شكل شهر
              headerVisible: false, // إخفاء الهيدر تمامًا (اللي فيه زر 2 weeks)
              availableCalendarFormats: const {CalendarFormat.month: 'Month'},
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.purple,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Color(0XFF735BF2),
                  shape: BoxShape.circle,
                ),
                defaultDecoration: BoxDecoration(shape: BoxShape.circle),
              ),
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, day, events) {
                  final color = _getMarkerColor(normalizeDate(day));
                  if (color != null) {
                    return Positioned(
                      bottom: 4,
                      child: Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),

            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Wrap(
                runSpacing: 8,
                spacing: 20,
                children: const [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _LegendItem(color: Color(0XFF735BF2), label: 'Today'),
                      SizedBox(height: 8),
                      _LegendItem(color: Color(0XFF6FB677), label: 'Attended'),
                      SizedBox(height: 8),
                      _LegendItem(color: Color(0XFFEB5144), label: 'Absent'),
                      SizedBox(height: 8),
                      _LegendItem(
                        color: Color(0XFF5073FF),
                        label: 'Parent Pick up',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

DateTime normalizeDate(DateTime date) {
  return DateTime.utc(date.year, date.month, date.day);
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendItem({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(radius: 10.r, backgroundColor: color),
        const SizedBox(width: 6),
        Text(label),
      ],
    );
  }
}
