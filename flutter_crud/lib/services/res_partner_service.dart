import 'dart:convert';

import 'package:flutter_crud/models/res_partner.dart';
import 'package:http/http.dart' as http;

class ResPartnerService {
  static const String baseUrl = 'http://192.168.18.15:8069/api';
  // static final queryParams = {'limit': '15', 'offset': '15'};

  static Future<List<ResPartner>> fetchResPartner() async {
    try {
      final response = await http.get(
        Uri.parse(
          '$baseUrl/res_partner',
        ), //.replace(queryParameters: queryParams),
      );
      final body = response.body;
      final result = jsonDecode(body);
      List<ResPartner> resPartners = List<ResPartner>.from(
        result['data'].map((resPartner) => ResPartner.fromJson(resPartner)),
      );
      return resPartners;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<void> createResPatner(ResPartner request) async {
    try {
      await http.post(
        Uri.parse('$baseUrl/res_partner'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'params': <String, dynamic>{
            // Nest the data inside "params"
            'name': request.name,
            'email': request.email,
            'phone': request.phone,
            'street': request.street,
            'city': request.city,
            'zip': request.zip,
          },
        }),
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<void> updateResPartner(int? id, ResPartner request) async {
    try {
      await http.put(
        Uri.parse('$baseUrl/res_partner/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'params': <String, dynamic>{
            // Nest the data inside "params"
            'name': request.name,
            'email': request.email,
            'phone': request.phone,
            'street': request.street,
            'city': request.city,
            'zip': request.zip,
          },
        }),
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<void> deleteResPartner(int? id) async {
    try {
      await http.delete(
        Uri.parse('$baseUrl/res_partner/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({}),
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
