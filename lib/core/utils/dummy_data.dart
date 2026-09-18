import 'package:flutter/material.dart';

// Temporary static data so the UI can be built before the data layer exists.
// Images and prices are real Route API data. Delete this file once the screens
// read from their view models.

typedef DummyProduct = ({
  String id,
  String title,
  String description,
  String imageCover,
  List<String> images,
  num price,
  num? oldPrice,
  double rating,
  int ratingsCount,
  int sold,
});

typedef DummyWishlistItem = ({
  DummyProduct product,
  String colorName,
  Color color,
});

typedef DummyCartItem = ({
  DummyProduct product,
  String colorName,
  Color color,
  int size,
  int quantity,
});

typedef DummyUser = ({
  String name,
  String email,
  String password,
  String phone,
  String address,
});

abstract class DummyData {
  static const _products =
      'https://ecommerce.routemisr.com/Route-Academy-products';

  static const DummyProduct _duramo = (
    id: '6428c962dc1175abc65ca025',
    title: 'Duramo 10 Running Shoes',
    description:
        'Clean, fresh, understated style that takes your breath away. '
        'That’s what you’ll see when you pull these adidas kicks out of '
        'their box. Tonal 3-Stripes on the upper keep the look sleek.',
    imageCover: '$_products/1680394593396-cover.jpeg',
    images: [
      '$_products/1680394593459-1.jpeg',
      '$_products/1680394593460-2.jpeg',
      '$_products/1680394593460-3.jpeg',
    ],
    price: 1314,
    oldPrice: 1999,
    rating: 3.5,
    ratingsCount: 6,
    sold: 229,
  );

  static const DummyProduct _hoops = (
    id: '6428c6a9dc1175abc65ca01f',
    title: 'Hoops 3.0 Low Classic Vintage Shoes',
    description:
        'Clean, fresh, understated style that takes your breath away. '
        'That’s what you’ll see when you pull these adidas kicks out of '
        'their box.',
    imageCover: '$_products/1680393896493-cover.jpeg',
    images: [
      '$_products/1680393896544-1.jpeg',
      '$_products/1680393896545-2.jpeg',
      '$_products/1680393896545-3.jpeg',
    ],
    price: 1629,
    oldPrice: null,
    rating: 4.0,
    ratingsCount: 1,
    sold: 167,
  );

  static const DummyProduct _reactLive = (
    id: '6428cd70dc1175abc65ca03d',
    title: 'React Live Sneakers Black/White',
    description:
        'Comfortable and soft cotton blend fabric. Ribbed crew neck and '
        'short sleeves. Signature branding print.',
    imageCover: '$_products/1680395631938-cover.jpeg',
    images: [
      '$_products/1680395632039-1.jpeg',
      '$_products/1680395632040-2.jpeg',
      '$_products/1680395632040-3.jpeg',
    ],
    price: 3759,
    oldPrice: 4639,
    rating: 4.1,
    ratingsCount: 9,
    sold: 233,
  );

  static const DummyProduct _logoTShirt = (
    id: '6428dfa0dc1175abc65ca067',
    title: 'Logo T-Shirt Green',
    description:
        'Soft and comfortable cotton fabric. Crew neck and short sleeves. '
        'Comfortable, regular fit.',
    imageCover: '$_products/1680400287654-cover.jpeg',
    images: [
      '$_products/1680400287765-1.jpeg',
      '$_products/1680400287765-2.jpeg',
      '$_products/1680400287767-3.jpeg',
    ],
    price: 379,
    oldPrice: 744,
    rating: 3.7,
    ratingsCount: 13,
    sold: 779,
  );

  static const DummyProduct _bordeauxBlouse = (
    id: '6428e7ecdc1175abc65ca090',
    title: 'Bordeaux Long Sleeve Blouse',
    description: 'Shell fabric: cotton 65%, polyester 35%.',
    imageCover: '$_products/1680402411833-cover.jpeg',
    images: [
      '$_products/1680402411883-1.jpeg',
      '$_products/1680402411883-2.jpeg',
      '$_products/1680402411883-3.jpeg',
    ],
    price: 349,
    oldPrice: 499,
    rating: 4.0,
    ratingsCount: 14,
    sold: 897,
  );

  static const wishlist = <DummyWishlistItem>[
    (product: _reactLive, colorName: 'Black', color: Color(0xFF3D3D3D)),
    (product: _bordeauxBlouse, colorName: 'Bordeaux', color: Color(0xFF7B1E2B)),
    (product: _logoTShirt, colorName: 'Green', color: Color(0xFF2E7D32)),
  ];

  static const cart = <DummyCartItem>[
    (
      product: _duramo,
      colorName: 'Orange',
      color: Color(0xFFB8321F),
      size: 40,
      quantity: 1,
    ),
    (
      product: _hoops,
      colorName: 'White',
      color: Color(0xFFE0E0E0),
      size: 42,
      quantity: 2,
    ),
  ];

  static const DummyUser user = (
    name: 'Mohamed Mohamed Nabil',
    email: 'mohamed.N@gmail.com',
    password: 'password123',
    phone: '01122118855',
    address: '6th October, street 11',
  );
}
