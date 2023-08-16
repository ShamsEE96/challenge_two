import 'dart:convert';

import 'package:challenge_two/core/data/models/apis/product_model.dart';

class CartModel {
  int? count;
  double? total;
  ProductModel? productModel;

  CartModel({this.count, this.total, this.productModel});

  CartModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    total = json['total'];
    productModel = json['product_model'] != null
        ? new ProductModel.fromJson(json['product_model'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['total'] = this.total;
    if (this.productModel != null) {
      data['product_model'] = this.productModel!.toJson();
    }
    return data;
  }

  static Map<String, dynamic> toMap(CartModel model) {
    return {
      'count': model.count,
      'total': model.total,
      'product_model': model.productModel,
    };
  }

  static String encode(List<CartModel> list) => json.encode(
        list
            .map<Map<String, dynamic>>((element) => CartModel.toMap(element))
            .toList(),
      );

  static List<CartModel> decode(String strList) =>
      (json.decode(strList) as List<dynamic>)
          .map<CartModel>((item) => CartModel.fromJson(item))
          .toList();
}


// object => json => string
// object <= json <= string