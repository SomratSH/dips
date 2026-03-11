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
        children:  [
          Text(
            "Recent Activity",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 12),

       provider.agentDashboardModel.recentActivity!.isEmpty ? Center(
        child: Text("No acitvity available")
       ) : Column(
          children: List.generate(provider.agentDashboardModel.recentActivity!.length, (index) {
            final data = provider.agentDashboardModel.recentActivity![index];
            return Column(
              children: [
                 ActivityItem(
            color: Colors.green,
            title: data.propertyName!,
            subtitle: data.activity!,
            time: data.time!,
          ),
          Divider(),
              ],
            );
          }),
        )

         
        ],
      ),
    );
  }
}
