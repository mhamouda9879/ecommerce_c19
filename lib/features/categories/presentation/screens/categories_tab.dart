import 'package:flutter/material.dart';

import 'package:ecommerce_c19/core/routes/app_routes.dart';
import 'package:ecommerce_c19/core/theme/app_colors.dart';
import 'package:ecommerce_c19/core/utils/dummy_data.dart';
import 'package:ecommerce_c19/core/widgets/app_header.dart';
import 'package:ecommerce_c19/features/categories/presentation/widgets/category_banner.dart';
import 'package:ecommerce_c19/features/categories/presentation/widgets/category_side_menu.dart';
import 'package:ecommerce_c19/features/categories/presentation/widgets/sub_category_item.dart';

class CategoriesTab extends StatefulWidget {
  const CategoriesTab({super.key});

  @override
  State<CategoriesTab> createState() => _CategoriesTabState();
}

class _CategoriesTabState extends State<CategoriesTab> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    const categories = DummyData.categories;
    final category = categories[_selectedIndex];

    return Column(
      children: [
        const AppHeader(),
        const SizedBox(height: 16),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  width: 137,
                  child: CategorySideMenu(
                    names: [for (final c in categories) c.name],
                    selectedIndex: _selectedIndex,
                    onSelected: (index) =>
                        setState(() => _selectedIndex = index),
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(child: _CategoryContent(category: category)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _CategoryContent extends StatelessWidget {
  const _CategoryContent({required this.category});

  final DummyCategory category;

  void _openProducts(BuildContext context) =>
      Navigator.pushNamed(context, AppRoutes.products);

  @override
  Widget build(BuildContext context) {
    final subCategories = category.subCategories;

    return ListView(
      padding: const EdgeInsets.only(bottom: 16),
      children: [
        Text(
          category.name,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 16),
        CategoryBanner(
          name: category.name,
          image: category.image,
          onShopNow: () => _openProducts(context),
        ),
        const SizedBox(height: 16),
        if (subCategories.isEmpty)
          const Text(
            'No subcategories yet',
            style: TextStyle(fontSize: 14, color: AppColors.greyText),
          )
        else
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: subCategories.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 13,
              mainAxisSpacing: 8,
              childAspectRatio: 70 / 110,
            ),
            itemBuilder: (context, index) => SubCategoryItem(
              name: subCategories[index].name,
              image: subCategories[index].image,
              onTap: () => _openProducts(context),
            ),
          ),
      ],
    );
  }
}
