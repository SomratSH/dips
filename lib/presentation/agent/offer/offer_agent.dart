

import 'package:dips/components/custom_share.dart';
import 'package:dips/components/custom_snackbar.dart';
import 'package:dips/core/routing/route_path.dart';
import 'package:dips/data/agent_model/offfer_model.dart';
import 'package:dips/presentation/agent/home/home_agent_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class OfferAgent extends StatelessWidget {
  const OfferAgent({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeAgentProvider>();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,

        title: const Text('Offer & Leads'),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFFF6F6F8),
      body: Column(
        children: [
          const SizedBox(height: 12),
          _buildFilterChips(),
          const SizedBox(height: 12),
          provider.isLoading
              ? Center(child: CircularProgressIndicator())
              : provider.offerModel.results!.isEmpty
              ? Center(child: Text("No data available"))
              : Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    itemCount: provider.offerModel.results!.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) =>
                     
                       OfferCard(
                        offer: provider.offerModel.results![index],
                        index: index,
                      ),
                    
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    final labels = ['All', 'Accepted', 'Pending', 'Reject'];
    return SizedBox(
      height: 52,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: labels.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          final selected = i == 0;
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: selected ? Colors.red.shade50 : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Center(
              child: Text(
                labels[i],
                style: TextStyle(
                  color: selected ? Colors.red : Colors.grey[700],
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// class Offer {
//   final String status; // e.g. Pending, Accepted
//   final String name;
//   final String title;
//   final String amount;
//   final String date;
//   final String message;
//   final String email;
//   final String phone;
//   final int index;

//   Offer({
//     required this.status,
//     required this.name,
//     required this.title,
//     required this.amount,
//     required this.date,
//     required this.message,
//     required this.email,
//     required this.phone,
//     required this.index
//   });
// }

// final List<Offer> _sampleOffers = [
//   Offer(
//     status: 'Pending',
//     name: 'John Doe',
//     title: 'Modern Luxury Villa',
//     amount: '£825,000',
//     date: '11/1/2024',
//     message: '"Interested in viewing this weekend"',
//     email: 'john@example.com',
//     phone: '+880 1234 567890',
//   ),
//   Offer(
//     status: 'Accepted',
//     name: 'John Doe',
//     title: 'Modern Luxury Villa',
//     amount: '£825,000',
//     date: '11/1/2024',
//     message: 'Cash buyer, ready to close quickly. Can we negotiate?',
//     email: 'john@example.com',
//     phone: '+880 1234 567890',
//   ),
// ];

class OfferCard extends StatelessWidget {
  final Results offer;
  final int index;

  const OfferCard({super.key, required this.offer, required this.index});

  Color _statusColor(String s) {
    switch (s.toLowerCase()) {
      case 'pending':
        return Colors.amber.shade600;
      case 'accepted':
        return Colors.green.shade400;
      case 'reject':
        return Colors.red.shade400;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeAgentProvider>();
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: _statusColor(offer.status!),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    offer.status!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        offer.buyerName!,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        offer.propertyTitle!,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF0C2447),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(Icons.more_vert, size: 20),
                    onPressed: () async {
                      final RenderBox button =
                          context.findRenderObject() as RenderBox;
                      final RenderBox overlay =
                          Navigator.of(
                                context,
                              ).overlay!.context.findRenderObject()
                              as RenderBox;

                      final RelativeRect position = RelativeRect.fromRect(
                        Rect.fromPoints(
                          button.localToGlobal(Offset.zero, ancestor: overlay),
                          button.localToGlobal(
                            Offset(button.size.width, button.size.height),
                            ancestor: overlay,
                          ),
                        ),
                        Offset.zero & overlay.size,
                      );

                      final selected = await showMenu<String>(
                        context: context,
                        position: position,
                        color: const Color(0xFF001A3F),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        items: [
                          buildPopupItem(
                            Icons.check,
                            "Accept",
                            Colors.green,
                            "accept",
                          ),
                          const PopupMenuDivider(height: 1),
                          buildPopupItem(
                            Icons.close,
                            "Reject",
                            Colors.red,
                            "reject",
                          ),
                          const PopupMenuDivider(height: 1),
                          buildPopupItem(
                            Icons.person_add_alt_1,
                            "Add to Leads",
                            Colors.white,
                            "lead",
                          ),
                          const PopupMenuDivider(height: 1),
                          buildPopupItem(
                            Icons.currency_pound,
                            "Counter Offer",
                            Colors.amber,
                            "counter",
                          ),
                        ],
                      );

                      // Handle action safely here
                      if (selected == "accept") {
                        final response = await provider.offerAccpet(
                          offer.id!,
                          index,
                        );

                        if (response) {
                          AppSnackbar.show(
                            context,
                            title: "Offer",
                            message: "Offer Accepted",
                            type: SnackType.success,
                          );
                        }

                        print("Accept clicked");
                      } else if (selected == "reject") {
                        final response = await provider.offerRejected(
                          offer.id!,
                          index,
                        );

                        if (response) {
                          AppSnackbar.show(
                            context,
                            title: "Offer",
                            message: "Offer Rejected",
                            type: SnackType.success,
                          );
                        }
                        print("Reject clicked");
                      } else if (selected == "lead") {
                         final response = await provider.markAsLead(
                          offer.id!,
                          index,
                        );
                        if (response) {
                          AppSnackbar.show(
                            context,
                            title: "Lead",
                            message: "Add to leads",
                            type: SnackType.success,
                          );
                        }
                        print("Add to Leads");
                      } else if (selected == "counter") {
                        print("Counter Offer");

                        if(context.mounted){

                          provider.selectedOfferV(index);
                          context.push(RoutePath.offerDetails);
                        }
                        


                      }
                    },
                  ),
                ),
              ],
            ),

            Divider(color: Colors.grey.shade200),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Offer Amount',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "£ ${offer.offerAmount!}",
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'Date',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      offer.createdAt!.split("T").first,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                offer.message!,
                style: const TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.email_outlined, size: 16, color: Colors.grey),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    offer.email!,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.phone, size: 16, color: Colors.white),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    offer.phone!,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.call, size: 18, color: Colors.white),
                    label: const Text(
                      'Call',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0C2447),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () async{
                  await   ContactActions.openDialer(offer.phone!);
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(
                      Icons.email_outlined,
                      size: 18,
                      color: Colors.red,
                    ),
                    label: const Text(
                      'Email',
                      style: TextStyle(color: Colors.red),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.red),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: ()async {
                     await ContactActions.sendMail(email: offer.email!);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

PopupMenuItem<String> buildPopupItem(
  IconData icon,
  String title,
  Color color,
  String value,
) {
  return PopupMenuItem<String>(
    value: value,
    child: Row(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 12),
        Text(
          title,
          style: TextStyle(
            color: color,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}
