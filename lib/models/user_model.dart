import 'package:flutter/material.dart';

import 'card_model.dart';

class UserModel {
  final String id;
  final String name;
  final String phone;
  final String urlPhoto;
  final CardModel card;

  const UserModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.urlPhoto,
    required this.card,
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? phone,
    String? urlPhoto,
    CardModel? card,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      urlPhoto: urlPhoto ?? this.urlPhoto,
      card: card ?? this.card,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'urlPhoto': urlPhoto,
      'card': card.toMap(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      urlPhoto: map['urlPhoto'] ?? '',
      card:CardModel.fromMap(map['card']),
    );
  }
}