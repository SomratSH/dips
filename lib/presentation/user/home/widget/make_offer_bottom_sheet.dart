import 'package:dips/components/custom_loading_dialog.dart';
import 'package:dips/components/custom_snackbar.dart';
import 'package:dips/presentation/user/home/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MakeOfferBottomSheet extends StatefulWidget {
  const MakeOfferBottomSheet({Key? key}) : super(key: key);

  @override
  State<MakeOfferBottomSheet> createState() => _MakeOfferBottomSheetState();
}

class _MakeOfferBottomSheetState extends State<MakeOfferBottomSheet> {
  final TextEditingController fullNameController = TextEditingController(
    text: '',
  );
  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController phoneController = TextEditingController(text: '');
  final TextEditingController offerController = TextEditingController(text: '');
  final TextEditingController messageController = TextEditingController(
    text: '',
  );

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeProvider>();
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Drag handle
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Make Offer',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.close),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Submit your offer for this property. The agent will review it and contact you.',
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                      const SizedBox(height: 24),

                      // Property Card
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment(0.00, 0.00),
                            end: Alignment(1.00, 1.00),
                            colors: [
                              const Color(0xFFE63946),
                              const Color(0xFF752B43),
                              const Color(0xFF041E41),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.home,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    provider.propertyDetailsJson.title!,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    '£${provider.propertyDetailsJson.price}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Full Name
                      _buildTextField(
                        icon: Icons.person_outline,
                        label: 'Full Name',
                        controller: fullNameController,
                      ),

                      const SizedBox(height: 16),

                      // Email
                      _buildTextField(
                        icon: Icons.email_outlined,
                        label: 'Email',
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                      ),

                      const SizedBox(height: 16),

                      // Phone Number
                      _buildTextField(
                        icon: Icons.phone_outlined,
                        label: 'Phone Number',
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                      ),

                      const SizedBox(height: 16),

                      // Offer Amount
                      _buildTextField(
                        icon: Icons.attach_money,
                        label: 'Offer Amount',
                        controller: offerController,
                        keyboardType: TextInputType.number,
                      ),

                      const SizedBox(height: 16),

                      // Message
                      _buildTextField(
                        icon: Icons.message_outlined,
                        label: 'Message (Optional)',
                        controller: messageController,
                        maxLines: 3,
                      ),

                      const SizedBox(height: 24),

                      // Submit Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            CustomLoading.show(context);
                            final response = await provider.makeOffer(
                              fullNameController.text,
                              emailController.text,
                              offerController.text,
                              phoneController.text,
                              messageController.text.isEmpty
                                  ? ""
                                  : messageController.text,
                            );
                            CustomLoading.hide(context);

                            if (response) {
                              Navigator.pop(context);
                              AppSnackbar.show(
                                context,
                                title: "Make Offer",
                                message: "Make offer successfully",
                                type: SnackType.success,
                              );
                            } else {
                              Navigator.pop(context);
                              AppSnackbar.show(
                                context,
                                title: "Make Offer",
                                message: "Make offer not successfully",
                                type: SnackType.error,
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1A237E),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Submit Offer',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTextField({
    required IconData icon,
    required String label,
    required TextEditingController controller,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 18, color: Colors.grey[600]),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[50],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF1A237E), width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    offerController.dispose();
    messageController.dispose();
    super.dispose();
  }
}
