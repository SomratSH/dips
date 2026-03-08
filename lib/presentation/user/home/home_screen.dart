import 'package:dips/components/custom_padding.dart';
import 'package:dips/components/custom_snackbar.dart';
import 'package:dips/components/property_card.dart';
import 'package:dips/core/routing/route_path.dart';
import 'package:dips/presentation/user/home/home_provider.dart';
import 'package:dips/presentation/user/profile/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeProvider>();
    final profileProvider = context.watch<ProfileProvider>();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            buildHeader(profileProvider.profileModel.name ?? "N/A"),
            _buildCategoryTabs(provider),
            provider.isLoading
                ? CircularProgressIndicator()
                : Expanded(child: _buildPropertyList(provider)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(RoutePath.scanner);
        },
        shape: CircleBorder(),
        backgroundColor: const Color(0xFFEF4444),
        child: SvgPicture.asset("assets/icons/scan.svg"),
      ),
    );
  }

  Widget buildHeader(String name) {
    return DecoratedBox(
      decoration: ShapeDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.00, 0.00),
          end: Alignment(1.00, 1.00),
          colors: [
            const Color(0xFFE63946),
            const Color(0xFF752B43),
            const Color(0xFF041E41),
          ],
        ),
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1.11, color: const Color(0xFFE8E8E8)),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome Back",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    Text(
                      name,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),

                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.location_on, size: 16, color: Colors.white),
                        SizedBox(width: 4),
                        Text(
                          name,
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ],
                    ),

                    CustomPadding().vPad25,
                  ],
                ),
                DecoratedBox(
                  decoration: ShapeDecoration(
                    color: Colors.white.withValues(alpha: 0.20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset("assets/icons/notification.svg"),
                  ),
                ),
              ],
            ),

            // _buildSearchBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search by location, postcode...',
            hintStyle: TextStyle(color: Colors.grey[400]),
            prefixIcon: const Icon(Icons.search, color: Colors.grey),
            suffixIcon: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.tune, color: Colors.white, size: 20),
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryTabs(HomeProvider provider) {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: provider.propertyTypeModel.length,
        itemBuilder: (context, index) {
          final isSelected =
              _selectedCategory == provider.propertyTypeModel[index].name;
          return GestureDetector(
            onTap: () async {
              setState(() {
                _selectedCategory = provider.propertyTypeModel[index].name!;
              });
              await provider.getPropertyListByValue(_selectedCategory);
            },
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected
                    ? Theme.of(context).primaryColor
                    : Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  provider.propertyTypeModel[index].name!,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.grey[600],
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPropertyList(HomeProvider provider) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: List.generate(provider.propertyList.length, (index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: 
        
          PropertyCard(
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
                'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=800',
            title: provider.propertyList[index].name,
            rating: provider.propertyList[index].rating,
            location: provider.propertyList[index].location,
            beds: provider.propertyList[index].bed,
            baths: provider.propertyList[index].baths,
            sqft: provider.propertyList[index].size.toString(),
            price: "£ ${provider.propertyList[index].price.toString()}",
            distance: provider.propertyList[index].rating,
            badge: provider.propertyList[index].isNew ? " " : " ",
          ),
        
        );
      }),
    );
  }
}
