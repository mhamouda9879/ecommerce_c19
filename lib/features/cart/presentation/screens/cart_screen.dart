import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ecommerce_c19/core/theme/app_colors.dart';
import 'package:ecommerce_c19/core/widgets/error_view.dart';
import 'package:ecommerce_c19/core/widgets/inner_app_bar.dart';
import 'package:ecommerce_c19/core/widgets/total_price_bar.dart';
import 'package:ecommerce_c19/di.dart';
import 'package:ecommerce_c19/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:ecommerce_c19/features/cart/presentation/bloc/cart_events.dart';
import 'package:ecommerce_c19/features/cart/presentation/bloc/cart_states.dart';
import 'package:ecommerce_c19/features/cart/presentation/widgets/cart_item_card.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CartBloc>()..add(GetCartEvent()),
      child: BlocConsumer<CartBloc, CartStates>(
        listenWhen: (previous, current) =>
            previous.updateCartRequestStatus !=
                current.updateCartRequestStatus &&
            current.updateCartRequestStatus == RequestStatus.error,
        listener: (context, state) =>
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Could not update cart'),
              ),
            ),
        builder: (context, state) {
          final cart = state.cart;
          final items = cart?.items ?? [];
          final isUpdating =
              state.updateCartRequestStatus == RequestStatus.loading;

          return Scaffold(
            appBar: const InnerAppBar(title: 'Cart'),
            body: cart == null
                ? switch (state.getCartRequestStatus) {
                    RequestStatus.error => ErrorView(
                      message: state.errorMessage ?? 'Could not load cart',
                      onRetry: () =>
                          context.read<CartBloc>().add(GetCartEvent()),
                    ),
                    _ => const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    ),
                  }
                : items.isEmpty
                ? const Center(
                    child: Text(
                      'Your cart is empty',
                      style: TextStyle(fontSize: 18, color: AppColors.greyText),
                    ),
                  )
                : Column(
                    children: [
                      if (isUpdating)
                        const LinearProgressIndicator(color: AppColors.primary),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: isUpdating
                              ? null
                              : () => context.read<CartBloc>().add(
                                  ClearCartEvent(),
                                ),
                          style: TextButton.styleFrom(
                            foregroundColor: AppColors.primary,
                          ),
                          child: const Text('Clear cart'),
                        ),
                      ),
                      Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          itemCount: items.length,
                          separatorBuilder: (_, _) =>
                              const SizedBox(height: 16),
                          itemBuilder: (context, index) {
                            final item = items[index];
                            void send(CartEvents event) {
                              if (!isUpdating) {
                                context.read<CartBloc>().add(event);
                              }
                            }

                            return CartItemCard(
                              item: item,
                              onIncrement: () => send(
                                UpdateCartItemCountEvent(
                                  item.productId,
                                  item.count + 1,
                                ),
                              ),
                              onDecrement: () {
                                if (item.count > 1) {
                                  send(
                                    UpdateCartItemCountEvent(
                                      item.productId,
                                      item.count - 1,
                                    ),
                                  );
                                }
                              },
                              onDelete: () =>
                                  send(RemoveCartItemEvent(item.productId)),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
            bottomNavigationBar: items.isEmpty
                ? null
                : TotalPriceBar(
                    total: cart!.totalPrice,
                    buttonText: 'Check Out',
                    trailingIcon: Icons.arrow_forward,
                    onPressed: () {},
                  ),
          );
        },
      ),
    );
  }
}
