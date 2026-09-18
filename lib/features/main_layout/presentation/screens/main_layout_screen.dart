import 'package:flutter/material.dart';

import 'package:ecommerce_c19/core/widgets/app_bottom_nav.dart';
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
  late int _index = widget.initialIndex;

  static const _tabs = [
    HomeTab(),
    CategoriesTab(),
    WishlistTab(),
    ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: IndexedStack(index: _index, children: _tabs),
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: _index,
        onTap: (index) => setState(() => _index = index),
      ),
    );
  }
}
