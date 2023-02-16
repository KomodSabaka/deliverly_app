import 'pay_card.dart';

class Client {
  final String id;
  final String name;
  final String phone;
  final String photo;
  final PayCard card;

  const Client({
    required this.id,
    required this.name,
    required this.phone,
    required this.photo,
    required this.card,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'photo': photo,
      'card': card.toMap(),
    };
  }

  factory Client.fromMap(Map<String, dynamic> map) {
    return Client(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      photo: map['photo'] ?? '',
      card: PayCard.fromMap(map['card']),
    );
  }
}
