import 'dart:convert';
import 'package:flutter/services.dart';
import 'brand_data.dart';

abstract final class BrandConfig {
  static late BrandData _current;

  static BrandData get current => _current;

  static Future<void> load() async {
    final json = await rootBundle.loadString('assets/brand/brand.json');
    _current = BrandData.fromJson(jsonDecode(json) as Map<String, dynamic>);
  }
}
