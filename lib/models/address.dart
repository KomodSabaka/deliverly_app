class Address {
  final String street;
  final String entrance;
  final String apartment;

  const Address({
    required this.street,
    required this.entrance,
    required this.apartment,
  });

  Map<String, dynamic> toMap() {
    return {
      'street': street,
      'entrance': entrance,
      'apartment': apartment,
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      street: map['street'] ?? '',
      entrance: map['entrance'] ?? '',
      apartment: map['apartment'] ?? '',
    );
  }
}