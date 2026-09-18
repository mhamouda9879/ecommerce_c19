abstract class CategoriesEvent {}

class GetCategoriesEvent extends CategoriesEvent {
  final int? limit;
  final int? page;
  final String? keyword;

  GetCategoriesEvent({this.limit, this.page, this.keyword});
}

class GetSubCategoriesEvent extends CategoriesEvent {
  final String categoryId;

  GetSubCategoriesEvent(this.categoryId);
}
