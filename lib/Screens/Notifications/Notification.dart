import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:intl/intl.dart';

import '../../models/NotifiModel.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<NotificationModel> notifications = [
    NotificationModel(
      type: 'bus',
      title: 'You have a check-up appointment on 10 May',
      details: 'two days left',
      date: DateTime.now(),
      icon: Icons.directions_bus_filled_outlined,
      iconColor: Color(0xff62B6CB),
    ),
    NotificationModel(
      type: 'bus',
      title: 'Bad weather alert',
      details: 'Rainfall 80%',
      date: DateTime.now(),
      icon: Icons.cloudy_snowing,
      iconColor: Color(0xff62B6CB),
    ),
    NotificationModel(
      type: 'bus',
      title: 'You have a check-up appointment on 10 May',
      details: 'two days left',
      date: DateTime.now().subtract(Duration(days: 1)),
      icon: Icons.directions_bus_filled_outlined,
      iconColor: Color(0xff62B6CB),
    ),
    NotificationModel(
      type: 'warning',
      title: 'Phone use was detected while driving',
      details: 'Today , 10:42',
      date: DateTime.now(),
      icon: Icons.warning,
      iconColor: Color(0xffB40000),
    ),
  ];

  String getDateLabel(DateTime date) {
    DateTime today = DateTime.now();
    if (DateFormat('yyyy-MM-dd').format(date) ==
        DateFormat('yyyy-MM-dd').format(today)) {
      return "Today";
    } else if (DateFormat('yyyy-MM-dd').format(date) ==
        DateFormat('yyyy-MM-dd').format(today.subtract(Duration(days: 1)))) {
      return "Yesterday, ${DateFormat('d MMMM').format(date)}";
    } else {
      return DateFormat('d MMMM, yyyy').format(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsets.only(left: 12),
            child: Text('Notifications',
            style:TextStyle(color: Color(0xff1B4965),fontWeight:FontWeight.bold) ,),
          ),
          bottom: const TabBar(
            dividerColor: Colors.transparent,
            indicatorColor: Colors.transparent,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.black54,
            tabs: [
              Tab(text: 'Bus'),
              Tab(text: 'Warnings'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            buildNotificationList('bus'),
            buildNotificationList('warning'),
          ],
        ),
      ),
    );
  }

  Widget buildNotificationList(String type) {
    final filtered = notifications
        .where((n) => n.type == type)
        .toList()
      ..sort((a, b) => b.date.compareTo(a.date));

    Map<String, List<NotificationModel>> grouped = {};
    for (var notification in filtered) {
      final label = getDateLabel(notification.date);
      grouped.putIfAbsent(label, () => []).add(notification);
    }

    return ListView(
      children: grouped.entries
          .map((entry) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30,left: 30),
            child: Text(entry.key,
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold)),
          ),
          ...entry.value.map((n) => NotificationCard(
            notification: n,
            onDelete: () {
              setState(() {
                notifications.remove(n);
              });
            },
          )),
        ],
      ))
          .toList(),
    );
  }
}

class NotificationCard extends StatefulWidget {
  final NotificationModel notification;
  final VoidCallback onDelete;


  const NotificationCard({super.key, required this.notification, required this.onDelete});

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  late FlutterTts flutterTts;

  @override
  void initState() {
    super.initState();
    flutterTts = FlutterTts();

    flutterTts.setStartHandler(() {
      print("Started reading");
    });

    flutterTts.setCompletionHandler(() {
      print("Finished reading");
    });

    flutterTts.setErrorHandler((msg) {
      print("TTS Error: $msg");
    });
  }

  Future<void> _speak(String text) async {
    await flutterTts.setVoice({'name': 'en_us', 'locale': 'en-US'});
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);

    var result = await flutterTts.speak(text);
    print("TTS: speak() returned $result");
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
      child: Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.endToStart,
        background: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
            color: const Color(0xffFF8989),
          ),
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: const Icon(Icons.delete_outline_rounded, color: Colors.black),
        ),
        onDismissed: (direction) async {
          bool confirm = await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Confirm Delete',style: TextStyle(fontWeight:FontWeight.bold,color: Color(0xff62B6CB))),
              content: const Text('Are you sure you want to delete this notification?',style: TextStyle(fontSize: 18)),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Cancel',style: TextStyle(color: Color(0xff62B6CB))),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Delete',style: TextStyle(color: Color(0xff62B6CB))),
                ),
              ],
            ),
          );
          if (confirm) {
            widget.onDelete();
          } else {
            setState(() {});
          }
        },


        child: Center(
          child: Container(
            width: 348,
            height: 90,
            decoration: BoxDecoration(
              color: Color(0xffECECEC),
                borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 5),
                  color:  Colors.black.withOpacity(.2),
                  spreadRadius: 0.5,
                  blurRadius: 1,
                )
              ]
            ),
            child: ListTile(
              leading: Icon(widget.notification.icon, color: widget.notification.iconColor),
              title: Text(widget.notification.title),
              subtitle: Text(widget.notification.details),
              trailing: IconButton(
                icon: Icon(Icons.hearing_outlined),
                onPressed: () {
                  _speak('${widget.notification.title}. ${widget.notification.details}');
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
