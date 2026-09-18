import 'package:flutter/material.dart';

import 'package:ecommerce_c19/core/theme/app_colors.dart';
import 'package:ecommerce_c19/core/utils/dummy_data.dart';
import 'package:ecommerce_c19/core/widgets/inner_app_bar.dart';
import 'package:ecommerce_c19/core/widgets/total_price_bar.dart';
import 'package:ecommerce_c19/features/cart/presentation/widgets/cart_item_card.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // Local UI state until the cart view model exists.
  final _items = [...DummyData.cart];
  late final _quantities = [for (final item in _items) item.quantity];

  num get _total => [
    for (var i = 0; i < _items.length; i++)
      _items[i].product.price * _quantities[i],
  ].fold<num>(0, (sum, price) => sum + price);

  void _remove(int index) => setState(() {
    _items.removeAt(index);
    _quantities.removeAt(index);
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const InnerAppBar(title: 'Cart'),
      body: _items.isEmpty
          ? const Center(
              child: Text(
                'Your cart is empty',
                style: TextStyle(fontSize: 18, color: AppColors.greyText),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              itemCount: _items.length,
              separatorBuilder: (_, _) => const SizedBox(height: 16),
              itemBuilder: (context, index) => CartItemCard(
                item: _items[index],
                quantity: _quantities[index],
                onIncrement: () => setState(() => _quantities[index]++),
                onDecrement: () {
                  if (_quantities[index] > 1) {
                    setState(() => _quantities[index]--);
                  }
                },
                onDelete: () => _remove(index),
              ),
            ),
      bottomNavigationBar: _items.isEmpty
          ? null
          : TotalPriceBar(
              total: _total,
              buttonText: 'Check Out',
              trailingIcon: Icons.arrow_forward,
              onPressed: () {},
            ),
    );
  }
}
