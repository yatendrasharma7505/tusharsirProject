enum CompanyStatus { initial, loading, loaded, error }

class CompanyState {
  final CompanyStatus status;
  final List<dynamic>? companies;
  final String? errorMessage;

  const CompanyState({
    this.status = CompanyStatus.initial,
    this.companies,
    this.errorMessage,
  });

  CompanyState copyWith({
    CompanyStatus? status,
    List<dynamic>? companies,
    String? errorMessage,
  }) {
    return CompanyState(
      status: status ?? this.status,
      companies: companies ?? this.companies,
      errorMessage: errorMessage,
    );
  }
}
