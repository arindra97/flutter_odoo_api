import 'dart:convert';

import 'package:flutter_crud/models/res_partner.dart';
import 'package:http/http.dart' as http;

class ResPartnerService {
  // Change IP Address with url odoo
  static const String baseUrl = 'http://192.168.18.15:8069/api';

  /// The function fetches a list of ResPartner objects from a specified URL using HTTP GET request in
  /// Dart.
  ///
  /// Returns:
  ///   The `fetchResPartner` function returns a `Future` that resolves to a list of `ResPartner`
  /// objects fetched from a remote API endpoint.
  static Future<List<ResPartner>> fetchResPartner() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/res_partner'));
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

  /// This Dart function sends a POST request to create a new ResPartner with the provided data.
  ///
  /// Args:
  ///   request (ResPartner): The `createResPatner` function takes a `ResPartner` object named `request`
  /// as a parameter. The `ResPartner` class likely contains properties such as `name`, `email`,
  /// `phone`, `street`, `city`, and `zip` that are used to create a new
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

  /// This Dart function sends a PUT request to update a ResPartner object with the provided ID and
  /// request data.
  ///
  /// Args:
  ///   id (int): The `id` parameter in the `updateResPartner` function represents the unique identifier
  /// of the ResPartner entity that you want to update. It is used to construct the URL for the PUT
  /// request to the API endpoint that handles the update operation for the specific ResPartner entity
  /// with the given ID.
  ///   request (ResPartner): The `updateResPartner` function takes two parameters:
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

  /// This Dart function deletes a res_partner with the specified ID using an HTTP DELETE request.
  ///
  /// Args:
  ///   id (int): The `id` parameter in the `deleteResPartner` function is the identifier of the
  /// resource partner that you want to delete. It is used to construct the URL for the DELETE request
  /// to the API endpoint.
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
