import 'pay_card.dart';

class AppUser {
  final String id;
  final String name;
  final String phone;

  const AppUser({
    required this.id,
    required this.name,
    required this.phone,
  });
}

class Client extends AppUser {
  final PayCard card;

  const Client({
    required this.card,
    required String id,
    required String name,
    required String phone,
  }) : super(
          id: id,
          name: name,
          phone: phone,
        );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'card': card.toMap(),
    };
  }

  factory Client.fromMap(Map<String, dynamic> map) {
    return Client(
      card: PayCard.fromMap(map['card']),
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
    );
  }
}

class Seller extends AppUser {
  final String description;
  final String? photo;

  const Seller({
    required this.description,
    required this.photo,
    required String id,
    required String name,
    required String phone,
  }) : super(
          id: id,
          name: name,
          phone: phone,
        );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'description': description,
      'photo': photo,
    };
  }

  factory Seller.fromMap(Map<String, dynamic> map) {
    return Seller(
      description: map['description'] as String,
      photo: map['photo'] ?? '',
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
    );
  }
}
