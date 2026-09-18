import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ecommerce_c19/core/theme/app_colors.dart';
import 'package:ecommerce_c19/core/utils/price_formatter.dart';
import 'package:ecommerce_c19/core/widgets/error_view.dart';
import 'package:ecommerce_c19/core/widgets/inner_app_bar.dart';
import 'package:ecommerce_c19/core/widgets/quantity_stepper.dart';
import 'package:ecommerce_c19/core/widgets/total_price_bar.dart';
import 'package:ecommerce_c19/di.dart';
import 'package:ecommerce_c19/features/products/domain/entities/product_entity.dart';
import 'package:ecommerce_c19/features/products/presentation/bloc/products_bloc.dart';
import 'package:ecommerce_c19/features/products/presentation/bloc/products_events.dart';
import 'package:ecommerce_c19/features/products/presentation/bloc/products_states.dart';
import 'package:ecommerce_c19/features/products/presentation/widgets/color_selector.dart';
import 'package:ecommerce_c19/features/products/presentation/widgets/product_description.dart';
import 'package:ecommerce_c19/features/products/presentation/widgets/product_image_slider.dart';
import 'package:ecommerce_c19/features/products/presentation/widgets/size_selector.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  static const _sizes = [38, 39, 40, 41, 42];
  static const _colors = [
    Color(0xFF2B2B2B),
    Color(0xFFB8321F),
    Color(0xFF0F74E0),
    Color(0xFF16B53B),
    Color(0xFFFF6B5E),
  ];
  static const _titleStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );

  int _quantity = 1;
  int _size = 40;
  int _colorIndex = 1;

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;

    return BlocProvider(
      create: (_) =>
          getIt<ProductsBloc>()..add(GetProductDetailsEvent(productId)),
      child: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          final product = state.productDetails;
          return Scaffold(
            appBar: const InnerAppBar(title: 'Product Details'),
            body: product != null
                ? _buildDetails(product)
                : switch (state.productDetailsRequestStatus) {
                    RequestStatus.error => ErrorView(
                      message: state.errorMessage ?? 'Could not load product',
                      onRetry: () => context.read<ProductsBloc>().add(
                        GetProductDetailsEvent(productId),
                      ),
                    ),
                    _ => const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    ),
                  },
            bottomNavigationBar: product == null
                ? null
                : TotalPriceBar(
                    total: product.finalPrice * _quantity,
                    buttonText: 'Add to cart',
                    leadingIcon: Icons.add_shopping_cart,
                    onPressed: () {},
                  ),
          );
        },
      ),
    );
  }

  Widget _buildDetails(ProductEntity product) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      children: [
        ProductImageSlider(
          images: product.images.isEmpty
              ? [product.imageCover]
              : product.images,
        ),
        const SizedBox(height: 24),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: Text(product.title, style: _titleStyle)),
            const SizedBox(width: 16),
            Text(formatPrice(product.finalPrice), style: _titleStyle),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.border),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '${formatNumber(product.sold)} Sold',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(width: 12),
            const Icon(Icons.star, color: AppColors.star, size: 20),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                '${product.ratingsAverage} '
                '(${formatNumber(product.ratingsQuantity)})',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            QuantityStepper(
              quantity: _quantity,
              onIncrement: () => setState(() => _quantity++),
              onDecrement: () {
                if (_quantity > 1) setState(() => _quantity--);
              },
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text('Description', style: _titleStyle),
        const SizedBox(height: 8),
        ProductDescription(text: product.description),
        const SizedBox(height: 16),
        const Text('Size', style: _titleStyle),
        const SizedBox(height: 8),
        SizeSelector(
          sizes: _sizes,
          selected: _size,
          onSelected: (size) => setState(() => _size = size),
        ),
        const SizedBox(height: 16),
        const Text('Color', style: _titleStyle),
        const SizedBox(height: 8),
        ColorSelector(
          colors: _colors,
          selectedIndex: _colorIndex,
          onSelected: (index) => setState(() => _colorIndex = index),
        ),
      ],
    );
  }
}
