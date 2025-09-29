import 'package:flutter/material.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  bool generalNotification = true;
  bool sound = true;
  bool vibration = true;
  bool announcements = false;
  bool newPatientAssignments = false;
  bool shiftSwapRequests = true;
  bool labResultsNotifications = false;
  bool shiftReminders = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // leading: IconButton(
        //   icon: const Icon(Icons.menu, color: Color(0xFF5B9FBF)),
        //   onPressed: () {},
        // ),
        title: const Text(
          'Notification Setting',
          style: TextStyle(
            color: Color(0xFF5B9FBF),
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        // actions: [
        //   IconButton(
        //     icon: const Icon(
        //       Icons.notifications_outlined,
        //       color: Color(0xFF5B9FBF),
        //     ),
        //     onPressed: () {},
        //   ),
        //   IconButton(
        //     icon: const Icon(Icons.settings, color: Color(0xFF5B9FBF)),
        //     onPressed: () {},
        //   ),
        // ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: [
          NotificationTile(
            title: 'General Notification',
            value: generalNotification,
            onChanged: (val) => setState(() => generalNotification = val),
          ),
          NotificationTile(
            title: 'Sound',
            value: sound,
            onChanged: (val) => setState(() => sound = val),
          ),
          NotificationTile(
            title: 'Vibration',
            value: vibration,
            onChanged: (val) => setState(() => vibration = val),
          ),
          NotificationTile(
            title: 'Announcements',
            value: announcements,
            onChanged: (val) => setState(() => announcements = val),
          ),
          NotificationTile(
            title: 'New Patient Assignments',
            value: newPatientAssignments,
            onChanged: (val) => setState(() => newPatientAssignments = val),
          ),
          NotificationTile(
            title: 'Shift Swap Requests',
            value: shiftSwapRequests,
            onChanged: (val) => setState(() => shiftSwapRequests = val),
          ),
          NotificationTile(
            title: 'Lab Results Notifications',
            value: labResultsNotifications,
            onChanged: (val) => setState(() => labResultsNotifications = val),
          ),
          NotificationTile(
            title: 'Shift Reminders',
            value: shiftReminders,
            onChanged: (val) => setState(() => shiftReminders = val),
          ),
        ],
      ),
    );
  }
}

class NotificationTile extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  const NotificationTile({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.black87,
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.white,
            activeTrackColor: const Color(0xFF5B9FBF),
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: const Color(0xFFBDD9E8),
          ),
        ],
      ),
    );
  }
}
