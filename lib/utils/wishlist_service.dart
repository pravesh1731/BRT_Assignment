import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class WishlistService {
  static const String key = "wishlist";

  static Future<List<int>> getWishlist() async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getString(key);

    if (data == null) return [];

    return List<int>.from(jsonDecode(data));
  }

  static Future<void> saveWishlist(List<int> ids) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(key, jsonEncode(ids),
    );
  }
}