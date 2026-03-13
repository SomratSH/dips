import 'package:dips/components/custom_padding.dart';
import 'package:dips/components/custom_share.dart';
import 'package:dips/components/custom_snackbar.dart';
import 'package:dips/components/property_card.dart';
import 'package:dips/core/routing/route_path.dart';
import 'package:dips/presentation/user/home/home_provider.dart';
import 'package:dips/presentation/user/home/widget/agent_details.dart';
import 'package:dips/presentation/user/home/widget/booking_view_dialog.dart';
import 'package:dips/presentation/user/home/widget/make_offer_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class PropertyDetailScreen extends StatelessWidget {
  const PropertyDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeProvider>();
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text("Property Details"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: InkWell(
              onTap: () {
                onShare(context);
              },
              child: Icon(Icons.share, color: Theme.of(context).primaryColor),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Property Image with back and favorite buttons
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DecoratedBox(
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        shadows: [
                          BoxShadow(
                            color: Color(0x14000000),
                            blurRadius: 24.36,
                            offset: Offset(0, 4.87),
                            spreadRadius: 0,
                          ),
                        ],
                      ),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 300,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                              image: DecorationImage(
                                image: NetworkImage(
                                  provider.propertyDetailsJson.images!.isEmpty
                                      ? 'https://media.istockphoto.com/id/1398814566/photo/interior-of-small-apartment-living-room-for-home-office.jpg?s=612x612&w=0&k=20&c=8clwg8hTpvoEwL7253aKdYAUuAp1-usFOacNR5qX-Rg='
                                      : provider.propertyDetailsJson.images![0],
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 20.0,
                              top: 20,
                              bottom: 20,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        provider.propertyDetailsJson.title!,
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 4),
                                    const Text(
                                      '4.8',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Text(
                                      provider
                                          .propertyDetailsJson
                                          .propertyType!,
                                      style: TextStyle(color: Colors.grey[600]),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '£${provider.propertyDetailsJson.price!}',
                                  style: TextStyle(
                                    color: const Color(0xFFE63946),
                                    fontSize: 16,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Icon(Icons.near_me, color: Colors.grey),
                                    Text(
                                      provider.propertyDetailsJson.address!,
                                      style: TextStyle(
                                        color: const Color(0xFF666666),
                                        fontSize: 16,
                                        fontFamily: 'Lato',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Property Features
                    DecoratedBox(
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        shadows: [
                          BoxShadow(
                            color: Color(0x14000000),
                            blurRadius: 24.36,
                            offset: Offset(0, 4.87),
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                _buildFeature(
                                  "assets/icons/bedrooms.svg",
                                  provider.propertyDetailsJson.beds!.toString(),
                                  'Bedrooms',
                                ),
                                CustomPadding().vPad30,
                                _buildFeature(
                                  "assets/icons/bathroom.svg",
                                  provider.propertyDetailsJson.baths!
                                      .toString(),
                                  'Bathrooms',
                                ),
                              ],
                            ),
                            CustomPadding().hPad15,
                            Column(
                              children: [
                                _buildFeature(
                                  "assets/icons/sqfit.svg",
                                  provider.propertyDetailsJson.sizeSqft!
                                      .toString(),
                                  'sqft',
                                ),
                                CustomPadding().vPad30,
                                _buildFeature(
                                  "assets/icons/car.svg",
                                  provider.propertyDetailsJson.parkingSlots!
                                      .toString(),
                                  'Parking',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              ContactActions.openWhatsApp(
                                provider.propertyDetailsJson.agent!.phone ??
                                    "911234567890",
                                "Hello! I am contacting you from Scan2Home app.",
                              );
                            },
                            icon: const Icon(Icons.message),
                            label: const Text('Whatsapp'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Theme.of(context).primaryColor,
                              side: BorderSide(
                                color: Theme.of(context).primaryColor,
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              ContactActions.openDialer(
                                provider.propertyDetailsJson.agent!.phone ??
                                    "1234567890",
                              );
                            },
                            icon: const Icon(Icons.call, color: Colors.black),
                            label: const Text(
                              'Call',
                              style: TextStyle(color: Colors.black),
                            ),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                color: Colors.black.withValues(alpha: 0.10),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    CustomPadding().vPad15,
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => const BookViewingDialog(),
                              );
                            },
                            icon: const Icon(
                              Icons.calendar_month,
                              color: Colors.black,
                            ),
                            label: const Text(
                              'Book Viewing',
                              style: TextStyle(color: Colors.black),
                            ),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                color: Colors.black.withValues(alpha: 0.10),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (context) =>
                                    const MakeOfferBottomSheet(),
                              );
                            },
                            icon: const Icon(Icons.euro, color: Colors.white),
                            label: const Text(
                              'Make Offer',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Color(0xFF041E41),
                              foregroundColor: const Color(0xFF041E41),

                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Agent Section
                    DecoratedBox(
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        shadows: [
                          BoxShadow(
                            color: Color(0x14000000),
                            blurRadius: 24.36,
                            offset: Offset(0, 4.87),
                            spreadRadius: 0,
                          ),
                        ],
                      ),

                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  foregroundImage: NetworkImage(
                                    provider
                                            .propertyDetailsJson
                                            .agent!
                                            .agentProfile!
                                            .agentPhoto ??
                                        "https://images.unsplash.com/photo-1560250097-0b93528c311a?w=400",
                                  ),
                                ),
                                CustomPadding().hPad10,
                                Text(
                                  'Meet Agent - ${provider.propertyDetailsJson.agent!.fullName}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // const SizedBox(height: 12),

                          // Padding(
                          //   padding: const EdgeInsets.all(12.0),
                          //   child: Stack(
                          //     alignment: Alignment.center,
                          //     children: [
                          //       Container(
                          //         height: 180,
                          //         decoration: BoxDecoration(
                          //           borderRadius: BorderRadius.circular(12),
                          //           image: const DecorationImage(
                          //             image: NetworkImage(
                          //               'https://images.unsplash.com/photo-1560250097-0b93528c311a?w=400',
                          //             ),
                          //             fit: BoxFit.fill,
                          //           ),
                          //         ),
                          //       ),
                          //       Container(
                          //         width: 60,
                          //         height: 60,
                          //         decoration: BoxDecoration(
                          //           color: Colors.white,
                          //           shape: BoxShape.circle,
                          //         ),
                          //         child: const Icon(
                          //           Icons.play_arrow,
                          //           size: 40,
                          //           color: Color(0xFF1A237E),
                          //         ),
                          //       ),
                          //       Positioned(
                          //         bottom: 12,
                          //         left: 12,
                          //         child: Column(
                          //           crossAxisAlignment:
                          //               CrossAxisAlignment.start,
                          //           children: const [
                          //             Text(
                          //               'Dan Williams',
                          //               style: TextStyle(
                          //                 color: Colors.white,
                          //                 fontWeight: FontWeight.bold,
                          //                 fontSize: 16,
                          //               ),
                          //             ),
                          //             Text(
                          //               'Senior Real Estate Agent',
                          //               style: TextStyle(
                          //                 color: Colors.white,
                          //                 fontSize: 12,
                          //               ),
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    SizedBox(
                      width: double.infinity,
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) => const AgentDetailsModal(),
                          );
                        },
                        child: DecoratedBox(
                          decoration: ShapeDecoration(
                            color: const Color(0xFF041E41),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),

                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.visibility, color: Colors.white),
                                CustomPadding().hPad5,
                                Text(
                                  'VIew Agent Details',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.25,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w400,
                                    height: 1.43,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Location Section
                    DecoratedBox(
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x14000000),
                            blurRadius: 24,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 🔹 Header
                            Row(
                              children: const [
                                Icon(
                                  Icons.location_pin,
                                  color: Color(0xFF041E41),
                                  size: 22,
                                ),
                                SizedBox(width: 6),
                                Text(
                                  'Location',
                                  style: TextStyle(
                                    color: Color(0xFF041E41),
                                    fontSize: 16,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 12),

                            // 🗺️ Map Image
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                "assets/image/map_page.png",
                                height: 180, // ✅ IMPORTANT
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            CustomPadding().vPad10,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Parker Rd.New Mexico',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: const Color(0xFF041E41),
                                    fontSize: 16,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),

                                Text(
                                  '2.3 km away',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: const Color(0xFF041E41),
                                    fontSize: 16,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // SizedBox(
                    //   width: double.infinity,
                    //   child: DecoratedBox(
                    //     decoration: ShapeDecoration(
                    //       color: const Color(0xFF041E41),
                    //       shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(12),
                    //       ),
                    //     ),

                    //     child: Padding(
                    //       padding: const EdgeInsets.all(12.0),
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         children: [
                    //           Icon(Icons.near_me, color: Colors.white),
                    //           Text(
                    //             'Get Direction ',
                    //             style: TextStyle(
                    //               color: Colors.white,
                    //               fontSize: 16.25,
                    //               fontFamily: 'Lato',
                    //               fontWeight: FontWeight.w400,
                    //               height: 1.43,
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),

                    const SizedBox(height: 24),

                    // Similar Properties
                    const Text(
                      'Similar Properties',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),

                    SizedBox(
                      height: 425,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        children: List.generate(
                          provider.similerPropertyList.length,
                          (index) {
                            final data = provider.similerPropertyList[index];
                            return Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: SizedBox(
                                width: 300,
                                child: PropertyCard(
                                  isFav: provider.propertyList[index].isFav,
                                  onFavoriteTap: () async {
                                    final response = await provider.addFav(
                                      provider.propertyList[index].id,
                                    );
                                    if (response) {
                                      AppSnackbar.show(
                                        context,
                                        title: "Add Favourite",
                                        message: "Added Favourite Successfully",
                                        type: SnackType.success,
                                      );
                                    } else {
                                      AppSnackbar.show(
                                        context,
                                        title: "Add Favourite",
                                        message:
                                            "Added Favourite Not Successfully",
                                        type: SnackType.error,
                                      );
                                    }
                                  },
                                  onTap: () => context.push(
                                    RoutePath.myPropertiesDetails,
                                  ),
                                  imageUrl:
                                      data.image == null ||
                                          data.image.isNotEmpty
                                      ? data.toString()
                                      : 'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=800',
                                  title: data.name,
                                  rating: '4.5',
                                  location: data.location,
                                  beds: data.bed,
                                  baths: data.baths,
                                  sqft: '${data.size} sqft',
                                  price: '£ ${data.price}',
                                  distance: '2.3 km',
                                  badge: data.isNew
                                      ? "New"
                                      : data.isFeature
                                      ? "Feature"
                                      : "N/A",
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    const SizedBox(width: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeature(String icon, String value, String label) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: ShapeDecoration(
            color: const Color(0xFFF8F9FA),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            shadows: [
              BoxShadow(
                color: Color(0x3F000000),
                blurRadius: 1,
                offset: Offset(0, 1),
                spreadRadius: 0,
              ),
            ],
          ),
          child: SvgPicture.asset(icon),
        ),
        CustomPadding().hPad10,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(
              label,
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPropertyCard(String title, String price, String imageUrl) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  price,
                  style: const TextStyle(
                    color: Color(0xFF1A237E),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Porter Michael House',
                  style: TextStyle(color: Colors.grey[600], fontSize: 11),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
