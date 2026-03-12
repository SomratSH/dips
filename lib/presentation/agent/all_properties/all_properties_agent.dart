import 'package:dips/domain/entity/property_model.dart';
import 'package:dips/presentation/agent/home/home_agent_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllPropertiesAgent extends StatelessWidget {
  const AllPropertiesAgent({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeAgentProvider>();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        title: const Text('All Properties'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),
          _buildFilterChips(provider),
          const SizedBox(height: 12),
        provider.isLoading  ? Center(
          child: CircularProgressIndicator()
        ) : provider.propertyList.isEmpty ? Center(
          child: Text("No data")
        )  : Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: provider.propertyList.length,
              itemBuilder: (context, index) {
                final p = provider.propertyList[index];
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
          onTap: () async{
            provider.setSelectedType(index);
          await  provider.getPropertySearch(provider.propertyType[index]);
             // Update the state on tap
          },
          borderRadius: BorderRadius.circular(20), // Keeps ripple effect clean
          child: Chip(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            backgroundColor: isSelected ? Colors.red.shade50 : Colors.white,
            shape: StadiumBorder(
              side: BorderSide(
                color: isSelected ? Colors.red.shade200 : Colors.grey.shade300,
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

// class Property {
//   final String title;
//   final String price;
//   final String address;
//   final int beds;
//   final int baths;
//   final String area;
//   final String imageUrl;
//   final String status;
//   final int views;
//   final int scans;

//   Property({
//     required this.title,
//     required this.price,
//     required this.address,
//     required this.beds,
//     required this.baths,
//     required this.area,
//     required this.imageUrl,
//     required this.status,
//     required this.views,
//     required this.scans,
//   });
// }



// final List<Property> _sampleProperties = [
//   Property(
//     title: 'Modern 3-Bed Appartment',
//     price: '£850,000',
//     address: '123 Main Street, Los Angeles',
//     beds: 2,
//     baths: 2,
//     area: '950 sqft',
//     imageUrl:
//         'https://thumbs.dreamstime.com/b/modern-apartment-interior-grey-sofa-footstool-armcha-armchair-wooden-floor-tv-colorful-graphic-photo-concept-122713421.jpg',
//     status: 'Active',
//     views: 342,
//     scans: 28,
//   ),
//   Property(
//     title: 'Modern 3-Bed Appartment',
//     price: '£850,000',
//     address: '123 Main Street, Los Angeles',
//     beds: 2,
//     baths: 2,
//     area: '950 sqft',
//     imageUrl:
//         'https://cf.bstatic.com/xdata/images/hotel/max1024x768/542608327.jpg?k=281c15e9f915014269a9f2bfc531bb2e5e847de13edb47731bce3e10f0675c3a&o=',
//     status: 'Sold',
//     views: 342,
//     scans: 28,
//   ),
//   Property(
//     title: 'Modern 3-Bed Appartment',
//     price: '£850,000',
//     address: '123 Main Street, Los Angeles',
//     beds: 2,
//     baths: 2,
//     area: '950 sqft',
//     imageUrl:
//         'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8YXBhcnRtZW50fGVufDB8fDB8fHww',
//     status: 'Pending',
//     views: 342,
//     scans: 28,
//   ),
// ];



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
                      property.image == "" ?
                      "https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=800" : property.image,
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
                      color: _statusColor(  property.isNew!
                                ? "New"
                                : property!
                                      .isFeature!
                                ? "Feature"
                                : "N/A",),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      property.isNew!
                                ? "New"
                                : property!
                                      .isFeature!
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
                      icon: const Icon(Icons.more_vert, size: 20),
                      onPressed: () {},
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
