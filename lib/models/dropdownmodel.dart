

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

class StatusItem {
final String id;
final String name;


StatusItem({required this.id, required this.name});


factory StatusItem.fromJson(Map<String, dynamic> json) {
return StatusItem(
id: json['id'].toString(),
name: json['status_name'].toString(),
);
}
}