import 'package:flutter/material.dart';

// Temporary static data so the UI can be built before the data layer exists.
// Images and prices are real Route API data. Delete this file once the screens
// read from their view models.

typedef DummySubCategory = ({String name, String image});

typedef DummyCategory = ({
  String name,
  String image,
  List<DummySubCategory> subCategories,
});

typedef DummyProduct = ({
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
  static const _categories =
      'https://ecommerce.routemisr.com/Route-Academy-categories';

  static const categories = <DummyCategory>[
    (
      name: 'Men’s Fashion',
      image: '$_categories/1681511865180.jpeg',
      subCategories: [
        (name: 'T-shirts', image: '$_products/1680400287654-cover.jpeg'),
        (name: 'Hoodies', image: '$_products/1680399661234-cover.jpeg'),
        (name: 'Sweaters', image: '$_products/1680392991271-cover.jpeg'),
        (name: 'Shirts', image: '$_products/1680393143423-cover.jpeg'),
        (name: 'Pants', image: '$_products/1680395859874-cover.jpeg'),
        (name: 'Jackets', image: '$_products/1680391133207-cover.jpeg'),
        (name: 'Sneakers', image: '$_products/1680395631938-cover.jpeg'),
        (name: 'Boots', image: '$_products/1680400120400-cover.jpeg'),
        (name: 'Socks', image: '$_products/1680396038304-cover.jpeg'),
      ],
    ),
    (
      name: 'Women’s Fashion',
      image: '$_categories/1681511818071.jpeg',
      subCategories: [
        (name: 'Shawls', image: '$_products/1680403397402-cover.jpeg'),
        (name: 'Blouses', image: '$_products/1680402411833-cover.jpeg'),
        (name: 'Tunics', image: '$_products/1680402295928-cover.jpeg'),
        (name: 'Cardigans', image: '$_products/1680401893316-cover.jpeg'),
        (name: 'Joggers', image: '$_products/1680401672268-cover.jpeg'),
        (name: 'Socks', image: '$_products/1680401528864-cover.jpeg'),
      ],
    ),
    (
      name: 'Electronics',
      image: '$_categories/1681511121316.png',
      subCategories: [
        (name: 'Laptops', image: '$_products/1678301723274-cover.jpeg'),
        (name: 'Headphones', image: '$_products/1678302803089-cover.jpeg'),
        (name: 'Cameras', image: '$_products/1678304313006-cover.jpeg'),
        (name: 'TVs', image: '$_products/1678299332992-cover.jpeg'),
        (name: 'Printers', image: '$_products/1678304764905-cover.jpeg'),
        (name: 'Networking', image: '$_products/1678305677165-cover.jpeg'),
        (name: 'Video Games', image: '$_products/1678303526206-cover.jpeg'),
      ],
    ),
    (
      name: 'Mobiles',
      image: '$_categories/1681511156008.png',
      subCategories: [],
    ),
    (
      name: 'Beauty & Health',
      image: '$_categories/1681511179514.png',
      subCategories: [],
    ),
    (
      name: 'Baby & Toys',
      image: '$_categories/1681511427130.png',
      subCategories: [],
    ),
    (
      name: 'SuperMarket',
      image: '$_categories/1681511452254.png',
      subCategories: [],
    ),
    (name: 'Home', image: '$_categories/1681511392672.png', subCategories: []),
    (name: 'Books', image: '$_categories/1681511368164.png', subCategories: []),
    (
      name: 'Music',
      image: '$_categories/1681511964020.jpeg',
      subCategories: [],
    ),
  ];

  static const DummyProduct _duramo = (
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

  static const DummyProduct _softride = (
    title: 'Softride Enzo NXT Castlerock',
    description: 'Sole material: rubber. Colour name: red. Department: men.',
    imageCover: '$_products/1680399913757-cover.jpeg',
    images: [
      '$_products/1680399913850-1.jpeg',
      '$_products/1680399913850-2.jpeg',
      '$_products/1680399913851-3.jpeg',
    ],
    price: 2999,
    oldPrice: null,
    rating: 4.3,
    ratingsCount: 12,
    sold: 472,
  );

  static const DummyProduct _reactLive = (
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

  static const DummyProduct _orcaBoots = (
    title: 'Orca Leather Boots Anthracite',
    description:
        'Genuine and smooth leather upper. Secure lace-ups with side zipper '
        'closure. Slightly cushioned footbed provides comfort. Patterned '
        'chunky outsole provides traction.',
    imageCover: '$_products/1680400120400-cover.jpeg',
    images: [
      '$_products/1680400120769-1.jpeg',
      '$_products/1680400120770-2.jpeg',
      '$_products/1680400120771-3.jpeg',
    ],
    price: 3064,
    oldPrice: 4829,
    rating: 4.1,
    ratingsCount: 12,
    sold: 609,
  );

  static const DummyProduct _logoTShirt = (
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

  static const products = <DummyProduct>[
    _duramo,
    _hoops,
    _softride,
    _reactLive,
    _orcaBoots,
    _logoTShirt,
  ];

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
