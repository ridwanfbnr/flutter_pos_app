part of 'product_bloc.dart';

@freezed
class ProductEvent with _$ProductEvent {
  const factory ProductEvent.started() = _Started;
  const factory ProductEvent.fetch() = _Fetch;
  const factory ProductEvent.searchProductByName(String name) =
      _SearchProductByName;
  const factory ProductEvent.fetchByCategory(String category) =
      _FetchByCategory;
  const factory ProductEvent.fetchLocal() = _FetchLocal;
}
