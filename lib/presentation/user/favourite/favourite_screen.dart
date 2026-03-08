import 'package:dips/components/custom_padding.dart';
import 'package:dips/components/property_card.dart';
import 'package:dips/core/routing/route_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';


class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> list = ["Featured", "Under Offer", "Sold"];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("My Favourite", style: TextStyle(color: Color(0xFF041E41))),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
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
                      blurRadius: 28.24,
                      offset: Offset(0, 5.65),
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        'Short by:',
                        style: TextStyle(
                          color: const Color(0xFF041E41),
                          fontSize: 16,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: List.generate(
                          list.length,
                          (index) => Padding(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: DecoratedBox(
                              decoration: ShapeDecoration(
                                color: list[index] == "Featured"
                                    ? const Color(0xFFFB1C1F)
                                    : Colors.grey,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    width: 1.11,
                                    color: Colors.black.withValues(alpha: 0),
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Featured',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                    height: 1.43,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              CustomPadding().vPad15,
              PropertyCard(
                onTap: () {
                  context.push(RoutePath.myPropertiesDetails);
                },
                imageUrl:
                    'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=800',
                title: 'Modern 3-Bed Apartment',
                rating: '4.5',
                location: 'Parker Rd New Mexico',
                beds: 3,
                baths: 2,
                sqft: '1,200 sqft',
                price: '£250,000',
                distance: '2.3 km',
                badge: 'Best Offer',
              ),
              const SizedBox(height: 16),
              PropertyCard(
                onTap: () {
                  context.push(RoutePath.myPropertiesDetails);
                },
                imageUrl:
                    'https://images.unsplash.com/photo-1556912173-46c336c7fd55?w=800',
                title: 'Contemporary Apartment',
                rating: '4.3',
                location: 'Dhanmondi, Dhaka',
                beds: 2,
                baths: 2,
                sqft: '950 sqft',
                price: '£180,000',
                distance: '1.8 km',
                badge: null,
              ),
              const SizedBox(height: 16),
              PropertyCard(
                onTap: () {
                  context.push(RoutePath.myPropertiesDetails);
                },
                imageUrl:
                    'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=800',
                title: 'Luxury Living Space',
                rating: '4.7',
                location: 'Gulshan, Dhaka',
                beds: 3,
                baths: 3,
                sqft: '1,500 sqft',
                price: '£320,000',
                distance: '3.5 km',
                badge: 'New',
              ),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: CircleBorder(),
        backgroundColor: const Color(0xFFEF4444),
        child: SvgPicture.asset("assets/icons/scan.svg"),
      ),
    );
  }
}
