import 'package:deliverly_app/models/address.dart';

import 'pay_card.dart';

abstract class AppUser {
  final String id;
  final String name;
  final String phone;

  const AppUser({
    required this.id,
    required this.name,
    required this.phone,
  });
  toMap() {}

  copyWith() {}
}

class Client extends AppUser {
  final PayCard card;
  final Address? address;

  const Client({
    required this.card,
    this.address,
    required String id,
    required String name,
    required String phone,
  }) : super(
          id: id,
          name: name,
          phone: phone,
        );

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'card': card.toMap(),
      'address': address,
    };
  }

  factory Client.fromMap(Map<String, dynamic> map) {
    return Client(
      card: PayCard.fromMap(map['card']),
      address: map['address'] != null ? Address.fromMap(map['address']) : null,
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

  @override
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
      description: map['description'] ?? '',
      photo: map['photo'] ?? '',
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
    );
  }
}
