enum CategoryStatus { initial, loading, loaded, error }

class CategoryState {
  final CategoryStatus status;
  final List<dynamic>? categories;
  final String? errorMessage;

  const CategoryState({
    this.status = CategoryStatus.initial,
    this.categories,
    this.errorMessage,
  });

  CategoryState copyWith({
    CategoryStatus? status,
    List<dynamic>? categories,
    String? errorMessage,
  }) {
    return CategoryState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      errorMessage: errorMessage,
    );
  }
}
