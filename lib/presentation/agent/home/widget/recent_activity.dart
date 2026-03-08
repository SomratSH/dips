import 'package:dips/presentation/agent/home/widget/activity_item.dart';
import 'package:flutter/material.dart';


class RecentActivityCard extends StatelessWidget {
  const RecentActivityCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1.11,
            color: Colors.black.withValues(alpha: 0.10),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 2,
            offset: Offset(0, 2),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "Recent Activity",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 12),

          ActivityItem(
            color: Colors.green,
            title: "Modern Villa Downtown",
            subtitle: "New offer received",
            time: "2 hours ago",
          ),
          Divider(),

          ActivityItem(
            color: Colors.blue,
            title: "Cozy Beach House",
            subtitle: "QR code scanned",
            time: "4 hours ago",
          ),
          Divider(),

          ActivityItem(
            color: Colors.purple,
            title: "Luxury Penthouse",
            subtitle: "12 new views",
            time: "5 hours ago",
          ),
          Divider(),

          ActivityItem(
            color: Colors.orange,
            title: "Family Home Suburbia",
            subtitle: "Lead inquiry",
            time: "1 day ago",
          ),
        ],
      ),
    );
  }
}
