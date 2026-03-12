import 'package:dips/components/custom_loading_dialog.dart';
import 'package:dips/components/custom_snackbar.dart';
import 'package:dips/presentation/agent/home/home_agent_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class OfferDetails extends StatefulWidget {
  const OfferDetails({super.key});

  @override
  State<OfferDetails> createState() => _OfferDetailsState();
}

class _OfferDetailsState extends State<OfferDetails> {
  final _formKey = GlobalKey<FormState>();
  final _counterPriceCtrl = TextEditingController();
  final _messageCtrl = TextEditingController();

  @override
  void dispose() {
    _counterPriceCtrl.dispose();
    ;
    _messageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeAgentProvider>();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text('Offer & Leads'),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFFF6F6F8),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            const Text(
              'Create Counter Offer',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 6),
            const Text(
              'Review the original offer and submit your counter proposal',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 14),

            // Original Offer Details Card
            Material(
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
                      children: [
                        const Icon(Icons.attach_money, color: Colors.red),
                        const SizedBox(width: 8),
                        const Text(
                          'Original Offer Details',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.blue.shade50,
                          child: const Text(
                            'SJ',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              provider.selectedOffer.buyerName!,
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Buyer',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        const Text(
                          '2 hours ago',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Property',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            provider.selectedOffer.propertyTitle!,
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Offer Amount',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '£${provider.selectedOffer.offerAmount}',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Buyer\'s Message',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            provider.selectedOffer.message!,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Counter Offer Form
            Material(
              elevation: 2,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(14),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.note_add_outlined,
                            color: Colors.red,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Your Counter Offer',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Counter Price
                      const Text(
                        'Counter Price',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: _counterPriceCtrl,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          prefixText: '£ ',
                          hintText: 'Enter counter price',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        validator: (v) => (v == null || v.trim().isEmpty)
                            ? 'Enter counter price'
                            : null,
                      ),
                      const SizedBox(height: 8),
                       Text(
                        'Original offer: £${provider.selectedOffer.offerAmount}',
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 12),

                      // Proposed Closing Date
                      const SizedBox(height: 12),

                      // Counter Offer Message
                      const Text(
                        'Counter Offer Message',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: _messageCtrl,
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText:
                              'Add any additional terms or explanations for your counter offer...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),

                      const SizedBox(height: 14),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () =>   context.pop(),
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: Colors.grey.shade300),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                'Cancel',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () async {
                                if (_counterPriceCtrl.text.isNotEmpty &&
                                    _messageCtrl.text.isNotEmpty) {
                                      CustomLoading.show(context);
                                  final response = await provider
                                      .makeCounterOffer(
                                        provider.selectedOffer.id!,
                                        {
                                          "amount": _counterPriceCtrl.text,
                                          "message": _messageCtrl.text,
                                        },
                                      );

                                  if (response) {
                                                                          CustomLoading.hide(context);
                                    AppSnackbar.show(
                                      context,
                                      title: "Counter Offer",
                                      message:
                                          "Counter Offer sents successfully",
                                      type: SnackType.success,
                                    );
                                    context.pop();
                                  }
                                }else{
                                                                        CustomLoading.hide(context);
                                }
                              },
                              icon: const Icon(
                                Icons.send,
                                size: 18,
                                color: Colors.white,
                              ),
                              label: const Text(
                                'Send Counter Offer',
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF0C2447),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
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
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

// Keep old placeholder export available if other files import MyWidget
class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const OfferDetails();
  }
}
