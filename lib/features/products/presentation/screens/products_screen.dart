import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ecommerce_c19/core/routes/app_routes.dart';
import 'package:ecommerce_c19/core/theme/app_colors.dart';
import 'package:ecommerce_c19/core/widgets/app_bottom_nav.dart';
import 'package:ecommerce_c19/core/widgets/app_header.dart';
import 'package:ecommerce_c19/core/widgets/error_view.dart';
import 'package:ecommerce_c19/di.dart';
import 'package:ecommerce_c19/features/products/domain/entities/products_query.dart';
import 'package:ecommerce_c19/features/products/presentation/bloc/products_bloc.dart';
import 'package:ecommerce_c19/features/products/presentation/bloc/products_events.dart';
import 'package:ecommerce_c19/features/products/presentation/bloc/products_states.dart';
import 'package:ecommerce_c19/features/products/presentation/widgets/product_card.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final query =
        ModalRoute.of(context)?.settings.arguments as ProductsQuery? ??
        const ProductsQuery();

    return BlocProvider(
      create: (_) => getIt<ProductsBloc>()..add(GetProductsEvent(query)),
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              const AppHeader(),
              const SizedBox(height: 24),
              Expanded(
                child: BlocBuilder<ProductsBloc, ProductsState>(
                  builder: (context, state) {
                    final products = state.products;
                    if (products.isEmpty) {
                      return switch (state.productsRequestStatus) {
                        RequestStatus.error => ErrorView(
                          message:
                              state.errorMessage ?? 'Could not load products',
                          onRetry: () => context.read<ProductsBloc>().add(
                            GetProductsEvent(query),
                          ),
                        ),
                        RequestStatus.success => const Center(
                          child: Text('No products yet'),
                        ),
                        _ => const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                        ),
                      };
                    }
                    return GridView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      itemCount: products.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                            childAspectRatio: 191 / 237,
                          ),
                      itemBuilder: (context, index) => ProductCard(
                        product: products[index],
                        onTap: () => Navigator.pushNamed(
                          context,
                          AppRoutes.productDetails,
                          arguments: products[index].id,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        // Opened from the Categories tab, so that tab stays highlighted.
        bottomNavigationBar: AppBottomNav(
          currentIndex: 1,
          onTap: (index) => Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.main,
            (_) => false,
            arguments: index,
          ),
        ),
      ),
    );
  }
}
