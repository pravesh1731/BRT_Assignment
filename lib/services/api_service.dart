
import 'package:brt_assignment/models/product_model.dart';
import 'package:dio/dio.dart';

class ApiService {
  final Dio dio = Dio();

  Future<List<Product>> getProduct({
    int limit = 10,
    int skip = 0,
}) async {
    try{
      final res = await dio.get("https://dummyjson.com/products",queryParameters: {
        'limit': limit,
        'skip': skip,
      });
      if (res.statusCode == 200) {
        List<Product> products = (res.data["products"] as List)
            .map((product) => Product.fromJson(product))
            .toList();
        print(products);
        return products;

      } else {
        throw Exception("Failed to load products");
      }
  }catch(e){
    print("Error fetching products: $e");
    throw Exception("Error fetching products");
    }
 }
}