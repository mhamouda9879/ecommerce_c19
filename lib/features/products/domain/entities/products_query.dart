class ProductsQuery {
  final List<String>? categoryIds;
  final List<String>? subCategoryIds;
  final String? brandId;
  final num? minPrice;
  final num? maxPrice;

  // A field name, `-` for descending: 'price', '-price', '-sold', '-ratingsAverage'.
  final String? sort;
  final int? page;
  final int? limit;

  const ProductsQuery({
    this.categoryIds,
    this.subCategoryIds,
    this.brandId,
    this.minPrice,
    this.maxPrice,
    this.sort,
    this.page,
    this.limit,
  });
}
