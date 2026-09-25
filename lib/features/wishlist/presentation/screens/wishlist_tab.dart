import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ecommerce_c19/core/routes/app_routes.dart';
import 'package:ecommerce_c19/core/theme/app_colors.dart';
import 'package:ecommerce_c19/core/widgets/app_header.dart';
import 'package:ecommerce_c19/core/widgets/error_view.dart';
import 'package:ecommerce_c19/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:ecommerce_c19/features/cart/presentation/bloc/cart_events.dart';
import 'package:ecommerce_c19/features/cart/presentation/bloc/cart_states.dart';
import 'package:ecommerce_c19/features/wishlist/presentation/bloc/wishlist_bloc.dart';
import 'package:ecommerce_c19/features/wishlist/presentation/bloc/wishlist_events.dart';
import 'package:ecommerce_c19/features/wishlist/presentation/bloc/wishlist_states.dart';
import 'package:ecommerce_c19/features/wishlist/presentation/widgets/wishlist_item_card.dart';

class WishlistTab extends StatelessWidget {
  const WishlistTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartBloc, CartStates>(
      listenWhen: (previous, current) =>
          previous.requestStatus != current.requestStatus &&
          current.requestStatus != RequestStatus.loading,
      listener: (context, state) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            state.requestStatus == RequestStatus.success
                ? 'Added to cart'
                : state.errorMessage ?? 'Could not add to cart',
          ),
        ),
      ),
      child: Column(
        children: [
          const AppHeader(),
          const SizedBox(height: 24),
          Expanded(
            child: BlocBuilder<WishlistBloc, WishlistState>(
              builder: (context, state) {
                final items = state.products;
                if (items.isEmpty) {
                  return switch (state.getWishlistRequestStatus) {
                    RequestStatus.error => ErrorView(
                      message: state.errorMessage ?? 'Could not load wishlist',
                      onRetry: () =>
                          context.read<WishlistBloc>().add(GetWishlistEvent()),
                    ),
                    RequestStatus.loading || RequestStatus.init => const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    ),
                    RequestStatus.success => const Center(
                      child: Text(
                        'Your wishlist is empty',
                        style: TextStyle(
                          fontSize: 18,
                          color: AppColors.greyText,
                        ),
                      ),
                    ),
                  };
                }
                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  itemCount: items.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 24),
                  itemBuilder: (context, index) => WishlistItemCard(
                    product: items[index],
                    onTap: () => Navigator.pushNamed(
                      context,
                      AppRoutes.productDetails,
                      arguments: items[index].id,
                    ),
                    onAddToCart: () => context.read<CartBloc>().add(
                      AddToCartEvent(items[index].id),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
