import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joy_bor/core/constants/app_images.dart';
import 'package:joy_bor/core/widgets/place_card_large.dart';
import 'package:joy_bor/core/widgets/search_widget.dart';
import 'package:joy_bor/core/widgets/sort_toggle.dart';
import 'package:joy_bor/features/home/presentation/bloc/product_bloc.dart';
import 'package:joy_bor/features/home/presentation/bloc/product_state.dart';

import 'package:joy_bor/features/place/presentation/pages/search_page.dart';
import 'package:joy_bor/features/place/presentation/pages/sort_cubit.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<SortItem> sortItems = [
    SortItem(imagePath: AppImages.filter, label: 'All'),
    SortItem(imagePath: AppImages.homeIcon, label: 'Home'),
    SortItem(imagePath: AppImages.locationIcon, label: 'Place'),
    SortItem(imagePath: AppImages.divanIcon, label: 'Hotels'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(AppImages.splash3, fit: BoxFit.cover),
          BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state.isLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.grey.withAlpha(40),
                  ),
                );
              }
              return BlocBuilder<SortCubit, int>(
                builder: (context, selectedSortIndex) {
                  final selectedCategory = sortItems[selectedSortIndex].label;
                  final filteredProducts = selectedCategory == 'All'
                      ? state.filteredProducts
                      : state.filteredProducts
                            .where((p) => p.category == selectedCategory)
                            .toList();
                  return ListView(
                    padding: EdgeInsets.symmetric(vertical: 30),
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Plan Your",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 28,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "Perfect Trip",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 28,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 55,
                              width: 55,
                              decoration: BoxDecoration(
                                color: Colors.grey.withAlpha(50),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(14),
                                child: Image.asset(AppImages.notificationIcon),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 25),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => SearchPage()),
                            );
                          },
                          child: Hero(
                            tag: "Search_Widget",
                            child: SearchTextField(),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SortToggleButtons(
                            items: sortItems,
                            selectedIndex: selectedSortIndex,
                            onChanged: (index) {
                              context.read<SortCubit>().changeSort(index);
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: filteredProducts
                              .map(
                                (product) => Padding(
                                  padding: EdgeInsets.only(bottom: 25),
                                  child: PlaceCardLarge(product: product),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
