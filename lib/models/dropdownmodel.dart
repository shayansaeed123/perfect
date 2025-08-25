

class DropdownItem {
  final String id;
  final String name;

  DropdownItem({required this.id, required this.name});

  factory DropdownItem.fromJson(Map<String, dynamic> json, String nameKey) {
    return DropdownItem(
      id: json['id'].toString(),
      name: json[nameKey].toString(),
    );
  }
}
