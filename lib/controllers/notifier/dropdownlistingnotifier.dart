// 🔹 provider.dart
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:project/models/dropdownmodel.dart';
import 'package:project/repo/utils.dart';

// Immutable class for params (better than Map)
class DropdownParams {
  final String url;
  final String key;
  const DropdownParams(this.url, this.key);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DropdownParams &&
          runtimeType == other.runtimeType &&
          url == other.url &&
          key == other.key;

  @override
  int get hashCode => url.hashCode ^ key.hashCode;
}

final dropdownProvider =
    FutureProvider.family<List<DropdownItem>, DropdownParams>((ref, params) async {
  final response = await http.get(Uri.parse('${Utils.baseUrl}masterapi.php?${params.url}'));
  await Future.delayed(const Duration(seconds: 1)); // simulate network delay

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    // print(data);
    final rootKey = data.keys.first; // dynamic key: "specification", "Year", etc.
    final List items = data[rootKey];

    return items.map((e) => DropdownItem.fromJson(e, params.key)).toList();
  } else {
    throw Exception("Failed to load data");
  }
});

final modelProvider = FutureProvider.family<List<DropdownItem>, String>((ref, makeId) async {
  final response = await http.get(
    Uri.parse('${Utils.baseUrl}masterapi.php?make_id=$makeId'),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final rootKey = data.keys.first; // e.g. "Model"
    final List items = data[rootKey];

    return items.map((e) => DropdownItem.fromJson(e, "model_name")).toList();
  } else {
    throw Exception("Failed to load models");
  }
});

final trimProvider = FutureProvider.family<List<DropdownItem>, String>((ref, modelId) async {
  final response = await http.get(
    Uri.parse('${Utils.baseUrl}masterapi.php?model_id=$modelId'),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final rootKey = data.keys.first; // e.g. "Model"
    final List items = data[rootKey];

    return items.map((e) => DropdownItem.fromJson(e, "trim_name")).toList();
  } else {
    throw Exception("Failed to load models");
  }
});
