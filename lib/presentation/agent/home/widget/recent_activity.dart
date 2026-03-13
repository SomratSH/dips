import 'package:dips/presentation/agent/home/home_agent_provider.dart';
import 'package:dips/presentation/agent/home/widget/activity_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecentActivityCard extends StatelessWidget {
  const RecentActivityCard({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeAgentProvider>();
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
        children: [
          Text(
            "Recent Activity",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 12),

          (provider.agentDashboardModel.recentActivity?.isEmpty ?? true)
              ? const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text("No activity available"),
                  ),
                )
              : Column(
                  children: [
                    // 2. Use the spread operator for a cleaner list injection
                    for (var data
                        in provider.agentDashboardModel.recentActivity!)
                      ActivityItem(
                        // 3. Dynamic color logic (optional suggestion: green for 'Completed', etc.)
                        color: Colors.green,
                        title: data.propertyName ?? 'Unknown Property',
                        subtitle: data.activity ?? 'No details provided',
                        time: data.time ?? '',
                      ),
                  ],
                ),
          Divider(),
        ],
      ),
    );
  }
}
