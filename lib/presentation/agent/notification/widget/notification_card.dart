import 'package:dips/components/custom_snackbar.dart';
import 'package:dips/presentation/agent/home/home_agent_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationCard extends StatelessWidget {
  final Color bgColor;
  final Color iconBg;
  final IconData icon;
  final String title;
  final String subtitle;
  final String id;
  final bool markasread;
  final int index;

  const NotificationCard({
    super.key,
    required this.markasread,
    required this.index,
    required this.id,
    required this.bgColor,
    required this.iconBg,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeAgentProvider>();
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Icon
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: Colors.white),
              ),
              const SizedBox(width: 12),

              /// Text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            "New",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          /// Actions
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              markasread ? Text("Mark as added") : OutlinedButton(
                onPressed: () async{
                    final response = await provider.markAsRead(id, index);

                    if(response){
                      AppSnackbar.show(context, title: "Mark as read", message: "Mark as read added", type: SnackType.success);
                    }else{
                      AppSnackbar.show(context, title: "Mark as read", message: "Mark as read not added", type: SnackType.error);
                    }
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF0B1E4A)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  "Mark all as read",
                  style: TextStyle(color: Color(0xFF0B1E4A)),
                ),
              ),
              
            ],
          ),
        ],
      ),
    );
  }
}
