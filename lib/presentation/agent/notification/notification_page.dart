import 'package:dips/presentation/agent/notification/widget/notification_card.dart';
import 'package:flutter/material.dart';


class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.red),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Notifications",
          style: TextStyle(
            color: Color(0xFF041E41),
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Header row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Notifications",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF041E41),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0B1E4A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    "Mark all as read",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            /// Notifications
            const NotificationCard(
              bgColor: Color(0xFFE3EFFF),
              iconBg: Color(0xFFD2B7FF),
              icon: Icons.currency_pound,
              title: "Counter Offer Received",
              subtitle:
                  "David Martinez has proposed a counter offer on your property.",
            ),

            const SizedBox(height: 16),

            const NotificationCard(
              bgColor: Color(0xFFFFE9E6),
              iconBg: Color(0xFF7CCBFF),
              icon: Icons.timer,
              title: "Appointment Request",
              subtitle: "Jennifer Lee confirmed the viewing appointment.",
            ),
          ],
        ),
      ),
    );
  }
}
