import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ecommerce_c19/core/routes/app_routes.dart';
import 'package:ecommerce_c19/core/theme/app_colors.dart';
import 'package:ecommerce_c19/core/widgets/app_header.dart';
import 'package:ecommerce_c19/core/widgets/error_view.dart';
import 'package:ecommerce_c19/features/categories/domain/entities/category_entity.dart';
import 'package:ecommerce_c19/features/categories/presentation/bloc/categories_bloc.dart';
import 'package:ecommerce_c19/features/categories/presentation/bloc/categories_events.dart';
import 'package:ecommerce_c19/features/categories/presentation/bloc/categories_states.dart';
import 'package:ecommerce_c19/features/categories/presentation/widgets/category_banner.dart';
import 'package:ecommerce_c19/features/categories/presentation/widgets/category_side_menu.dart';
import 'package:ecommerce_c19/features/categories/presentation/widgets/sub_category_item.dart';
import 'package:ecommerce_c19/features/products/domain/entities/products_query.dart';

class CategoriesTab extends StatefulWidget {
  const CategoriesTab({super.key});

  @override
  State<CategoriesTab> createState() => _CategoriesTabState();
}

class _CategoriesTabState extends State<CategoriesTab> {
  int _selectedIndex = 0;

  void _select(List<CategoryEntity> categories, int index) {
    setState(() => _selectedIndex = index);
    context.read<CategoriesBloc>().add(
      GetSubCategoriesEvent(categories[index].id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AppHeader(),
        const SizedBox(height: 16),
        Expanded(
          child: BlocConsumer<CategoriesBloc, CategoriesState>(
            listenWhen: (previous, current) =>
                previous.categoriesRequestStatus !=
                    current.categoriesRequestStatus &&
                current.categoriesRequestStatus == RequestStatus.success &&
                current.categories.isNotEmpty,
            listener: (context, state) {
              final index = _selectedIndex < state.categories.length
                  ? _selectedIndex
                  : 0;
              _select(state.categories, index);
            },
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
              final selected = _selectedIndex < categories.length
                  ? _selectedIndex
                  : 0;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      width: 137,
                      child: CategorySideMenu(
                        names: [for (final c in categories) c.name],
                        selectedIndex: selected,
                        onSelected: (index) => _select(categories, index),
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: _CategoryContent(
                        category: categories[selected],
                        state: state,
                        onRetry: () => _select(categories, selected),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _CategoryContent extends StatelessWidget {
  const _CategoryContent({
    required this.category,
    required this.state,
    required this.onRetry,
  });

  final CategoryEntity category;
  final CategoriesState state;
  final VoidCallback onRetry;

  void _openProducts(BuildContext context, ProductsQuery query) =>
      Navigator.pushNamed(context, AppRoutes.products, arguments: query);

  @override
  Widget build(BuildContext context) {
    final subCategories = state.subCategories;

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
          onShopNow: () =>
              _openProducts(context, ProductsQuery(categoryIds: [category.id])),
        ),
        const SizedBox(height: 16),
        if (subCategories.isNotEmpty)
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: subCategories.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.75,
            ),
            itemBuilder: (context, index) => SubCategoryItem(
              name: subCategories[index].name,
              onTap: () => _openProducts(
                context,
                ProductsQuery(subCategoryIds: [subCategories[index].id]),
              ),
            ),
          )
        else
          switch (state.subCategoriesRequestStatus) {
            RequestStatus.error => ErrorView(
              message: state.errorMessage ?? 'Could not load subcategories',
              onRetry: onRetry,
            ),
            RequestStatus.success => const Text(
              'No subcategories yet',
              style: TextStyle(fontSize: 14, color: AppColors.greyText),
            ),
            _ => const Padding(
              padding: EdgeInsets.only(top: 24),
              child: Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              ),
            ),
          },
      ],
    );
  }
}
