class CardModel {
  final String cardNumber;
  final String cardName;
  final String cardDate;
  final String cardRCV;

  const CardModel({
    required this.cardNumber,
    required this.cardName,
    required this.cardDate,
    required this.cardRCV,
  });

  CardModel copyWith({
    String? cardNumber,
    String? cardName,
    String? cardDate,
    String? cardRCV,
  }) {
    return CardModel(
      cardNumber: cardNumber ?? this.cardNumber,
      cardName: cardName ?? this.cardName,
      cardDate: cardDate ?? this.cardDate,
      cardRCV: cardRCV ?? this.cardRCV,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cardNumber': cardNumber,
      'cardName': cardName,
      'cardDate': cardDate,
      'cardRCV': cardRCV,
    };
  }

  factory CardModel.fromMap(Map<String, dynamic> map) {
    return CardModel(
      cardNumber: map['cardNumber'] ?? '',
      cardName: map['cardName'] ?? '',
      cardDate: map['cardDate'] ?? '',
      cardRCV: map['cardRCV'] ?? '',
    );
  }
}