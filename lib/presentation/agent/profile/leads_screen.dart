import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LeadsScreen extends StatelessWidget {
  const LeadsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.redAccent),
          onPressed: () {
            context.pop();
          },
        ),
        title: const Text(
          'Leads',
          style: TextStyle(
            color: Color(0xFF1A335D),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          LeadCard(
            status: "New",
            statusColor: Colors.green,
            name: "John Doe",
            property: "Modern Luxury Villa",
            label1: "Offer Amount",
            value1: "£825,000",
            label2: "Date",
            value2: "11/1/2024",
            note: "Interested in viewing this weekend",
          ),
          SizedBox(height: 16),
          LeadCard(
            status: "Scheduled",
            statusColor: Colors.redAccent,
            name: "John Doe",
            property: "Modern Luxury Villa",
            label1: "Schedule Request",
            value1: "11/1/2024",
            label2: "Time",
            value2: "10:15 AM",
            note: "Interested for meeting",
          ),
        ],
      ),
    );
  }
}

class LeadCard extends StatelessWidget {
  final String status, name, property, label1, value1, label2, value2, note;
  final Color statusColor;

  const LeadCard({
    super.key,
    required this.status,
    required this.statusColor,
    required this.name,
    required this.property,
    required this.label1,
    required this.value1,
    required this.label2,
    required this.value2,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  status,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
              const CircleAvatar(
                radius: 16,
                backgroundColor: Color(0xFFF5F5F5),
                child: Icon(
                  Icons.person_add_alt_1,
                  size: 18,
                  color: Colors.redAccent,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            name,
            style: const TextStyle(fontSize: 16, color: Colors.black87),
          ),
          const SizedBox(height: 4),
          Text(
            property,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A335D),
            ),
          ),
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildInfo(label1, value1, isPrice: status == "New"),
              _buildInfo(
                label2,
                value2,
                crossAxisAlignment: CrossAxisAlignment.end,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F9FA),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text('"$note"', style: const TextStyle(color: Colors.grey)),
          ),
          const SizedBox(height: 16),
          const _ContactRow(
            icon: Icons.email_outlined,
            text: "john@example.com",
          ),
          const SizedBox(height: 8),
          const _ContactRow(
            icon: Icons.phone_outlined,
            text: "+880 1234 567890",
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.call, size: 18, color: Colors.white),
                  label: const Text(
                    "Call",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0A1D37),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.chat_bubble_outline,
                    size: 18,
                    color: Colors.redAccent,
                  ),
                  label: const Text(
                    "Message",
                    style: TextStyle(color: Colors.redAccent),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.redAccent),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfo(
    String label,
    String value, {
    bool isPrice = false,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start,
  }) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isPrice ? Colors.redAccent : Colors.black87,
          ),
        ),
      ],
    );
  }
}

class _ContactRow extends StatelessWidget {
  final IconData icon;
  final String text;
  const _ContactRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey),
        const SizedBox(width: 8),
        Text(text, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}
