import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ecommerce_c19/core/widgets/favorite_button.dart';
import 'package:ecommerce_c19/features/products/domain/entities/product_entity.dart';
import 'package:ecommerce_c19/features/wishlist/presentation/bloc/wishlist_bloc.dart';
import 'package:ecommerce_c19/features/wishlist/presentation/bloc/wishlist_events.dart';
import 'package:ecommerce_c19/features/wishlist/presentation/bloc/wishlist_states.dart';

class WishlistButton extends StatelessWidget {
  const WishlistButton({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<WishlistBloc, WishlistState, bool>(
      selector: (state) => state.isFavorite(product.id),
      builder: (context, isFavorite) => FavoriteButton(
        isFavorite: isFavorite,
        onTap: () =>
            context.read<WishlistBloc>().add(ToggleWishlistEvent(product)),
      ),
    );
  }
}
