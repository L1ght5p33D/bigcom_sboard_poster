import 'dart:convert';
import 'package:bigcom_surfboard_poster/bc_products_cache.dart';
import 'package:http/http.dart' as http;

String? bc_prod_resp;

Future<String> get_bc_products() async {

//   final response = await http.get(bc_get_store_products_url, headers: bc_api_headers);
//   final responseJson = json.decode(response.body);
//   print("get_bc_products resp nocache ::: ");
//   print(responseJson);
// // return json.encode(bc_cache);
//   return response.body;

// for testing don't make api call
  return json.encode(bc_prod_cache);
}

Future<String> post_bc_product(post_product)async{
  //   final response = await http.get(bc_post_store_products_url, headers: bc_api_headers);
  //{"name":"Create product from api 2","price":"11.00","categories":[23],
  // "weight":4,"type":"physical",
  // "images":[{"image_url":"https://upload.wikimedia.org/wikipedia/commons/7/7f/Anglel_Bless_Legendary_Hills_1_m%C4%9Bs%C3%ADc_st%C3%A1%C5%99%C3%AD.jpg"}]}
  return "created response";
}