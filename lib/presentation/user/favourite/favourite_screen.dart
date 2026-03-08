import 'package:dips/components/custom_padding.dart';
import 'package:dips/components/custom_snackbar.dart';
import 'package:dips/components/property_card.dart';
import 'package:dips/core/routing/route_path.dart';
import 'package:dips/presentation/user/home/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeProvider>();
    List<String> list = ["Featured", "Under Offer", "Sold"];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("My Favourite", style: TextStyle(color: Color(0xFF041E41))),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: RefreshIndicator(
          onRefresh: () async {
            await provider.getFavourite();
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                // DecoratedBox(
                //   decoration: ShapeDecoration(
                //     color: Colors.white,
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(12),
                //     ),
                //     shadows: [
                //       BoxShadow(
                //         color: Color(0x14000000),
                //         blurRadius: 28.24,
                //         offset: Offset(0, 5.65),
                //         spreadRadius: 0,
                //       ),
                //     ],
                //   ),
                //   child: Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: Row(
                //       children: [
                //         Text(
                //           'Short by:',
                //           style: TextStyle(
                //             color: const Color(0xFF041E41),
                //             fontSize: 16,
                //             fontFamily: 'Lato',
                //             fontWeight: FontWeight.w700,
                //           ),
                //         ),
                //         Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,

                //           children: List.generate(
                //             list.length,
                //             (index) => Padding(
                //               padding: const EdgeInsets.only(left: 5, right: 5),
                //               child: DecoratedBox(
                //                 decoration: ShapeDecoration(
                //                   color: list[index] == "Featured"
                //                       ? const Color(0xFFFB1C1F)
                //                       : Colors.grey,
                //                   shape: RoundedRectangleBorder(
                //                     side: BorderSide(
                //                       width: 1.11,
                //                       color: Colors.black.withValues(alpha: 0),
                //                     ),
                //                     borderRadius: BorderRadius.circular(12),
                //                   ),
                //                 ),
                //                 child: Padding(
                //                   padding: const EdgeInsets.all(8.0),
                //                   child: Text(
                //                     'Featured',
                //                     style: TextStyle(
                //                       color: Colors.white,
                //                       fontSize: 14,
                //                       fontFamily: 'Inter',
                //                       fontWeight: FontWeight.w500,
                //                       height: 1.43,
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                CustomPadding().vPad15,
                provider.isLoading
                    ? Center(child: CircularProgressIndicator())
                    : Column(
                        children: List.generate(provider.favouriteList.length, (
                          index,
                        ) {
                          return PropertyCard(
                            isFav: provider
                                .favouriteList[index]
                                .property!
                                .isFavourited,
                            onFavoriteTap: () async {
                              final response = await provider.addFav(
                                provider.favouriteList[index].property!.id!,
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
                                provider.favouriteList[index].property!.id!,
                              );
                              await provider.getSimilerProperty(
                                provider.favouriteList[index].property!.id!,
                              );
                              if (data) {
                                context.push(RoutePath.myPropertiesDetails);
                              }
                            },
                            imageUrl:
                                'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=800',
                            title:
                                provider.favouriteList[index].property!.title!,
                            rating: "3.4",
                            location: provider
                                .favouriteList[index]
                                .property!
                                .address!,
                            beds: provider.favouriteList[index].property!.beds!,
                            baths:
                                provider.favouriteList[index].property!.baths!,
                            sqft: provider
                                .favouriteList[index]
                                .property!
                                .sizeSqft
                                .toString(),
                            price:
                                "£ ${provider.favouriteList[index].property!.price.toString()}",
                            distance: "1.2",
                            badge:
                                provider.favouriteList[index].property!.isNew!
                                ? "New"
                                : provider
                                      .favouriteList[index]
                                      .property!
                                      .isFeatured!
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
}
