// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/datasources/product_local_datasource.dart';
import '../../../../data/datasources/product_remote_datasource.dart';
import '../../../../data/models/response/product_response_model.dart';

part 'product_bloc.freezed.dart';
part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRemoteDatasource _productRemoteDatasource;
  List<Product> products = [];

  ProductBloc(
    this._productRemoteDatasource,
  ) : super(const _Initial()) {
    on<_Fetch>((event, emit) async {
      emit(const _Loading());

      final response = await _productRemoteDatasource.getProducts();

      response.fold(
        (l) => emit(_Error(l)),
        (r) {
          products = r.data;
          emit(_Success(r.data));
        },
      );
    });

    on<_FetchLocal>((event, emit) async {
      emit(const _Loading());

      final responseLocalProduct =
          await ProductLocalDatasource.instance.getAllProduct();

      products = responseLocalProduct;

      emit(_Success(products));
    });

    on<_FetchByCategory>((event, emit) async {
      emit(const _Loading());

      final findProductByCategory = event.category == "all"
          ? products
          : products
              .where((product) =>
                  product.categoryString.toLowerCase() ==
                  event.category.toLowerCase())
              .toList();

      emit(_Success(findProductByCategory));
    });

    on<_SearchProductByName>((event, emit) async {
      emit(const _Loading());

      final searchProductByName = products
          .where((product) =>
              product.name.toLowerCase().contains(event.name.toLowerCase()))
          .toList();

      emit(_Success(searchProductByName));
    });
  }
}
