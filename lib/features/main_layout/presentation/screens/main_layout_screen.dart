import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ecommerce_c19/core/widgets/app_bottom_nav.dart';
import 'package:ecommerce_c19/di.dart';
import 'package:ecommerce_c19/features/categories/presentation/bloc/categories_bloc.dart';
import 'package:ecommerce_c19/features/categories/presentation/bloc/categories_events.dart';
import 'package:ecommerce_c19/features/categories/presentation/screens/categories_tab.dart';
import 'package:ecommerce_c19/features/home/presentation/screens/home_tab.dart';
import 'package:ecommerce_c19/features/profile/presentation/screens/profile_tab.dart';
import 'package:ecommerce_c19/features/wishlist/presentation/screens/wishlist_tab.dart';

class MainLayoutScreen extends StatefulWidget {
  const MainLayoutScreen({super.key, this.initialIndex = 0});

  final int initialIndex;

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
  static const _categoriesTabIndex = 1;

  late int _index = widget.initialIndex;

  @override
  Widget build(BuildContext context) {
    // One bloc for the Home and Categories tabs: categories load once.
    return BlocProvider(
      create: (_) => getIt<CategoriesBloc>()..add(GetCategoriesEvent()),
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          child: IndexedStack(
            index: _index,
            children: [
              HomeTab(
                onViewAllCategories: () =>
                    setState(() => _index = _categoriesTabIndex),
              ),
              const CategoriesTab(),
              const WishlistTab(),
              const ProfileTab(),
            ],
          ),
        ),
        bottomNavigationBar: AppBottomNav(
          currentIndex: _index,
          onTap: (index) => setState(() => _index = index),
        ),
      ),
    );
  }
}
