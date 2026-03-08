import 'package:dips/components/custom_button.dart';
import 'package:dips/components/custom_snackbar.dart';
import 'package:dips/components/property_card.dart';
import 'package:dips/core/routing/route_path.dart';
import 'package:dips/presentation/user/home/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  RangeValues _priceRange = const RangeValues(100000, 500000);
  String _selectedPropertyType = 'Any Type';
  String _selectedAmenities = 'Any Type';
  int _selectedBedrooms = -1;

  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeProvider>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Search Filter",
          style: TextStyle(color: Color(0xFF041E41)),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSearchBar(),
                    const SizedBox(height: 24),
                    _buildPriceRange(),
                    const SizedBox(height: 24),
                    _buildPropertyType(),
                    const SizedBox(height: 24),
                    _buildAmenities(),
                    const SizedBox(height: 24),
                    _buildBedrooms(),
                    const SizedBox(height: 24),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomButton(
                    onPressed: () async {
                      await provider.searchFilter(
                        searchController.text,
                        _selectedPropertyType == "Any Type"
                            ? ""
                            : _selectedPropertyType,
                        _priceRange.start.toInt().toString(),
                        _priceRange.end.toInt().toString(),
                        _selectedBedrooms == -1
                            ? ""
                            : _selectedBedrooms.toString(),
                        _selectedAmenities == "Any Type"
                            ? ""
                            : _selectedAmenities,
                      );
                    },
                    title:
                        "Apply Filters (${provider.searchFilterList.length} properties)",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Showing ${provider.searchFilterList.length} properties',
                    style: TextStyle(
                      color: const Color(0xFF0A0A0A),
                      fontSize: 16,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),

                provider.isLoading
                    ? Center(child: CircularProgressIndicator())
                    : Column(
                        children: List.generate(provider.searchFilterList.length, (
                          index,
                        ) {
                          return PropertyCard(
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
                                  message: "Added Favourite Not Successfully",
                                  type: SnackType.error,
                                );
                              }
                            },
                            onTap: () async {
                              final data = await provider.getPropertyDetails(
                                context,
                                provider.propertyList[index].id,
                              );
                              await provider.getSimilerProperty(
                                provider.propertyList[index].id,
                              );
                              if (data) {
                                context.push(RoutePath.myPropertiesDetails);
                              }
                            },
                            imageUrl:
                                provider.searchFilterList[index].image.isEmpty
                                ? 'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=800'
                                : provider.searchFilterList[index].image,
                            title: provider.searchFilterList[index].name,
                            rating: provider.searchFilterList[index].rating,
                            location: provider.searchFilterList[index].location,
                            beds: provider.searchFilterList[index].bed,
                            baths: provider.searchFilterList[index].baths,
                            sqft: provider.searchFilterList[index].size
                                .toString(),
                            price:
                                "£ ${provider.searchFilterList[index].price.toString()}",
                            distance: provider.searchFilterList[index].rating,
                            badge: provider.searchFilterList[index].isNew
                                ? "New"
                                : provider.searchFilterList[index].isFeature
                                ? "Feature"
                                : "N/A",
                          );
                        }),
                      ),
              ],
            ),
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

  Widget _buildSearchBar() {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF8F9FA),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search by location, postcode...',
                hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1F2937),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                setState(() {
                  _priceRange = const RangeValues(200, 1000);
                  _selectedPropertyType = 'Any Type';
                  _selectedAmenities = 'Any Type';
                  _selectedBedrooms = -1;
                });
              },
              borderRadius: BorderRadius.circular(8),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Text(
                  'Reset Filters',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPriceRange() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Price range',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 20),
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: const Color(0xFF1F2937),
              inactiveTrackColor: const Color(0xFFE5E7EB),
              thumbColor: Colors.white,
              overlayColor: const Color(0xFF1F2937).withOpacity(0.2),
              thumbShape: const RoundSliderThumbShape(
                enabledThumbRadius: 12,
                elevation: 3,
              ),
              trackHeight: 4,
            ),
            child: RangeSlider(
              values: _priceRange,
              min: 0,
              max: 2000000,
              divisions: 40,
              onChanged: (RangeValues values) {
                setState(() {
                  _priceRange = values;
                });
              },
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildPriceBox(
                  'Min Price',
                  '£${_priceRange.start.toInt()}',
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildPriceBox(
                  'Max Price',
                  '£${_priceRange.end.toInt()}',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPriceBox(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFFDC2626),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPropertyType() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Property type',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 16),
          _buildDropdown(
            value: _selectedPropertyType,
            items: ['Any Type', 'House', 'Apartment', 'Villa', 'Condo'],
            onChanged: (value) {
              setState(() {
                _selectedPropertyType = value!;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAmenities() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Amenities',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 16),
          _buildDropdown(
            value: _selectedAmenities,
            items: [
              'Any Type',
              'Parking',
              'Swimming Pool',
              'Gym',
              'Garden',
              'Balcony',
            ],
            onChanged: (value) {
              setState(() {
                _selectedAmenities = value!;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown({
    required String value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: DropdownButton<String>(
        value: value,
        isExpanded: true,
        underline: const SizedBox(),
        icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
        style: const TextStyle(fontSize: 14, color: Color(0xFF1F2937)),
        items: items.map((String item) {
          return DropdownMenuItem<String>(value: item, child: Text(item));
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildBedrooms() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Bedrooms',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildBedroomButton('Any', -1),
              const SizedBox(width: 12),
              _buildBedroomButton('1', 1),
              const SizedBox(width: 12),
              _buildBedroomButton('2', 2),
              const SizedBox(width: 12),
              _buildBedroomButton('3', 3),
              const SizedBox(width: 12),
              _buildBedroomButton('4', 4),
              const SizedBox(width: 12),
              _buildBedroomButton('5+', 5),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBedroomButton(String label, int value) {
    final isSelected = _selectedBedrooms == value;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedBedrooms = value;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFF1F2937)
                : const Color(0xFFF8F9FA),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected
                  ? const Color(0xFF1F2937)
                  : const Color(0xFFE5E7EB),
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.white : const Color(0xFF6B7280),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
