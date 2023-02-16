class Seller {
  final String id;
  final String name;
  final String description;
  final String phone;
  final String photo;

  const Seller({
    required this.id,
    required this.name,
    required this.description,
    required this.phone,
    required this.photo,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'phone': phone,
      'photo': photo,
    };
  }

  static Seller? fromMap(Map<String, dynamic> map) {
    try {
      return Seller(
        id: map['id'] ?? '',
        name: map['name'] ?? '',
        description: map['description'] ?? '',
        phone: map['phone'] ?? '',
        photo: map['photo'] ?? '',
      );
    } catch (e) {
      return null;
    }
  }
}
