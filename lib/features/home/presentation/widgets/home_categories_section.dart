import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ecommerce_c19/core/routes/app_routes.dart';
import 'package:ecommerce_c19/core/theme/app_colors.dart';
import 'package:ecommerce_c19/core/widgets/error_view.dart';
import 'package:ecommerce_c19/features/categories/presentation/bloc/categories_bloc.dart';
import 'package:ecommerce_c19/features/categories/presentation/bloc/categories_events.dart';
import 'package:ecommerce_c19/features/categories/presentation/bloc/categories_states.dart';
import 'package:ecommerce_c19/features/home/presentation/widgets/home_category_item.dart';
import 'package:ecommerce_c19/features/products/domain/entities/products_query.dart';

/// "Categories" title and a two-row horizontal grid, fed by [CategoriesBloc].
class HomeCategoriesSection extends StatelessWidget {
  const HomeCategoriesSection({super.key, required this.onViewAll});

  final VoidCallback onViewAll;

  static const _itemWidth = 100.0;
  static const _itemHeight = 150.0;
  static const _spacing = 16.0;
  static const _gridHeight = _itemHeight * 2 + _spacing;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              const Expanded(
                child: Text(
                  'Categories',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              TextButton(
                onPressed: onViewAll,
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.darkText,
                ),
                child: const Text('view all', style: TextStyle(fontSize: 12)),
              ),
            ],
          ),
        ),
        SizedBox(
          height: _gridHeight,
          child: BlocBuilder<CategoriesBloc, CategoriesState>(
            builder: (context, state) {
              final categories = state.categories;
              if (categories.isEmpty) {
                return switch (state.categoriesRequestStatus) {
                  RequestStatus.error => ErrorView(
                    message: state.errorMessage ?? 'Could not load categories',
                    onRetry: () => context.read<CategoriesBloc>().add(
                      GetCategoriesEvent(),
                    ),
                  ),
                  RequestStatus.success => const Center(
                    child: Text('No categories yet'),
                  ),
                  _ => const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  ),
                };
              }
              return GridView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: _spacing,
                  crossAxisSpacing: _spacing,
                  // Cross axis (height) / main axis (width) for a horizontal grid.
                  childAspectRatio: _itemHeight / _itemWidth,
                ),
                itemBuilder: (context, index) => HomeCategoryItem(
                  name: categories[index].name,
                  image: categories[index].image,
                  onTap: () => Navigator.pushNamed(
                    context,
                    AppRoutes.products,
                    arguments: ProductsQuery(
                      categoryIds: [categories[index].id],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
