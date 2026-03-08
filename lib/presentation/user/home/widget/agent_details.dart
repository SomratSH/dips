import 'package:dips/components/custom_share.dart';
import 'package:dips/components/custom_snackbar.dart';
import 'package:dips/presentation/user/home/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AgentDetailsModal extends StatelessWidget {
  const AgentDetailsModal({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeProvider>();
    int _selectedRating = 0;
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFF8F9FA),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Gradient Header Section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 30),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFD32F2F),
                  Color(0xFF1A237E),
                  Color(0xFF000B18),
                ],
              ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.business,
                    size: 40,
                    color: Color(0xFF1A237E),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  "Agent Information",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Brand Information Card
                _buildInfoCard(
                  children: [
                    _buildField(
                      Icons.apartment,
                      "",
                      provider
                          .propertyDetailsJson
                          .agent!
                          .agentProfile!
                          .brandName!,
                    ),
                    const SizedBox(height: 16),
                    _buildField(
                      Icons.public,
                      "Brand Website",
                      provider
                          .propertyDetailsJson
                          .agent!
                          .agentProfile!
                          .website!,
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Agent Specific Card
                _buildInfoCard(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Agent Information",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            "Verified Agent",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const CircleAvatar(
                        backgroundColor: Color(0xFFEF5350),
                        radius: 25,
                      ),
                      title: Row(
                        children: [
                          Text(
                            provider.propertyDetailsJson.agent!.fullName!,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 4),
                          provider
                                  .propertyDetailsJson
                                  .agent!
                                  .agentProfile!
                                  .isVerified!
                              ? Icon(
                                  Icons.check_circle,
                                  color: Colors.blue,
                                  size: 16,
                                )
                              : SizedBox(),
                        ],
                      ),
                      subtitle: Row(
                        children: [
                          Icon(Icons.star, color: Colors.orange, size: 14),
                          Text(
                            provider
                                .propertyDetailsJson
                                .agent!
                                .agentProfile!
                                .rating!,
                            style: TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            " • ${provider.propertyDetailsJson.agent!.agentProfile!.ratingCount}}% response rate",
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _buildActionButton(
                            Icons.phone_outlined,
                            "Call",
                            () {
                              ContactActions.openDialer(
                                provider.propertyDetailsJson.agent!.phone ??
                                    provider.propertyDetailsJson.agent!.phone!,
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildActionButton(
                            Icons.email_outlined,
                            "Email",
                            () async {
                              await ContactActions.sendMail(
                                email:
                                    provider.propertyDetailsJson.agent!.email!,
                                body: "I",
                                subject: "Need",
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Close Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF001A3F),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text(
                      "Close",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Rating Section
                const Text(
                  "Rate Your Experience",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const Text(
                  "Tell us how was your experience",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                const SizedBox(height: 12),
                StatefulBuilder(
                  builder: (context, setModalState) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        // index starts at 0, so star 1 is index 0
                        bool isFilled = index < _selectedRating;

                        return GestureDetector(
                          onTap: () async {
                            setModalState(() {
                              _selectedRating = index + 1;
                            });
                            final response = await provider.giveRating(
                              _selectedRating,
                            );
                            // You can also trigger an API call or print here
                            print("Selected Rating: $_selectedRating");
                            if (response) {
                              AppSnackbar.show(
                                context,
                                title: "Rating",
                                message: "Success",
                                type: SnackType.success,
                              );
                            } else {
                              AppSnackbar.show(
                                context,
                                title: "Rating",
                                message: "Not Success",
                                type: SnackType.error,
                              );
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4.0,
                            ),
                            child: Icon(
                              isFilled ? Icons.star : Icons.star_outline,
                              color: const Color(0xFFFFD700),
                              size: 40,
                            ),
                          ),
                        );
                      }),
                    );
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // UI Helpers
  Widget _buildInfoCard({required List<Widget> children}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
        children: children,
      ),
    );
  }

  Widget _buildField(IconData icon, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 18, color: const Color(0xFFEF5350)),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(color: Colors.grey, fontSize: 13),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFF1F3F5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(IconData icon, String label, Function() ontap) {
    return OutlinedButton.icon(
      onPressed: ontap,
      icon: Icon(icon, size: 18, color: Colors.black87),
      label: Text(label, style: const TextStyle(color: Colors.black87)),
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Colors.grey.shade300),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
    );
  }
}
