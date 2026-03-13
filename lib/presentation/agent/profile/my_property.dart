import 'package:dips/components/custom_loading_dialog.dart';
import 'package:dips/components/custom_snackbar.dart';
import 'package:dips/domain/entity/property_model.dart';
import 'package:dips/presentation/agent/home/home_agent_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import 'dart:typed_data';
import 'package:gal/gal.dart';

class MyProperty extends StatelessWidget {
  const MyProperty({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeAgentProvider>();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        title: const Text('My Properties'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),
          _buildFilterChips(provider),
          const SizedBox(height: 12),
          provider.isLoading
              ? Center(child: CircularProgressIndicator())
              : provider.myPropertyList.isEmpty
              ? Center(child: Text("No data"))
              : Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    itemCount: provider.myPropertyList.length,
                    itemBuilder: (context, index) {
                      final p = provider.myPropertyList[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: PropertyCard(property: p),
                      );
                    },
                  ),
                ),
        ],
      ),
      backgroundColor: const Color(0xFFF6F6F8),
    );
  }

  Widget _buildFilterChips(HomeAgentProvider provider) {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        scrollDirection: Axis.horizontal,
        itemCount: provider.propertyType.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          // Compare with provider's current index
          final bool isSelected = provider.selectedTypeIndex == index;

          return InkWell(
            onTap: () async {
              provider.setSelectedType(index);
              await provider.getPropertySearch(provider.propertyType[index]);
              // Update the state on tap
            },
            borderRadius: BorderRadius.circular(
              20,
            ), // Keeps ripple effect clean
            child: Chip(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              backgroundColor: isSelected ? Colors.red.shade50 : Colors.white,
              shape: StadiumBorder(
                side: BorderSide(
                  color: isSelected
                      ? Colors.red.shade200
                      : Colors.grey.shade300,
                  width: 1,
                ),
              ),
              label: Text(
                provider.propertyType[index],
                style: TextStyle(
                  color: isSelected ? Colors.red : Colors.grey[700],
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class PropertyCard extends StatelessWidget {
  final PropertyModel property;

  const PropertyCard({super.key, required this.property});

  Color _statusColor(String s) {
    switch (s.toLowerCase()) {
      case 'new':
        return Colors.green.shade600;
      case 'feature':
        return Colors.red.shade600;
      case 'pending':
        return Colors.blue.shade600;
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with overlay badges
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.network(
                      property.image == ""
                          ? "https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=800"
                          : property.image,
                      fit: BoxFit.cover,
                      errorBuilder: (c, e, s) =>
                          Container(color: Colors.grey[300]),
                    ),
                  ),
                ),
                Positioned(
                  left: 12,
                  top: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: _statusColor(
                        property.isNew!
                            ? "New"
                            : property!.isFeature!
                            ? "Feature"
                            : "N/A",
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      property.isNew!
                          ? "New"
                          : property!.isFeature!
                          ? "Feature"
                          : "N/A",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 12,
                  top: 12,
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.95),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: const Icon(Icons.qr_code, size: 20),
                      onPressed: () async {
                        if (property.qrCode.isNotEmpty ||
                            property.qrCode != "") {
                          _showQrDialog(context, property.qrCode);
                        } else {
                          CustomLoading.show(context);
                          final response = await provider.createQrCode(
                            property.id,
                          );
                          CustomLoading.hide(context);
                          if (response.isNotEmpty || response != "") {
                            _showQrDialog(context, response);
                          } else {
                            AppSnackbar.show(
                              context,
                              title: "Qr Code Image",
                              message: "Something wrong",
                              type: SnackType.error,
                            );
                          }
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    property.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    property.price.toString(),
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.red,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 16,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          property.location,
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _iconText(Icons.king_bed, '${property.bed} Beds'),
                      const SizedBox(width: 12),
                      _iconText(Icons.bathtub, '${property.baths} Baths'),
                      const SizedBox(width: 12),
                      _iconText(Icons.square_foot, property.size.toString()),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.remove_red_eye_outlined,
                            size: 16,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                      // Row(
                      //   children: [
                      //     const Icon(
                      //       Icons.qr_code_scanner,
                      //       size: 16,
                      //       color: Colors.grey,
                      //     ),
                      //     const SizedBox(width: 6),
                      //     Text(
                      //       '${property.scans} scans',
                      //       style: TextStyle(color: Colors.grey[700]),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _iconText(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.red.shade400),
        const SizedBox(width: 6),
        Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    );
  }
}

void _showQrDialog(BuildContext context, String url) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Property QR Code", textAlign: TextAlign.center),
          InkWell(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.cancel_outlined, color: Color(0xff041E41),))
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              url,
              height: 200,
              width: 200,
              fit: BoxFit.cover,
              loadingBuilder:
                  (
                    BuildContext context,
                    Widget child,
                    ImageChunkEvent? loadingProgress,
                  ) {
                    if (loadingProgress == null)
                      return child; // Image is fully loaded
                    return SizedBox(
                      height: 200,
                      width: 200,
                      child: Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      ),
                    );
                  },
              errorBuilder: (context, error, stackTrace) => Container(
                height: 200,
                width: 200,
                color: Colors.grey[200],
                child: const Icon(
                  Icons.broken_image,
                  size: 50,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Scan to view property details",
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
      actions: [
       
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(const Color(0xff041E41)),
            ),
            onPressed: () => _saveQrToLocal(context, url),
            icon: const Icon(Icons.save_alt, color: Colors.white,),
            label: const Text("Download QR Code", style: TextStyle(color: Colors.white),),
          ),
        ),
      ],
    ),
  );
}

Future<void> _saveQrToLocal(BuildContext context, String url) async {
  try {
    var response = await Dio().get(
      url,
      options: Options(responseType: ResponseType.bytes),
    );

    // Use Gal to save bytes
    await Gal.putImageBytes(Uint8List.fromList(response.data));

    AppSnackbar.show(
      context,
      title: "Success",
      message: "QR Code saved to gallery!",
    );
  } catch (e) {
    AppSnackbar.show(context, title: "Error", message: "Could not save image");
  }
}
