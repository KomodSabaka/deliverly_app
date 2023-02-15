class CompanyModel {
  final String id;
  final String nameCompany;
  final String descriptionCompany;
  final String phoneNumberCompany;
  final String photo;

  const CompanyModel({
    required this.id,
    required this.nameCompany,
    required this.descriptionCompany,
    required this.phoneNumberCompany,
    required this.photo,
  });

  CompanyModel copyWith({
    String? id,
    String? nameCompany,
    String? descriptionCompany,
    String? phoneNumberCompany,
    String? photo,
  }) {
    return CompanyModel(
      id: id ?? this.id,
      nameCompany: nameCompany ?? this.nameCompany,
      descriptionCompany: descriptionCompany ?? this.descriptionCompany,
      phoneNumberCompany: phoneNumberCompany ?? this.phoneNumberCompany,
      photo: photo ?? this.photo,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nameCompany': nameCompany,
      'descriptionCompany': descriptionCompany,
      'phoneNumberCompany': phoneNumberCompany,
      'photo': photo,
    };
  }

  static CompanyModel? fromMap(Map<String, dynamic> map) {
    try{
      return CompanyModel(
        id: map['id'] ?? '',
        nameCompany: map['nameCompany'] ?? '',
        descriptionCompany: map['descriptionCompany'] ?? '',
        phoneNumberCompany: map['phoneNumberCompany'] ?? '',
        photo: map['photo'] ?? '',
      );
    } catch (e) {
      return null;
    }

  }
}