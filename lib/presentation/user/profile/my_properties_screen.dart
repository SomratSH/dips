import 'package:dips/components/custom_padding.dart';
import 'package:dips/components/property_card.dart';
import 'package:flutter/material.dart';


class MyPropertiesScreen extends StatelessWidget {
  const MyPropertiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(
              'My Properties',
              style: TextStyle(
                color: const Color(0xFF041E41),
                fontSize: 16,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w700,
              ),
            ),
            CustomPadding().vPad20,
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      PropertyCard(
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
            ),
          ],
        ),
      ),
    );
  }
}
